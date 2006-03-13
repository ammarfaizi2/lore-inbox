Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWCMKaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCMKaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCMKaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:30:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40903 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751232AbWCMKaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:30:18 -0500
Date: Mon, 13 Mar 2006 11:30:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Adrian Bunk <bunk@stusta.de>, davem@davemloft.net,
       linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/aes.c: array overrun
Message-ID: <20060313103006.GA3812@elf.ucw.cz>
References: <20060311010339.GF21864@stusta.de> <20060311024116.GA21856@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311024116.GA21856@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 11-03-06 13:41:16, Herbert Xu wrote:
> On Sat, Mar 11, 2006 at 02:03:39AM +0100, Adrian Bunk wrote:
> >
> > ...
> > #define loop8(i)                                    \
> 
> ...
> 
> >     t ^= E_KEY[8 * i + 7]; E_KEY[8 * i + 15] = t;   \
> > }
> > 
> > static int
> > aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
> > {
> > ...
> >         case 32:
> > ...
> >                 for (i = 0; i < 7; ++i)
> >                         loop8 (i);
> 
> OK this is not pretty but it is actually correct.  Notice how we only
                                  ~~~~~~~~~~~~~~~~~
> overstep the mark for E_KEY but never for D_KEY.  Since D_KEY is only
> initialised after this, it is OK for us to trash the start of D_KEY.
> 
> It's just a trick that makes the code slightly nicer (and no I didn't
> write this nor am I necessarily condoning it :)

Overstepping array is not correct C. Even if gcc lays it out in order
where array-to-be-thrashed is after it, so it works in practice, it is
not okay. [Some kind of security-hardened-gcc may stop this as buffer
overflow, for example]
								Pavel
-- 
161:    {
