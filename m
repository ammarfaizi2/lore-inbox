Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTJJH5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJJH5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:57:11 -0400
Received: from rth.ninka.net ([216.101.162.244]:10657 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262497AbTJJH5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:57:08 -0400
Date: Fri, 10 Oct 2003 00:57:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: karim@opersys.com
Cc: jmorris@redhat.com, zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
       bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Message-Id: <20031010005703.0daf3e19.davem@redhat.com>
In-Reply-To: <3F859DF1.8000602@opersys.com>
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
	<3F859DF1.8000602@opersys.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Oct 2003 13:42:09 -0400
Karim Yaghmour <karim@opersys.com> wrote:

> 
> James Morris wrote:
> > It should be possible to make Netlink sockets mmapable (like the packet 
> > socket).
> 
> So would you consider running printk on Netlink sockets? Do you think Netlink
> could accomodate something as intensive as tracing? etc.

Of course it can.  Look, netlink is used on routers to transfer
hundreds of thousands of routing table entries in one fell swoop
between a user process and the kernel every time the next hop Cisco
has a BGP routing flap.

If you must have "enterprise wide client server" performance, we can
add mmap() support to netlink sockets just like AF_PACKET sockets support
such a thing.  But I _really_ doubt you need this and unlike netlink sockets
relayfs has no queueing model, whereas not only does netlink have one it's
been tested in real life.

You guys are really out of your mind if you don't just take the netlink
printk thing I did months ago and just run with it.  When someone first
told showed me this relayfs thing, I nearly passed out in disbelief that
people are still even considering non-netlink solutions.
