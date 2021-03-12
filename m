Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9EBC433DB
	for <io-uring@archiver.kernel.org>; Fri, 12 Mar 2021 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198F765006
	for <io-uring@archiver.kernel.org>; Fri, 12 Mar 2021 15:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhCLPf2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhCLPfL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 12 Mar 2021 10:35:11 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD882C061574
        for <io-uring@vger.kernel.org>; Fri, 12 Mar 2021 07:35:10 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id c10so2919411ilo.8
        for <io-uring@vger.kernel.org>; Fri, 12 Mar 2021 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqLbROGbUchfnSLh0LoB/Cg3Y7RJLJjckHR87lp5nXQ=;
        b=ApAusw2jSLsaegUzA5rh8a2GxZERbuI+yBOZb/SHmvmrj9eR9zrB1ZoONskkaQFYqU
         GFxZuSXATSAJJ5yebiS8aBoOu+MeJ0jkwqJ2pkk7tt8Gh/CpbX3W90kzIk5CanvbW/wP
         PpCDv308GO6Xn3Py0tm3U+YswrhZ+zvi1aWermlj917OHpVPpZkmw/I2lgPLpWQ8MS0a
         7uDXtiz1WQ7Y9L7gCYPiRkjwuOeAlB9RIx6kvK+5VaxayGZtxHLgPY7n1i5JEEgpGjJi
         h4aKdSbNwyhVdAYq40l04YQVJKRB1TA33plPxnMPbeDwBqVrtCxlq4fKviCvwKV//5Ve
         V3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqLbROGbUchfnSLh0LoB/Cg3Y7RJLJjckHR87lp5nXQ=;
        b=nmP5XZaB8fijrHgd+XpP0RDSJaP5tNFExm/vC7D9cvwvDVOEU/7S7lL0nKlp4FsebR
         5w5IiCNVacqkNm6AkD04TuYpjMbd0FQFcF3Ob8YBgQYgfN6hEdLDkHN3W/gUywHTR6dP
         vQQ5sZ9ZdRHJwkfIAq4UcCZ2MahvlHnSpagUUFFNrpTSeSxhg6SGZdZG2P/uzKrc+BW4
         RLdwNZT9bWiamrQjqPgq7fZPPx+yYGCWykdJ6Q5YAgcP0bAvIahd/yvCwZ45aCRCfqaj
         xZZTo90x7LP3ja6C+peIv2hGYGRhcCxcMYli2kyQHrfaZuLG85IyaKQEuP8eMBh1PJ6W
         0IEg==
X-Gm-Message-State: AOAM5330ynJvdNVehJjp8ZxfOrg/uIlSF/5X2/DDYG/Lu3ZKxbFsGuT9
        8pzwCWcF2SY6s9Y/HnRDAbn2BdOyvIuTSA==
X-Google-Smtp-Source: ABdhPJyiVn/JLt55gejSoV0EDqUQPkO4GQhLTJ7WGSQ7JysDwuWNJZponMgHYQkShtq/UO2BNnBovw==
X-Received: by 2002:a05:6e02:1a82:: with SMTP id k2mr3211019ilv.155.1615563309965;
        Fri, 12 Mar 2021 07:35:09 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v4sm3060863ilo.26.2021.03.12.07.35.09
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:35:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 5.13 0/2] Cache async read/write and regular file state
Date:   Fri, 12 Mar 2021 08:35:03 -0700
Message-Id: <20210312153505.1791868-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi,

Patch 1 is just a regular fix/cleanup, there's no need to check for
whether or not a file has io_uring fops if it's registered, as we
explicitly disallow that at registration time.

Patch 2 uses the bottom 3 (or 2 for 32-bit) bits in the file pointer
to cache state that we always use at read/write time. This prevents
digging deep into the file, inode, superblock in the fast path.

-- 
Jens Axboe


