Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbSIXT6b>; Tue, 24 Sep 2002 15:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbSIXT6b>; Tue, 24 Sep 2002 15:58:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261767AbSIXT6a>;
	Tue, 24 Sep 2002 15:58:30 -0400
Message-ID: <3D90C4FE.3070909@pobox.com>
Date: Tue, 24 Sep 2002 16:03:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Also related is "how can userspace be notified of kernel events?". There 
> is no way for a userspace app to be notified that, for instance, an ATM 
> device got a loss of signal.  The drivers print it out, but the 
> userspace app has no clue.

> Maybe netlink is the way to go, but its not exactly a simple interface.


Well, the eventual intention [whenever <somebody> codes it up] for 
ethernet devices is to have netlink proactively deliver link up/down 
events, and perhaps other events.  For this specific problem, at least, 
I think netlink is the way to go.  ATM drivers, or ethernet drivers, 
simply need some helper functions they can call.  The library code for 
those helper functions is the only place where netlink complexity is 
needed...

In existing drivers that call netif_carrier_{on,off}, it is perhaps even 
possible to have them send netlink messages with no driver-specific code 
changes at all.

	Jeff



