Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVG1Wa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVG1Wa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVG1W2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:28:49 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:33921 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261643AbVG1W0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:26:24 -0400
Message-ID: <42E95B83.8070006@cosmosbay.com>
Date: Fri, 29 Jul 2005 00:26:11 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] random : prefetch the whole pool, not 1/4 of it
References: <20050407212058.GU3174@waste.org>
In-Reply-To: <20050407212058.GU3174@waste.org>
Content-Type: multipart/mixed;
 boundary="------------050808020003040605050501"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Fri, 29 Jul 2005 00:26:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050808020003040605050501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

Could you check this patch and apply it ?

Thank you

Eric

[RANDOM] : prefetch the whole pool, not 1/4 of it,
            (pool contains u32 words, not bytes)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------050808020003040605050501
Content-Type: text/plain;
 name="patch.random"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.random"

--- linux-2.6.13-rc3/drivers/char/random.c	2005-07-13 06:46:46.000000000 +0200
+++ linux-2.6.13-rc3-ed/drivers/char/random.c	2005-07-29 00:11:24.000000000 +0200
@@ -469,7 +469,7 @@
 	next_w = *in++;
 
 	spin_lock_irqsave(&r->lock, flags);
-	prefetch_range(r->pool, wordmask);
+	prefetch_range(r->pool, wordmask*4);
 	input_rotate = r->input_rotate;
 	add_ptr = r->add_ptr;
 

--------------050808020003040605050501--
