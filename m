Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVAWCEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVAWCEb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVAWCEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:04:31 -0500
Received: from smtpout.mac.com ([17.250.248.88]:4849 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261168AbVAWCE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:04:29 -0500
In-Reply-To: <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: [patch 1/13] Qsort
Date: Sun, 23 Jan 2005 03:03:32 +0100
To: vlobanov <vlobanov@speakeasy.net>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2005, at 22:00, vlobanov wrote:

> Hi,
>
> I was just reading over the patch, and had a quick question/comment 
> upon
> the SWAP macro defined below. I think it's possible to do a tiny bit
> better (better, of course, being subjective), as follows:
>
> #define SWAP(a, b, size)			\
>     do {					\
> 	register size_t __size = (size);	\
> 	register char * __a = (a), * __b = (b);	\
> 	do {					\
> 	    *__a ^= *__b;			\
> 	    *__b ^= *__a;			\
> 	    *__a ^= *__b;			\
> 	    __a++;				\
> 	    __b++;				\
> 	} while ((--__size) > 0);		\
>     } while (0)
>
> What do you think? :)

AFAIK, XOR is quite expensive on IA32 when compared to simple MOV 
operatings. Also, since the original patch uses 3 MOVs to perform the 
swapping, and your version uses 3 XOR operations, I don't see any 
gains.

Am I missing something?

