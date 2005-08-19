Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVHSNBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVHSNBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHSNBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:01:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57775 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964941AbVHSNBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:01:14 -0400
Date: Fri, 19 Aug 2005 15:00:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH for 2.6.13] iSeries build with newer assemblers and compilers
Message-ID: <20050819130056.GC2089@elf.ucw.cz>
References: <17154.43166.351018.356055@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17154.43166.351018.356055@cargo.ozlabs.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Paulus suggested that we put xLparMap in its own .c file so that we can
> generate a .s file to be included into head.S.  This doesn't get around
> the problem of having it at a fixed address, but it makes it more
> palatable.

This is probably too late, but....
> -#if 0
>  struct HvReleaseData hvReleaseData = {
>  	.xDesc = 0xc8a5d9c4,	/* "HvRD" ebcdic */
>  	.xSize = sizeof(struct HvReleaseData),
>  	.xVpdAreasPtrOffset = offsetof(struct naca_struct, xItVpdAreas),
>  	.xSlicNacaAddr = &naca,		/* 64-bit Naca address */
> -	.xMsNucDataOffset = (u32)((unsigned long)&xLparMap - KERNELBASE),
> +	.xMsNucDataOffset = LPARMAP_PHYS,
>  	.xFlags = HVREL_TAGSINACTIVE	/* tags inactive       */
>  					/* 64 bit              */
>  					/* shared processors   */

These are extremely ugly cases of hungarian notation...
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
