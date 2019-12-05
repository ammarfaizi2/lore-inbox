Return-Path: <SRS0=lMt9=Z3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA0C2BD09
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C913120707
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPjxrbyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfLEM2B (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:28:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42902 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLEM2B (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 5 Dec 2019 07:28:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id x13so1193861plr.9
        for <io-uring@vger.kernel.org>; Thu, 05 Dec 2019 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2H5uQY2E80fHvPfqFfjVfUXp73NqnijtY6LQhNvu5Ug=;
        b=dPjxrbyLMxKXSv8B3l/TjcFovJd7EX212oYyttLvnSDmIE2dsismyFWwzzvQdl+vll
         3TnsBkJWOxzqVLE2fxRkgv0LnDpuqs25ZN9vgP2zqABj2eyhshx+eTJ0FLf855vebnLu
         7S9LvRg4qk21RTSYL+k2UCIZVwBUdrENqhBK2789uj829F7S0yfnfoQIILKZAAHXLkq2
         Utb6MLcUuZ3KKNS5p9FL74yoSzJ/X/6Dfx3imZFHyW+hHJr18Sd75Eirq6Ibi9z+M5KT
         qIOsZ+/END17WHCL8bgKdXChnivHdNUmgmJhfFAW2Hp7vjvo7UH6BTZ1kKn5l4WuOKK5
         OGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2H5uQY2E80fHvPfqFfjVfUXp73NqnijtY6LQhNvu5Ug=;
        b=FMPjK+NHYfw9rtZhEfNSVgQmP10u3r0qve1sh2VBdwEXaRM7U9epv+pXx4Tcm76wpu
         7jVG0O0x++uJHNR46vMdi4TDaWmRJtYMJNQdMZ2fXWhfjaCeFttgVjEGdaoTv9rYlyC/
         oTbLEZK+VnWgpcgSCst7QX5MEMXd49PPnrmH1MA24G3eyuKwLOW9Amx96bgqVuGA+N0y
         336SkK0ibhkmPuN8BIGbGcJeSCKAwECzyG20A/jr/KkdMyvtkcXOHItJz7+X9ojO9Dtz
         +Pa1olvUg/6bTfp9m7blF0tXH9lfGQHp5y7ZnWm8SN5FoogYwTQ89Pqe53nBWOZZMJJf
         HFiQ==
X-Gm-Message-State: APjAAAUj+pzUp6/0MW/0frlEeQ9MoMA1xjOnDI62WE7zYFk/ChfYJ2qf
        cwdl84SvsD2XReixCgdGnwWkpsTJ
X-Google-Smtp-Source: APXvYqwBdTmMJlASPWKJwN1HUjsGYjt91qR/iF0JEEros6D40FYfhY6cFXOthe2ugz9fekvLk4m8UA==
X-Received: by 2002:a17:90a:628c:: with SMTP id d12mr9091276pjj.107.1575548880558;
        Thu, 05 Dec 2019 04:28:00 -0800 (PST)
Received: from localhost.localdomain.localdomain (144.34.238.174.16clouds.com. [144.34.238.174])
        by smtp.gmail.com with ESMTPSA id g6sm623704pjl.25.2019.12.05.04.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 04:28:00 -0800 (PST)
From:   wu860403@gmail.com
To:     io-uring@vger.kernel.org
Cc:     LimingWu <19092205@suning.com>
Subject: [PATCH] fix a typo
Date:   Thu,  5 Dec 2019 20:18:18 +0800
Message-Id: <1575548298-8229-1-git-send-email-wu860403@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: LimingWu <19092205@suning.com>

 thatn -> than
Signed-off-by: Liming Wu <19092205@suning.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4fd4cf9..b4d7f01 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -145,7 +145,7 @@ struct io_rings {
 	/*
 	 * Number of completion events lost because the queue was full;
 	 * this should be avoided by the application by making sure
-	 * there are not more requests pending thatn there is space in
+	 * there are not more requests pending than there is space in
 	 * the completion queue.
 	 *
 	 * Written by the kernel, shouldn't be modified by the
-- 
1.8.3.1

