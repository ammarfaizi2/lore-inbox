Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSIXXyP>; Tue, 24 Sep 2002 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSIXXyO>; Tue, 24 Sep 2002 19:54:14 -0400
Received: from pheriche.sun.com ([192.18.98.34]:640 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S261853AbSIXXyO>;
	Tue, 24 Sep 2002 19:54:14 -0400
Message-ID: <3D90FC5C.9090807@sun.com>
Date: Tue, 24 Sep 2002 16:59:24 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <200209250832.35068.bhards@bigpond.net.au> <3D90F5D3.4070504@pobox.com> <200209250937.20887.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:

>>You really want something where a userspace app can sleep on an fd, to
>>be awakened when link changes (or some other interesting event occurs)
> 
> Maybe - I've been thinking of a "hotplug" daemon, that can take notifications 
> from the kernel _and_ from other userspace apps. The integrated solution 
> somehow needs to incorporate device hotplugging (eg USB, PCI), network device 
> events (netlink), userspace reconfiguration (eg X colour depth and 
> resolution) and maybe network infrastructure (external to the machine, 
> probably SLPv2 or similar), and reconfigure kernel and applications to match.

See my previous about acpid - it is capable of most of this.  In short:

Open kernel event file
read config files: map regexes to actions
open a named UNIX socket
while 1
	wait for event or data on socket
	if it's an event {
		read event
		for each config'ed regex {
			if it matches this event
				run the associated action
		}
		for each UNIX connection {
			notify the connection of the event
		}
	} else if it's a connection on the socket {
		add the connection to the list of notifications
	}
}


Now it would be easy to make UNIX-connecting apps specify one or more 
regexes, instead of getting broadcasted.  It would be similarly easy to 
make it read multiple sources and handle that - acpi, dev_events, 
user_events (UNIX socket or FIFO).

http://acpid.sourceforge.net  - it's kind of stale, because it does 
everything it needs to do for now :)  It's small, well tested and easy 
to understand.  Best of all, it's already written.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

