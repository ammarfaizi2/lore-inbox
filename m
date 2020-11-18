Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD9EC6369E
	for <io-uring@archiver.kernel.org>; Wed, 18 Nov 2020 14:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF60B24728
	for <io-uring@archiver.kernel.org>; Wed, 18 Nov 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjhEmCC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgKRO7m (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgKRO7m (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 18 Nov 2020 09:59:42 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D7C0613D6;
        Wed, 18 Nov 2020 06:59:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so2993574wmb.5;
        Wed, 18 Nov 2020 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAZ4Gpe58ZV2ebs7Q51DQZvJAPneBGNO7UtyyiC6OIY=;
        b=TjhEmCC9Qwu8AUFlGwjAMmC6Iowlbqga5BFg9MUqWr6MKRwOEC4ahJJs8fc8o6AJ6T
         gaR+NvOV32BAsuUoSf3Y1KLSJUyI6c/3WJX8115YDOaBgaD+o0IAmw92/krxh0v9aJy8
         aB+aKN8L8R4U9IPTmbKEEo3b0bRePAymoAhgEOA6RZXvy8We+khiVHLzc7QCAQojQHWT
         kmyqsfLDGu/9NpOO3DlOznXUfB+BSfUmT0lYG5s1zdH5gyYjIt7oYLUm9U1xxJ7SrMoo
         imTaMm+AnWUAGTrVO/6jOpXvXll2kmSr7Pt2VC8LXUvxoyyET1PCsfHTlMt1Tdne08yV
         CRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAZ4Gpe58ZV2ebs7Q51DQZvJAPneBGNO7UtyyiC6OIY=;
        b=BqHOrWluZfltBIEJE7rNCsOw+tCSEJBS/2xN6HxCJlV4UNgz+85UFz0XgmrOOEVPbF
         ez5x0JjaBuxKuARqU2/oPqAVgPwSKdnhiwtBlIJjhYXY6I0sQQlCq6NTssdblaWoRyj8
         bSB4CjoYYOJJb8WlMHau2g1zA2YGjlrbqYM38MJTJKlVraS+1dlHmJMs9PcVDKlnmjV4
         wJDM9OqYkCUyiRkFKHEBh4YWAzPSd5eFuHppmNY+1i9M2BFIHeqHhQ6N4gUH9jD6oWKn
         i8AVcYMjrDs1CweUcn6rYR7dA3cdkS9Sw7yBS5GVoYuNTQUapaX7vHcZnXNH2P+5iOdE
         RGdA==
X-Gm-Message-State: AOAM532LXEgH7xK6UqJc3pnJVyRPdJqgfOs2pi4dDz4bdPHOXpNja8bV
        GrkAOP8s9otmBoPO2OgVzH66Ped91cqBSQ==
X-Google-Smtp-Source: ABdhPJzkthDpsocpfqjB+retccE3QF0aX+3q29z6htVthKKK4A96isKdnTMXP1YcztE00q/cw5HdgA==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr427498wml.31.1605711580664;
        Wed, 18 Nov 2020 06:59:40 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id c4sm13222939wrd.30.2020.11.18.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:59:40 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring: get an active ref_node from files_data
Date:   Wed, 18 Nov 2020 14:56:25 +0000
Message-Id: <98193a70c7b87cbfa3fc0a919af8041ed41a82e6.1605710178.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605710178.git.asml.silence@gmail.com>
References: <cover.1605710178.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

An active ref_node always can be found in ctx->files_data, it's much
safer to get it this way instead of poking into files_data->ref_list.

Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b205c1df3f74..5cb194ca4fce 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6974,9 +6974,7 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 		return -ENXIO;
 
 	spin_lock(&data->lock);
-	if (!list_empty(&data->ref_list))
-		ref_node = list_first_entry(&data->ref_list,
-				struct fixed_file_ref_node, node);
+	ref_node = data->node;
 	spin_unlock(&data->lock);
 	if (ref_node)
 		percpu_ref_kill(&ref_node->refs);
-- 
2.24.0

