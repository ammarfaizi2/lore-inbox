Return-Path: <linux-kernel-owner+w=401wt.eu-S1752764AbWLOQpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbWLOQpH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbWLOQpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:45:06 -0500
Received: from mail.tmr.com ([64.65.253.246]:54192 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbWLOQpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:45:05 -0500
Message-ID: <4582D246.3010701@tmr.com>
Date: Fri, 15 Dec 2006 11:50:14 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc1
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, the two-week merge period is over, and -rc1 is out there.
> 
> I'm _really_ hoping that we can keep the 2.6.20 release calmer and without 
> any of the dragging-out-due-to-core-changes that we've had lately. We 
> didn't actually merge any really core changes here, with the biggest 
> conceptual one being the "work_struct" split into regular work and 
> "delayed" work, so I'm hoping we can really end up with an easy 2.6.20 
> release.
> 
> Some of the commits there are pretty big patches, but more than a couple 
> of them are due to fairly straightforward search-and-replace things (like 
> a largely scripted removal of unnecessary casts of the return value of 
> "kmalloc()", for example, or the switch to "ktermios" for the tty layer, 
> or the introduction of "struct path" in the VFS layer instead of keeping 
> the f_{dentry,vfsmnt} entries separate, or indeed the removal of SLAB_xxx 
> constant names in favour of the standard GFP_xxx ones).
> 
> So while the patch itself isn't actually all that much smaller than usual, 
> at least my personal gut feel is that the actual changes are not as 
> intrusive, just in some cases have big diffs.
> 
> But both the diffstat and the shortlog are still too big to fit in the 
> kernel mailing list limits, so you'll just have to take my word for it. Or 
> get the git repo, and do your own delving into things with
> 
> 	git log v2.6.19..v2.6.20-rc1 | git shortlog
> 
> There _are_ a few areas of note:
> 
>  - the aforementioned "workqueue" changes (where we still have some work 
>    to do to finalize the proper actions on all architectures: it's being 
>    somewhat discussed on the arch mailing lists, hopefully we'll have it 
>    all resolved by -rc2, and it doesn't really worry me)
> 
>  - lockless page cache (RCU lookups of radix trees)
> 
>  - kvm driver for all those crazy virtualization people to play with
> 
>  - networking updates (DCCP, address-family agnostic connection tracking 
>    in netfilter, sparse byte order annotations, yadda yadda)
> 
>  - HID layer separated out of the USB stuff (bluetooth apparently wants 
>    the HID stuff too)
> 
>  - tons and tons of driver (ftape removal, ATA, pcmcia, i2c, 
>    infiniband, dvb, networking..) and architecture updates (arm, mips, 
>    powerpc, sh)
> 
Did I miss an alternate method of handling ftape devices, or are these 
old beasts now unsupported? I occasionally have to be able to handle 
that media, since the industrial device using ftape for control updates 
cost more than a small house.

I can obviously keep an old slow machine to do the job, but I'd like to 
know if I need to.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
