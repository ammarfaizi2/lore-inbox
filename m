Return-Path: <SRS0=o5Q3=Z7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D356C43603
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BAA2068E
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HS1HUjZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLIXS6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:18:58 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:41688 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLIXS6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 9 Dec 2019 18:18:58 -0500
Received: by mail-pj1-f41.google.com with SMTP id ca19so6544105pjb.8
        for <io-uring@vger.kernel.org>; Mon, 09 Dec 2019 15:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcZSBdHjAVYdxzrRBm2CUGHQFLqx2bxmC2EdP6FLUvs=;
        b=HS1HUjZ6wfEAryDKGiuhux6y3KDwh+N/6ySkiz5+gTtGQUKv6b3UuZTjKJJKEJRqaQ
         B3Q0k7hlJARQNckFeL1FbL3eq04nH6EImN+Qu5tZ92szCVvGT2sVqcOPGdZ6nnLJfLy9
         XKOfkF2j7lFdD+E38K8NB6HPo3lqPaPGjyClsIC+E4ne392ZKYQSk1imO15RLefs0aaR
         lAnsFj7SjakCq3Dks416GSZnfcNJVJcgJSjKTwIOooyz/EbmSwrHp2e/3Q4dHCeAhyp1
         bhcojHWuOWC+fc9lnI/ZdhdsqLrTQ+OGhkN8wkqEsrhxG4K97EvEFcblTIit9qqrd7uB
         AkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcZSBdHjAVYdxzrRBm2CUGHQFLqx2bxmC2EdP6FLUvs=;
        b=MmtW6MAkFTniovwLTEMV3RsNuLTL0Ndj1Dg/1VoahdZ9e0pnQAc1Eu000sPtgT7I7V
         MjD8xAgjXWVlWLaMmAntdA8ObU57uaqLiAS8UjMUFpKUrfbejP/gUE2nDlr4Ghl++Sj1
         IBP9EdT6mTxL3KcioZPGoKp9qjfUy89r4w4vtVFOT4SgzdWH3pCOkVpGEI+Db/f/W4Oj
         +04eJQ04xq8gA+81k234UF7QRNpF7kh9p3EfTXeaFGNrgOD2JWL/bpMHl6RB/+amdvv0
         NQlJkqicQ0F0Ej2pMMOb8cvizq04LSJ4eFW1tajE+R/CawaFtIzFN3tZowRiF4exLFHD
         EDLA==
X-Gm-Message-State: APjAAAWbxtc3jVxNFEgBEcCehjgb2w3uES3FfnZF/Sb6nyScNSyHrGqs
        OoSsQendh2UHu0b9LL0qtrgx9bUaFAQ=
X-Google-Smtp-Source: APXvYqyAjLCRcujteGnGqVgLGcGz12nyS15SIDFQk4BnpdYpDRLvxPtKbCz8nGc7I9dTLSNmmB1Dxw==
X-Received: by 2002:a17:902:b68b:: with SMTP id c11mr32586743pls.211.1575933536762;
        Mon, 09 Dec 2019 15:18:56 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::e5cf])
        by smtp.gmail.com with ESMTPSA id 16sm515662pfh.182.2019.12.09.15.18.55
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:18:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 0/4] io_uring patches for 5.5-rc
Date:   Mon,  9 Dec 2019 16:18:50 -0700
Message-Id: <20191209231854.3767-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

A few patches that I have queued up for 5.5. #1 is marked for stable
so we retain the same interface, earlier kernels don't have timeouts.
2+3 fix a performance regression with 5.4, and 4 fixes a potential
issue now that we have fileset updates.

-- 
Jens Axboe


