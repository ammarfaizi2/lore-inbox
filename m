Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCaKoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCaKoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCaKoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:44:21 -0500
Received: from [213.170.72.194] ([213.170.72.194]:11652 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261270AbVCaKnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:43:09 -0500
Subject: Re: [RFC] CryptoAPI & Compression
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
In-Reply-To: <20050331021909.GA27095@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
	 <20050326044421.GA24358@gondor.apana.org.au>
	 <1112030556.17983.35.camel@sauron.oktetlabs.ru>
	 <20050329103504.GA19468@gondor.apana.org.au>
	 <Pine.LNX.4.58.0503291252030.22838@phoenix.infradead.org>
	 <20050331021909.GA27095@gondor.apana.org.au>
Content-Type: text/plain
Organization: MTD
Date: Thu, 31 Mar 2005 14:43:06 +0400
Message-Id: <1112265786.21585.16.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Herbert,

> The GNU coding style is completely different from Linux.
Ok, NP.

> Please reformat it when you fix up the overhead calculation.
Sure.

> Good catch.  I'll apply this one.
Only one small note: I've spotted this but didn't test. I didn't make
sure this is OK if we haven't ever used the compression and remove the
deflate module. (i.e, in this case we call zlib_[in|de]flateEnd() while
we haven't ever called zlib_[in|de]flate()). Although I believe it must
be OK, we need to try it.

So please, test it or wait while I'll do it.

> The crypto API needs to operate on buffers that's bigger than that so
> we need to have a correct upper bound the maximum expansion.
Well, I'm still not sure. I guess that we call deflate with Z_SYNC_FLUSH
so most data is already in the output buffer and we only need to provide
some room for end markers and the like at the final Z_FINISH call. And I
guess 12 bytes is enough. But again, this is only my guess. I need to
delve into zlib internals to explore this.

So, it seems I can't just port the JFFS2 stuff. I need to explore zlib
more closely. Thus, I need some time. I'll inform you about my results.

> I believe this bit of code originally came from FreeS/WAN and was
> written by Svenning Srensen.  Maybe he or Yoshifuji-san can tell
> us why?
If you find some information about the issue, please, let me know.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

