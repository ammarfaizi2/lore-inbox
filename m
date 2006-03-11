Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWCKXtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWCKXtF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCKXtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:49:05 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:7589 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751268AbWCKXtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:49:04 -0500
Date: Sat, 11 Mar 2006 17:48:41 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
       akpm@osdl.org
Subject: Re: [PATCH] crypto: fix key alignment in tcrypt
Message-ID: <20060311234841.GI28168@waste.org>
References: <20060308.231155.63512624.nemoto@toshiba-tops.co.jp> <20060311231238.GJ7110@waste.org> <jeirqktvb0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeirqktvb0.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 12:29:07AM +0100, Andreas Schwab wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > On Wed, Mar 08, 2006 at 11:11:55PM +0900, Atsushi Nemoto wrote:
> >> Force 32-bit alignment on keys in tcrypt test vectors.
> >> 
> >> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >> 
> >> diff --git a/crypto/tcrypt.h b/crypto/tcrypt.h
> >> index 733d07e..050f852 100644
> >> --- a/crypto/tcrypt.h
> >> +++ b/crypto/tcrypt.h
> >> @@ -31,7 +31,7 @@ struct hash_testvec {
> >>  	char digest[MAX_DIGEST_SIZE];
> >>  	unsigned char np;
> >>  	unsigned char tap[MAX_TAP];
> >> -	char key[128]; /* only used with keyed hash algorithms */
> >> +	char key[128] __attribute__((__aligned__(4))); /* only used with keyed hash algorithms */
> >>  	unsigned char ksize;
> >>  };
> >>  
> >> @@ -48,7 +48,7 @@ struct hmac_testvec {
> >>  struct cipher_testvec {
> >>  	unsigned char fail;
> >>  	unsigned char wk; /* weak key flag */
> >> -	char key[MAX_KEYLEN];
> >> +	char key[MAX_KEYLEN] __attribute__((__aligned__(4)));
> >>  	unsigned char klen;
> >>  	char iv[MAX_IVLEN];
> >>  	char input[48];
> >
> > Wouldn't it be better to simply move this to the head of the structure?
> 
> That wouldn't help, since the whole structure will still be only 8-bit
> aligned.

Ahh, hadn't noticed the struct was entirely populated by chars.

-- 
Mathematics is the supreme nostalgia of our time.
