Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbTHJOJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269514AbTHJOJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:09:18 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:6825 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269144AbTHJOJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:09:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Aug 2003 16:10:53 +0200
From: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
To: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
In-Reply-To: <20030810023606.GA15356@ghanima.endorphin.org>
References: <20030810023606.GA15356@ghanima.endorphin.org>
Message-Id: <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens writes:
> In loop_transfer_bio the initial vector has been computed only once. For any
> situation where more than one bio_vec is present the initial vector will be
> wrong. Here is the trivial but important fix. 

Looks good, but:
- I doubt this could explain the alteration pattern (1 byte every 512).
- Corruption also occured with cipher_null (which ignores the IV).

I just noticed a related thread: http://lkml.org/lkml/2003/8/6/313
("Device-backed loop broken in 2.6.0-test2?")


A side note: Doesn't crypto/crypto_null.c need this fix ?:

 static void null_encrypt(void *ctx, u8 *dst, const u8 *src)
-{ }
+{ memmove(dst, src, NULL_BLOCK_SIZE); }
 
 static void null_decrypt(void *ctx, u8 *dst, const u8 *src)
-{ }
+{ memmove(dst, src, NULL_BLOCK_SIZE); }

