Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUIAR3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUIAR3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUIAR3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:29:00 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17096 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267403AbUIAR2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:28:38 -0400
Date: Wed, 1 Sep 2004 10:27:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: How to debug 2.6 PReP boot hang?
Message-ID: <20040901172751.GB19730@smtp.west.cox.net>
References: <20040816145347.GD2377@smtp.west.cox.net> <Pine.GSO.4.44.0408181853430.23535-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0408181853430.23535-100000@math.ut.ee>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 11:29:02PM +0300, Meelis Roos wrote:

> > > It's the one that reorganizes boot code:
> > > PPC32: Kill off arch/ppc/boot/prep and rearrange some files.
> >
> > Sadly, that is what I expected.  Try narrowing down the differences
> > between prep/head.S and simple/head.S (or rather head.s via make
> > arch/ppc/boot/prep/head.s and simple/head.s to strip out comments, etc).
[snip]
> Some more changes and the only difference is load_kernel vs
> decompress_kernel. Changing load_kernel call in relocate.S to
> decompress_kernel makes the kernel boot. Oh, finally.
> 
> BTW, the address of OF residual data bounces around in
> r3->r29->r4->r11->r6. The old code only did r3->r11->r6 but the new code
> uses r11 for cache disabling.
> 
> This is the patch I'm using currently. I understand that this is
> probably not the right patch for inclusion :)
> 
> ===== arch/ppc/boot/simple/relocate.S 1.11 vs edited =====
> --- 1.11/arch/ppc/boot/simple/relocate.S	2004-04-03 06:13:47 +03:00
> +++ edited/arch/ppc/boot/simple/relocate.S	2004-08-18 23:27:39 +03:00
> @@ -183,7 +183,7 @@
>  	mr	r5,r6		/* Checksum */
>  	mr	r6,r11		/* Residual data */
>  	mr	r7,r25		/* Validated OFW interface */
> -	bl	load_kernel
> +	bl	decompress_kernel
> 
>  	/*
>  	 * Make sure the kernel knows we don't have things set in

Interesting..  Can you do some nm'ing to see what versions of
load_kernel / decompress_kernel end up in your image on a stock config?
And what gcc / binutils versions are you using?

-- 
Tom Rini
http://gate.crashing.org/~trini/
