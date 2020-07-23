Return-Path: <SRS0=Bq66=BC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97484C433DF
	for <io-uring@archiver.kernel.org>; Thu, 23 Jul 2020 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585B720714
	for <io-uring@archiver.kernel.org>; Thu, 23 Jul 2020 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oabbIufE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGWR1X (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGWR1W (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 23 Jul 2020 13:27:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4471C0619DC
        for <io-uring@vger.kernel.org>; Thu, 23 Jul 2020 10:27:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q5so5932160wru.6
        for <io-uring@vger.kernel.org>; Thu, 23 Jul 2020 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/b+XKiW+WT3DGQnRWvFOOnJp0nVyiODGOHL5qYf9n44=;
        b=oabbIufEeEUF0SoE5/Mcztsz4TpX4sR6xWcEo4flFjotKvz1DmsGcSimap6eefnEcg
         WiSg49Qfh6yks7zf+PgHA7snvbhVuW7Yu2GLVUOclXMpsWOfhHJjFVupZCh2Qc0PxKGF
         QwGuwVC94wUgi5OCuUhAgPOzQ+/DI5rPlTbXMttA2FgdEv9OpmSeUmeDz4j2CP5QLh0x
         4cULZ5PFSSX/Jt/Ugb8XJUaWmYeduvSQaLIucrXEhOwUgrOH7a+zQdwufhButDbjsT6v
         kf01y/9bUwdGbCLUotm8/clVTAwf8Xkwab4/z7wghf+pHmfi0nT3yOz8KGaPM2OfskA9
         0j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/b+XKiW+WT3DGQnRWvFOOnJp0nVyiODGOHL5qYf9n44=;
        b=ZSEamwKSshNES1ycSMTMB7gEK8a+4WQTZBn/DhN4QfQpqlHE1AFxxkfRPVANUFbk3X
         dmimwsqoBMkSDJ2y9xX7ob757MHRNdPWuKEDd3FUmsrRWdlMUo2se9wObnmYhev/wODd
         6SQ1bQ1mS09p8lcK98RGRymaGK0CUqgd4+ixknFvNQZIha0qf/ZEmms2Pxg8kcociWED
         /xHt9SZ5/dO0t94uU7+7Uh3BaM7BQPaLyuTaSduwvRRu0gSN1BGmh9nARgODbqjlLBfO
         Hh6CA17Jx2e6nWd0cpmLfK8HLGez3TCVxE8geArmS+cNSJ/jGDJ3VSzKOWbIdKQ73d7Y
         L6hg==
X-Gm-Message-State: AOAM532BSo8pgEpn+FNf2Da5WQioJcthVTkK16SKhNeTRVW0wqjuAQMZ
        svoORVOvsaFBmmkE5RgPbcw=
X-Google-Smtp-Source: ABdhPJx9YjQn/vjn2bELf1OWJGZivvTLMQf6h0tkmZDWN9sCdPpoX2u2S7cM6mR7sAqawarS0wGupw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr4847564wrw.405.1595525241444;
        Thu, 23 Jul 2020 10:27:21 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id t2sm3976230wma.43.2020.07.23.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:27:20 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 0/2] prep and grab_files cleanup
Date:   Thu, 23 Jul 2020 20:25:19 +0300
Message-Id: <cover.1595524787.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Not sure we currently have a problem mentioned in [1/1],
but it definitely nice to have such a guarantee.

Pavel Begunkov (2):
  io_uring: don't do opcode prep twice
  io_uring: deduplicate io_grab_files() calls

 fs/io_uring.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

-- 
2.24.0

