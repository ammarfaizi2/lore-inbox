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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242E6C43141
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2080F206E5
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jti3JOSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMV7s (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:59:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34939 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMV7s (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:59:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so3722902wmo.0
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wJt251wXDIxrfmGLbGIx8BKdGPZm4sa2C2viZPfTw+I=;
        b=Jti3JOSXIlB6b2CvnRunbY+yu9CEnxYeFq5GPPYtTNksjw6E1km7fVJiAUI4t9H1UY
         cZfXjUMjeEMDYZaIFgFMhuO8+wVg6NrAZ3+xW/82kxa8qM0A1qcf8MxNp8ca555Rxzav
         VBPohDCrZBnz7DlAbddreqboZLPJ9PTcYlht94Kr5C/3c7+iLB1vFz/owoNkJb8JYela
         1SN6RUpE93ime8Qzm5Jn36ieOJYe5gIt22eGMbr20360iAbBAITvGbxIj6BfagOJeN2m
         c36o1P5sBb3r98eWfuzG32HGG56KSDxIMCnOrf6qcv6kfTab7gnwBcdP8gaxM4mRRxFD
         X2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJt251wXDIxrfmGLbGIx8BKdGPZm4sa2C2viZPfTw+I=;
        b=BwPDVSIsT2F6aJ/FkvFhOGKJVrLTyX0K9b45/jcyqDkVY9kzFjWZqLCIKDdCJtZNSR
         UWaHfR+n8yL0hUDVGRsLb665ieSzqKP5OgvDpuFDvFC9BDUIkpbXPDVJpmTvs6KYXIyI
         y1p/f5IboeXmr/+MmVkupzGqe6l1QZ/Sr8grmhW/Yp4iTn4G1V7w8JI3/i8YpbeIzskY
         lXmDHrTKzgQd0jWeZLwxJ8HgtR46tyjRj/DdlMfMKGwyvAn/LTT4pJzKJlId80mfZMPo
         oSpcMhnVqMb54WVItibiAl/GOMEhofEm2r2CaLZCvCn3jAuHFjrgef+OtO450cixvmDv
         Qthg==
X-Gm-Message-State: APjAAAU5yGlVAjVPy1rTJNU4D73fthXyC4vFNo1kqKY6d5wNH0HQgIaR
        yhjk0LDx8gaN3aJ3IiqvNk8VL21l
X-Google-Smtp-Source: APXvYqxjvr6nQyG2875LhtV72+Q2SCbui1nsDxyV2E+u7SrVU1tLVd0L0ab4i8fMJtjoCc6SMIKwag==
X-Received: by 2002:a1c:3b82:: with SMTP id i124mr4441014wma.122.1573682386386;
        Wed, 13 Nov 2019 13:59:46 -0800 (PST)
Received: from localhost.localdomain ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id a186sm3288643wmc.48.2019.11.13.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:59:46 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH for-5.5] io_uring: update io_op_needs_file
Date:   Thu, 14 Nov 2019 00:59:20 +0300
Message-Id: <03c75189fc3313de51a56f0c000fb686dd9ac2c1.1573682117.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <df7029d394c63cb6f5fcab9282f37e2caa033d94.1573681962.git.asml.silence@gmail.com>
References: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
 <df7029d394c63cb6f5fcab9282f37e2caa033d94.1573681962.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Some new commands don't need a file, so update io_op_needs_file()

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3b1aa9e21cc3..0730c54b2153 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2600,6 +2600,9 @@ static bool io_op_needs_file(const struct io_uring_sqe *sqe)
 	case IORING_OP_NOP:
 	case IORING_OP_POLL_REMOVE:
 	case IORING_OP_TIMEOUT:
+	case IORING_OP_TIMEOUT_REMOVE:
+	case IORING_OP_ASYNC_CANCEL:
+	case IORING_OP_LINK_TIMEOUT:
 		return false;
 	default:
 		return true;
-- 
2.24.0

