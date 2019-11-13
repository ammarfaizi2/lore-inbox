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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D455C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E25D206E3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGlQac+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMV2F (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:28:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38199 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMV2F (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:28:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so4086613wro.5
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AgrpVMeyQJeeLhRhe+SPhMLEDGjRuwRYv4a4Yg6BBw=;
        b=JGlQac+1Be5r7koMe0WqiQ9bxCROkpzI35Lr9ce3zgxQB6oOj1eWQxCl6c5N+HMTlC
         8bORlOwbtDeY/ClfJeZiEjkOm2T7X/BTVhEd0Uo9sY5ySncYPKGhDAPx7auoOWqOyFms
         kL/OmObZ2B4UMj/AIJalRG/mfFx6WTCkIDIcnmyugNGzeLhanRVRjvoOJVzo8PgVDiJ9
         S1mAgr2FscQ751REZ2Riy0Qbcatjz7n1ksxOOtYURI9HHfv+l+HLLPo/2UrUT80TAbJi
         SKqUVV8UDEPp5aSRhkQ3JqqQh5XdHEVPqOV6vaDK5Akky+PNIbLDqOwcCnCPxp0hbLsS
         aBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AgrpVMeyQJeeLhRhe+SPhMLEDGjRuwRYv4a4Yg6BBw=;
        b=S/hEk4oG5vEN2jChXFGukbPVvfHi3iEu21dXW+amwZtb4UNOHw+asn5jixbQE6BSvJ
         VlN2J9j8j8V26LMCq/UMPALCIT/7ueAU3WH90Y6CLd1+AgihnMdMjVIENIU2gaBAxPww
         TBhObJfP3kXsqC34QyaXuuEPEih1JY1WDNa2PiUH3jjNw0Zaq9HJmyuvBDmj91e7px14
         zFDe770Dfa12SkdspS0isGB9FW1UoYV5Y7I49ssNBjN/auW9GJKmFmzlpvpVgeDce3uz
         s3WxIIqg/NOKfDvO8tE7ok7ljIBwtswspUyhu+a+rMlJVJsaZQy+258wC8BPdCO0r6uN
         lEtw==
X-Gm-Message-State: APjAAAU0lVoSdeYB9OeLjVBFP/HItAqNJj0jZZiwtNPaAQbahPyXWgul
        oPTgIC85w9WRutzCcqhjAtY=
X-Google-Smtp-Source: APXvYqwbnpTxaUeETYZFyD17tLRZRdQkTiXKEPMutL6s2K7Vq/Ojy1f5JxuAEZVp6+5kxgbwriVuFw==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr5201476wra.194.1573680482358;
        Wed, 13 Nov 2019 13:28:02 -0800 (PST)
Received: from localhost.localdomain ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id t134sm4007359wmt.24.2019.11.13.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:28:01 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [liburing PATCH] io_uring: invalid fd for file-less operations
Date:   Thu, 14 Nov 2019 00:27:42 +0300
Message-Id: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If an operation doesn't need a file, set fd to an invalid value.
This would help to spot an unwanted fdget() in the kernel, and is
conceptually more correct (though negotiable)

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 src/include/liburing.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/include/liburing.h b/src/include/liburing.h
index 17bc80e..892efcf 100644
--- a/src/include/liburing.h
+++ b/src/include/liburing.h
@@ -240,7 +240,7 @@ static inline void io_uring_prep_poll_add(struct io_uring_sqe *sqe, int fd,
 static inline void io_uring_prep_poll_remove(struct io_uring_sqe *sqe,
 					     void *user_data)
 {
-	io_uring_prep_rw(IORING_OP_POLL_REMOVE, sqe, 0, user_data, 0, 0);
+	io_uring_prep_rw(IORING_OP_POLL_REMOVE, sqe, -1, user_data, 0, 0);
 }
 
 static inline void io_uring_prep_fsync(struct io_uring_sqe *sqe, int fd,
@@ -252,21 +252,21 @@ static inline void io_uring_prep_fsync(struct io_uring_sqe *sqe, int fd,
 
 static inline void io_uring_prep_nop(struct io_uring_sqe *sqe)
 {
-	io_uring_prep_rw(IORING_OP_NOP, sqe, 0, NULL, 0, 0);
+	io_uring_prep_rw(IORING_OP_NOP, sqe, -1, NULL, 0, 0);
 }
 
 static inline void io_uring_prep_timeout(struct io_uring_sqe *sqe,
 					 struct __kernel_timespec *ts,
 					 unsigned count, unsigned flags)
 {
-	io_uring_prep_rw(IORING_OP_TIMEOUT, sqe, 0, ts, 1, count);
+	io_uring_prep_rw(IORING_OP_TIMEOUT, sqe, -1, ts, 1, count);
 	sqe->timeout_flags = flags;
 }
 
 static inline void io_uring_prep_timeout_remove(struct io_uring_sqe *sqe,
 						__u64 user_data, unsigned flags)
 {
-	io_uring_prep_rw(IORING_OP_TIMEOUT_REMOVE, sqe, 0, (void *)user_data, 0, 0);
+	io_uring_prep_rw(IORING_OP_TIMEOUT_REMOVE, sqe, -1, (void *)user_data, 0, 0);
 	sqe->timeout_flags = flags;
 }
 
@@ -281,7 +281,7 @@ static inline void io_uring_prep_accept(struct io_uring_sqe *sqe, int fd,
 static inline void io_uring_prep_cancel(struct io_uring_sqe *sqe, void *user_data,
 					int flags)
 {
-	io_uring_prep_rw(IORING_OP_ASYNC_CANCEL, sqe, 0, user_data, 0, 0);
+	io_uring_prep_rw(IORING_OP_ASYNC_CANCEL, sqe, -1, user_data, 0, 0);
 	sqe->cancel_flags = flags;
 }
 
@@ -289,7 +289,7 @@ static inline void io_uring_prep_link_timeout(struct io_uring_sqe *sqe,
 					      struct __kernel_timespec *ts,
 					      unsigned flags)
 {
-	io_uring_prep_rw(IORING_OP_LINK_TIMEOUT, sqe, 0, ts, 1, 0);
+	io_uring_prep_rw(IORING_OP_LINK_TIMEOUT, sqe, -1, ts, 1, 0);
 	sqe->timeout_flags = flags;
 }
 
-- 
2.24.0

