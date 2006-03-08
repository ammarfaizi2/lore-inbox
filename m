Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWCHOJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWCHOJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWCHOJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:09:53 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:558 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1030192AbWCHOJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:09:52 -0500
Date: Wed, 08 Mar 2006 23:09:49 +0900 (JST)
Message-Id: <20060308.230949.133381156.nemoto@toshiba-tops.co.jp>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: alignment fixes
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060308102731.GA32195@gondor.apana.org.au>
References: <20060308.160529.37994551.nemoto@toshiba-tops.co.jp>
	<20060308102731.GA32195@gondor.apana.org.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 8 Mar 2006 21:27:31 +1100, Herbert Xu <herbert@gondor.apana.org.au> said:
>> This patch fixes some alignment problem on crypto modules.

herbert> Thanks for the patch.  Please split this up and cc
herbert> linux-crypto@vger.kernel.org.

OK, I'll send soon.

>> 1. Many cipher setkey functions load key words directly but the key
>> words might not be aligned.  Enforce correct alignment in the
>> setkey wrapper.

herbert> This isn't right.  The alignmask applies to
herbert> source/destination buffers only.  The only requirement on the
herbert> key is that it must always be 32-bit aligned.

Thank you for clarification.  The tcrypt module breaks this
requirement currently.  I'll fix tcrypt.

>> 3. Some hash modules (and sha_transform() library function)
>> load/store data words directly.  Use
>> get_unaligned()/put_unaligned() for them.

herbert> We should extend alignmask to cover this and handle it in the
herbert> digest layer.

OK, I'll try it.  Thank you.

---
Atsushi Nemoto
