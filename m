Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbULGJGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbULGJGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULGJGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:06:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:41361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261764AbULGJF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:05:59 -0500
Date: Tue, 7 Dec 2004 01:05:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Georg Schild <dangertools@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc[2|3] protection fault on /proc/devices
Message-Id: <20041207010537.103c0be5.akpm@osdl.org>
In-Reply-To: <41B56A58.8050404@gmx.net>
References: <41B4E70F.8040306@gmx.net>
	<20041206234044.51667e94.akpm@osdl.org>
	<41B56A58.8050404@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please don't edit the email headers - just do reply-to-all)

Georg Schild <dangertools@gmx.net> wrote:
>
> Andrew Morton wrote:
> > Georg Schild <dangertools@gmx.net> wrote:
> > 
> >>Since 2.6.10-rc2 I am having problems accessing /proc/devices. On 
> >>startup some init-skripts access this node and print out a protection 
> >>fault. i am having this on pcmcia and swap startup. My system is an 
> >>amd64 @3000+ in an Acer Aspire 1501Lmi at 64bit mode running gentoo. 
> >>.config is the same as on 2.6.10-rc1 which works good. cat on 
> >>/proc/devices gives the same problems. The kernel has just a patch for 
> >>wbsd (builtin mmc-cardreader) from Pierre Ossman in use, everything else 
> >>is vanilla. Does anyone know of this issue and perhaps on how to solve this?
>  >>
>  >>
> > How odd.  All I can think is that something has registered a zillion
> > devices and get_blkdev_list() has run off the /proc page.  But then, it
> > should have oopsed in sprintf()..
> > 
> > Still.  Please send a copy of your /proc/devices from 2.6.10-rc1 and also
> > apply this:
> >
> > to 2.6.10-rc3 and see if that fixes it.  If so, please send the
> > /proc/devices content from this kernel.
> > 
> > Beyond that, perhaps something scribbled on the data structures in there. 
> > Setting CONFIG_SLAB_DEBUG and/or CONFIG_DEBUG_PAGEALLOC might turn
> > something up.
> 
> I have tried now with applied patch against the vanilla-sources, that 
> means without the wbsd-patch, nothing changed. same is with the 
> wbsd-patch. i did a complete rebuild (make clean etc.) everytime. How 
> can i enable some debugging?
> 

make menuconfig
-> Kernel Hacking
  -> enable Debug memory allocations
