Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbULOAS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbULOAS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbULOASw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:18:52 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:5131 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261718AbULNX4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:56:07 -0500
Date: Wed, 15 Dec 2004 00:56:01 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Heath <chris@heathens.co.nz>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Improved console UTF-8 support for the Linux kernel?
Message-ID: <20041214235601.GA4681@pclin040.win.tue.nl>
References: <1102920623.30543.1820.camel@linux.heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102920623.30543.1820.camel@linux.heathens.co.nz>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 01:50:24AM -0500, Chris Heath wrote:

> Logically, keyboard input and console display are separated in the
> kernel. When you switch in and out of Unicode mode you have to switch
> both the keyboard and the display separately.  However, this patch
> intertwines the two because it does its 8-bit to Unicode conversion
> using a table that is designed for use by the display module.
> 
> I have a couple of other patches on my website, which I am happy to
> submit (or you are welcome to take), but this is the simplest and the
> most popular.

Wouldnt mind looking at your other patches.
Will not submit this one - perhaps someone else likes it.
I consider the below completely unacceptable.

You cannot use knowledge about the setup of the output side
in the keyboard handler. These are independent in principle.

Andries


> +u32 conv_8bit_to_uni(unsigned char c)
> +{
> +	/* 
> +	 * Always use USER_MAP. This function is used by the keyboard,
> +	 * which shouldn't be affected by G0/G1 switching, etc.
> +	 * If the user map still contains default values, i.e. the 
> +	 * direct-to-font mapping, then assume user is using Latin1.
> +	 */
> +	unsigned short uni = translations[USER_MAP][c];
> +	return uni == (0xf000 | c) ? c : uni;
> +}
