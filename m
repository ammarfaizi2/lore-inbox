Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTJJP1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTJJP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:27:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11961 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262640AbTJJP1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:27:16 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
Message-ID: <16262.53132.204302.597010@gargle.gargle.HOWL>
Date: Fri, 10 Oct 2003 10:26:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: karim@opersys.com, jmorris@redhat.com, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
In-Reply-To: <20031010005703.0daf3e19.davem@redhat.com>
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
	<3F859DF1.8000602@opersys.com>
	<20031010005703.0daf3e19.davem@redhat.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
 > On Thu, 09 Oct 2003 13:42:09 -0400
 > Karim Yaghmour <karim@opersys.com> wrote:
 > 
 > > 
 > > James Morris wrote:
 > > > It should be possible to make Netlink sockets mmapable (like the packet 
 > > > socket).
 > > 
 > > So would you consider running printk on Netlink sockets? Do you think Netlink
 > > could accomodate something as intensive as tracing? etc.
 > 
 > Of course it can.  Look, netlink is used on routers to transfer
 > hundreds of thousands of routing table entries in one fell swoop
 > between a user process and the kernel every time the next hop Cisco
 > has a BGP routing flap.
 > 
 > If you must have "enterprise wide client server" performance, we can
 > add mmap() support to netlink sockets just like AF_PACKET sockets support
 > such a thing.  But I _really_ doubt you need this and unlike netlink sockets
 > relayfs has no queueing model, whereas not only does netlink have one it's
 > been tested in real life.
 > 
 > You guys are really out of your mind if you don't just take the netlink
 > printk thing I did months ago and just run with it.  When someone first
 > told showed me this relayfs thing, I nearly passed out in disbelief that
 > people are still even considering non-netlink solutions.
 > 

Well, if you add mmap() support, and remove all the dependencies
Netlink has on networking code, and add a non-sockets-based interface,
then you'd have something that could be used by everyone regardless of
whether they have networking configured in.  You'd also then have
something just as 'untested in real life' as relayfs, unless it really
does just boil down to some minor tweaks.

Some other things relayfs supports which I'm not sure (literally)
Netlink supports

- relay_write() can be called from any context
- relayfs has support for per-CPU buffering
- it doesn't require a memory allocation for each packet, so can be
  used in low-memory situations
- relayfs by design supports packet buffering, so can be used at boot time
- relayfs is reliable - the only way packets get dropped is if the
  buffer fills up, but this is addressed by a dynamic resizing
  capability, or by making the buffers larger to start out with.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

