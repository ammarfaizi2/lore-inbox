Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUD2CT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUD2CT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUD2CT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:19:26 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:25864 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262961AbUD2CTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:19:19 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083204591@astro.swin.edu.au>
Subject: Re:  ~500 megs cached yet 2.6.5 goes into swap hell
In-reply-to: <20040428184008.226bd52d.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40905127.3000001@fastclick.com> <20040428180038.73a38683.akpm@osdl.org> <4090595D.6050709@pobox.com> <20040428184008.226bd52d.akpm@osdl.org>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-11347-13791-200404291209-tc@hexane.ssi.swin.edu.au>
Date: Thu, 29 Apr 2004 12:19:02 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> said on Wed, 28 Apr 2004 18:40:08 -0700:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >  These are at the heart of the thread (or my point, at 
> > least) -- BloatyApp may be Oracle with a huge cache of its own, for 
> > which swapping out may be a huge mistake.  Or Mozilla.  After some 
> > amount of disk IO on my 512MB machine, Mozilla would be swapped out... 
> > when I had only been typing an email minutes before.
> 
> OK, so it takes four seconds to swap mozilla back in, and you noticed it.

Actually, about 20-30 seconds on all of my boxs (no, I have no idea
why so slow even on the P4 I have here - swapping has always seemed
overly slow on this machine, and yes, DMA is turned on) with a ~100MB
mozilla image (plus the parts of X that get swapped out and need to be
swapped in before the user sees any effect - X takes up about ~100MB
res memory typically here, since I tend to have so many apps with
cached pixmaps open and in current use).

> Did you notice that those three kernel builds you just did ran in twenty
> seconds less time because they had more cache available?  Nope.

Nope, because I never run 3 builds before rebooting - I do however run
a lot of software that only ever reads a file once (the file was
written on another host on the cluster, so the caching done at write
time is of no benefit to us here.

This is something that should be up to the admin, because the kernel
*cannot* know what I want. And I don't think /proc/.../swapiness is
enough to define what we want.

> > Regardless of /proc/sys/vm/swappiness, I think it's a valid concern of 
> > sysadmins who request "hard cache limit", because they are seeing 
> > pathological behavior such that apps get swapped out when cache is over 
> > 50% of all available memory.
> 
> We should be sceptical of this.  If they can provide *numbers* then fine. 
> Otherwise, the subjective "oh gee, that took a long time" seat-of-the-pants
> stuff does not impress.  If they want to feel better about it then sure,
> set swappiness to zero and live with less cache for the things which need
> it...

OK - I'll try to get around to giving you a vmstat 1 and maybe top
output, and timing things next time I run one of these big
visualisation jobs (it'd be very nice if this was all backported to
2.4, since this is what we are mostly using here -- I think I can find
a 2.6 machine though)...

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
My code is giving me mixed signals. SIGSEGV then SIGILL then SIGBUS. -- me
