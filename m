Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVAWEX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVAWEX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVAWEX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:23:28 -0500
Received: from waste.org ([216.27.176.166]:660 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261208AbVAWEXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:23:10 -0500
Date: Sat, 22 Jan 2005 20:22:41 -0800
From: Matt Mackall <mpm@selenic.com>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: vlobanov <vlobanov@speakeasy.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123042241.GH3867@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 03:03:32AM +0100, Felipe Alfaro Solana wrote:
> On 22 Jan 2005, at 22:00, vlobanov wrote:
> 
> >Hi,
> >
> >I was just reading over the patch, and had a quick question/comment 
> >upon
> >the SWAP macro defined below. I think it's possible to do a tiny bit
> >better (better, of course, being subjective), as follows:
> >
> >#define SWAP(a, b, size)			\
> >    do {					\
> >	register size_t __size = (size);	\
> >	register char * __a = (a), * __b = (b);	\
> >	do {					\
> >	    *__a ^= *__b;			\
> >	    *__b ^= *__a;			\
> >	    *__a ^= *__b;			\
> >	    __a++;				\
> >	    __b++;				\
> >	} while ((--__size) > 0);		\
> >    } while (0)
> >
> >What do you think? :)
> 
> AFAIK, XOR is quite expensive on IA32 when compared to simple MOV 
> operatings. Also, since the original patch uses 3 MOVs to perform the 
> swapping, and your version uses 3 XOR operations, I don't see any 
> gains.
> 
> Am I missing something?

No temporary variable needed in the xor version. mov and xor are
roughly the same speed, but xor modifies flags.

-- 
Mathematics is the supreme nostalgia of our time.
