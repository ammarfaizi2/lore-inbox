Return-Path: <linux-kernel-owner+w=401wt.eu-S1751910AbWLNCG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWLNCG4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 21:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWLNCG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 21:06:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40321 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbWLNCGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 21:06:55 -0500
Date: Wed, 13 Dec 2006 18:06:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.20-rc1
Message-ID: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the two-week merge period is over, and -rc1 is out there.

I'm _really_ hoping that we can keep the 2.6.20 release calmer and without 
any of the dragging-out-due-to-core-changes that we've had lately. We 
didn't actually merge any really core changes here, with the biggest 
conceptual one being the "work_struct" split into regular work and 
"delayed" work, so I'm hoping we can really end up with an easy 2.6.20 
release.

Some of the commits there are pretty big patches, but more than a couple 
of them are due to fairly straightforward search-and-replace things (like 
a largely scripted removal of unnecessary casts of the return value of 
"kmalloc()", for example, or the switch to "ktermios" for the tty layer, 
or the introduction of "struct path" in the VFS layer instead of keeping 
the f_{dentry,vfsmnt} entries separate, or indeed the removal of SLAB_xxx 
constant names in favour of the standard GFP_xxx ones).

So while the patch itself isn't actually all that much smaller than usual, 
at least my personal gut feel is that the actual changes are not as 
intrusive, just in some cases have big diffs.

But both the diffstat and the shortlog are still too big to fit in the 
kernel mailing list limits, so you'll just have to take my word for it. Or 
get the git repo, and do your own delving into things with

	git log v2.6.19..v2.6.20-rc1 | git shortlog

There _are_ a few areas of note:

 - the aforementioned "workqueue" changes (where we still have some work 
   to do to finalize the proper actions on all architectures: it's being 
   somewhat discussed on the arch mailing lists, hopefully we'll have it 
   all resolved by -rc2, and it doesn't really worry me)

 - lockless page cache (RCU lookups of radix trees)

 - kvm driver for all those crazy virtualization people to play with

 - networking updates (DCCP, address-family agnostic connection tracking 
   in netfilter, sparse byte order annotations, yadda yadda)

 - HID layer separated out of the USB stuff (bluetooth apparently wants 
   the HID stuff too)

 - tons and tons of driver (ftape removal, ATA, pcmcia, i2c, 
   infiniband, dvb, networking..) and architecture updates (arm, mips, 
   powerpc, sh)

and probably some I just forgot about entirely.

		Linus
