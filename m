Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31241C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C11206E5
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyCwHyXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMV7r (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:59:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45605 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMV7r (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:59:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so4134346wrs.12
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u689XSv4l2/RrqK+et2vg9gAn+64wLMQdnrdyseEV6M=;
        b=pyCwHyXv80rrMHqhEAG/rh+bNrz59Tn+rqS7tDrmqaP4auWWcgqLAD/0yziZtr+Z6B
         rdv7eUXmivsVuhvSuNLyu9mwp1jKH7N075ZqWZ6lNCGJKhkkAoOX37SJw0Z8Cb0YVm8n
         7vPDK45AdNCU+rLr7lNVvrFWCg5wlRuztMod9uDz+tk9a3vtovw78v1yPdYcWDZvgI3W
         wshuiF928dFGAmWzxAt4cP9dYrWzv3op98W5PJmYOe/MJ56c+J3F2+E8l+7yAswjCMhj
         Eu6IWqtNLKOFYfjG8RoX8u4C0yiyOph7q4zL0XQtPyYgLTqg/wOQkaolzU2AJ8N+FXag
         0aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u689XSv4l2/RrqK+et2vg9gAn+64wLMQdnrdyseEV6M=;
        b=YCkAhqryiH7MGvOtaNdtxUoG7PN5TzdfpmQfr6wBUwoER8yNNBS66/jQbYTwL7+rzO
         XSnaU4zQ94INJ1pyckxT4o1LVHC0Wtesf8W1ZWUKD/aERwnuHkqR4rdD04nwCKDMDw1f
         qULyX6PAhOqIuc2369MWIieM7PE3G+Z/BccDhRoovz5myuW7W4bxkTFFbsHfIzM4A5hU
         /zqP3lzzw4y9pnTGegooa83Cp/h1F2r77WXbRcAHGpGU4OyTLVtnzCB76rxnzy21LM4l
         BxFjryT6X0ub5fsIedSki30iiyA4C9jF5gS+mQ2DGod1rc+h8hReBq6pmnzMW+caDLlq
         qHbQ==
X-Gm-Message-State: APjAAAXTTxn+dwQqzgTYOGpWfBoDA/EEIwVLet/spFyjoPEn53Ep7GAg
        SuXvon8a7mThN6yfwGjPe+5CHP+6
X-Google-Smtp-Source: APXvYqwcfLYNz/QoTzYM4e7oy7eqHLwnllG9lPRwL0OTZrGheC8Jh+lm3s0B03XhHS+XQVkrjGPLFw==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr5271078wrm.264.1573682385383;
        Wed, 13 Nov 2019 13:59:45 -0800 (PST)
Received: from localhost.localdomain ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id a186sm3288643wmc.48.2019.11.13.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:59:44 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH for-linus] io_uring: Fix getting file for timeout
Date:   Thu, 14 Nov 2019 00:59:19 +0300
Message-Id: <df7029d394c63cb6f5fcab9282f37e2caa033d94.1573681962.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
References: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

For timeout requests io_uring tries to grab a file with specified fd,
which is usually stdin/fd=0.
Update io_op_needs_file()

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f9a38998f2fc..9dfc6d8a2444 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2283,6 +2283,7 @@ static bool io_op_needs_file(const struct io_uring_sqe *sqe)
 	switch (op) {
 	case IORING_OP_NOP:
 	case IORING_OP_POLL_REMOVE:
+	case IORING_OP_TIMEOUT:
 		return false;
 	default:
 		return true;
-- 
2.24.0

