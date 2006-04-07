Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWDGF2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWDGF2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWDGF2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:28:05 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:56656 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S932264AbWDGF2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:28:03 -0400
Date: Fri, 07 Apr 2006 14:27:55 +0900 (JST)
Message-Id: <20060407.142755.55146269.nemoto@toshiba-tops.co.jp>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060406232454.GA27623@gondor.apana.org.au>
References: <20060405180520.GA15151@gondor.apana.org.au>
	<20060406.113742.15248428.nemoto@toshiba-tops.co.jp>
	<20060406232454.GA27623@gondor.apana.org.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2006 09:24:54 +1000, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Another thing, could you pleas change the stack allocation in final so
> that it does it like cbc_process_decrypt? The reason is that gcc is too
> stupid to not allocate that buffer unconditionally.

I can do it, but it will add another overhead.  (we must call
crypto_tfm_alg_digestsize() unconditionally)

It seems modern gcc (at least gcc 3.4 on i386 and mips) can allocate
the buffer conditionally.  It is better to optimize for newer gcc,
isn't it?

---
Atsushi Nemoto
