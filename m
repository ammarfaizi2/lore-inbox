Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C3CC432BE
	for <io-uring@archiver.kernel.org>; Sat, 14 Aug 2021 16:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E65160F92
	for <io-uring@archiver.kernel.org>; Sat, 14 Aug 2021 16:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhHNQ1U (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 14 Aug 2021 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhHNQ1T (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 14 Aug 2021 12:27:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988EAC061764
        for <io-uring@vger.kernel.org>; Sat, 14 Aug 2021 09:26:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f5so17459187wrm.13
        for <io-uring@vger.kernel.org>; Sat, 14 Aug 2021 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YPhNAWWyx7JoZN2mpBNXz4f9ibXMX0Up1E5vWLbctyk=;
        b=fW99TFLlixqNR2I731k0SHEPlHtF7JsYYvG2qoTwvrs20d9zkxhOzCK7iup03iAHQQ
         0XcXtJpd5ekJ/zCmBrBhyXPOnsjak4OuUUCIeYPPT59kgcwje4MkynTMADo/ff5MRzJX
         kFOM17s5ri4p/6XzIjgcKlSVDRwaHjQQMp16F5MnnY/W1zMGodR1Qe4y3UvZbXVbYaS8
         Ped227Saephuap8i98Vp4ln7b/l3F8lJgaco71g7UmajaYZYmZ36HcjQ9KHYsnET3oS2
         a3eALfIG1iHAKtftHGp637Vsle+N8+1s/BXy1tVVZ2G2xTkn2vZossP/otWLQRvqnQBn
         f7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPhNAWWyx7JoZN2mpBNXz4f9ibXMX0Up1E5vWLbctyk=;
        b=lFtSIMzPQcMnpvidGnHhxbP13FAt7swTtdFcp1feXV3c1b8YBu7R3tJHUog+kHZF9E
         ySbIW2o74cTRJq/bNHf6T/IYoujd66I4FfJ2NtIZsCf0VuETHUiAqaLA/+9yAesQJa9S
         dld9DjdPEwTbZf8ubMml297A2vYoUiiLLDRUJIC9yioxwzEYhWmM9YnLEXPb9OW67uja
         up0XOPgcv+uf0wc98646T4m5pKl1RM+GOMAJMvcnOKk5+yw6bGwUr5YhOTx6fe4nHf/Y
         BEMnGNoB7Mamu/jZ0LQlQ5DTzOo/ncj326W26pLujwmL1Bt65LmJXzeyCDXA8ssFcDWa
         +pSg==
X-Gm-Message-State: AOAM533xYamtVUKdlaGgLKFKJWKKUZFYcgQ+mM9FtuazzbUl6g4FfNLs
        wSkg2CLrg31UPWYOdOrhF0Q=
X-Google-Smtp-Source: ABdhPJxumdcGQUUhGGWXvozTtA8GweWSyQixHzmxjtfocqVoBGMu8U1sgEIinIUQWjI7W5+RUqA0Nw==
X-Received: by 2002:a5d:694f:: with SMTP id r15mr9064150wrw.86.1628958409261;
        Sat, 14 Aug 2021 09:26:49 -0700 (PDT)
Received: from localhost.localdomain ([148.252.133.97])
        by smtp.gmail.com with ESMTPSA id m62sm5028263wmm.8.2021.08.14.09.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 09:26:48 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 3/5] io_uring: optimise initial ltimeout refcounting
Date:   Sat, 14 Aug 2021 17:26:08 +0100
Message-Id: <3415b90398032cc99a0b06b703636f2be13770b2.1628957788.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628957788.git.asml.silence@gmail.com>
References: <cover.1628957788.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Linked timeouts are never refcounted when it comes to the first call to
__io_prep_linked_timeout(), so save an io_ref_get() and set the desired
value directly.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d572a831cf85..37b5516b63c8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1310,8 +1310,7 @@ static struct io_kiocb *__io_prep_linked_timeout(struct io_kiocb *req)
 
 	/* linked timeouts should have two refs once prep'ed */
 	io_req_refcount(req);
-	io_req_refcount(nxt);
-	req_ref_get(nxt);
+	__io_req_refcount(nxt, 2);
 
 	nxt->timeout.head = req;
 	nxt->flags |= REQ_F_LTIMEOUT_ACTIVE;
-- 
2.32.0

