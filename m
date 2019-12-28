Return-Path: <SRS0=LCsk=2S=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63502C2D0C6
	for <io-uring@archiver.kernel.org>; Sat, 28 Dec 2019 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306A221927
	for <io-uring@archiver.kernel.org>; Sat, 28 Dec 2019 19:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lwf8/+XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfL1TVW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 28 Dec 2019 14:21:22 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33390 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfL1TVV (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 28 Dec 2019 14:21:21 -0500
Received: by mail-pf1-f175.google.com with SMTP id z16so16381289pfk.0
        for <io-uring@vger.kernel.org>; Sat, 28 Dec 2019 11:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzJ8yU2GfAWu23ikT5D6uRGxrA1aNu5RkBFqhSItX+0=;
        b=lwf8/+XTrKTFGGtiPLnbRjWAgxusVftcJKkGj44D4VjPgCs38lM1CWlYcismeZ41gU
         u5k8muay7yxdhKIWOBCgn8s5p2E9B8fPGSwJfK8imVy0g+txwu53C4AFCBJNdA7WwaEt
         1pgm4BEAC10Yo6FeaDYPHv4BNwjrm412wp24gsyDxQ+P/4H+brqVcJnlOY6j2fc5ak/2
         w44a8ZvqDN/qoyZIJRykGfPy1IOsIA3Ag4R1Ng1pOUQEMDl8oceafcyNdWi0Re5Sql/4
         /YkqfAXvjtTHdo4T2VjcEK6exJiX5dPEKUg/hj1xmprWiySMmAGaZWtdIrlL8X4ObmWh
         MWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzJ8yU2GfAWu23ikT5D6uRGxrA1aNu5RkBFqhSItX+0=;
        b=b4z8Nb1CkNZnsJjCUL4lycXjq3ZK9kMedYFw/RoQFtC7P4qW4Iq/UfUcjXHqk7EUZq
         XvAEUXmNvXpuIpZHC7RjlbHL1L8rfXRkgkI4A8RWiDwcTv8pCdkh7WMUEpKq2Z99lY1C
         ZAbSNnbSSy00KOnwP6B93HC6GU91gXsIi00Kuh5NiSrdq9hg4dEcHNbRfrDaF2bUP/pD
         ROKeB6EgXxpIr3v8uBsh6fcDODY0R7UmmjRZdhoiFEkfoOBGfnBU/wQATH8cZ5ZW5EM/
         vUS8+g10kNGs/ULf75fPglBl+EQq1F/lCjCJhVnswxddpNuAy9PoJC7DNy8YuNxWIqae
         i/SA==
X-Gm-Message-State: APjAAAX2TGzOAVJvU/ZzGEoZVLqdCH7hGWZbzuhFl/CcId9JtZGS4Jzx
        RUUYTCqk3B6/pL4LmClbvt0mL1jqyWuRsw==
X-Google-Smtp-Source: APXvYqwm+B/BQUVjt+BT8pOdlJy0FuTvsNHtaOjkcapx8DQ7DHaI26JRAZeOocopb5CIWItUAR3CaA==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr63655772pgj.119.1577560880719;
        Sat, 28 Dec 2019 11:21:20 -0800 (PST)
Received: from x1.localdomain ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z30sm47067902pfq.154.2019.12.28.11.21.20
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 11:21:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 0/9] cleanups, improvements, additions
Date:   Sat, 28 Dec 2019 12:21:09 -0700
Message-Id: <20191228192118.4005-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is a grab bag of stuff:

- Removal of forward declarations we don't need
- Lookup table for opcodes, making that part saner
- Optimization of the overflow handling
- Poll performance improvements
- Addition of non-vectored read/writes
- Allow current file position offset reads/writes
- Add fadvise/madvise opcodes

-- 
Jens Axboe


