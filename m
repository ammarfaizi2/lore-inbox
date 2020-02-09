Return-Path: <SRS0=vviT=35=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB9C2BA83
	for <io-uring@archiver.kernel.org>; Sun,  9 Feb 2020 17:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA39320661
	for <io-uring@archiver.kernel.org>; Sun,  9 Feb 2020 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UzOn3T5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgBIRLT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:11:19 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45792 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgBIRLT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 9 Feb 2020 12:11:19 -0500
Received: by mail-pf1-f178.google.com with SMTP id 2so2446047pfg.12
        for <io-uring@vger.kernel.org>; Sun, 09 Feb 2020 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3AKb3kB6QuHTfVeEgrjjQ8k6lbYl8zbFZD9EL5gGBY=;
        b=UzOn3T5kWRBTrlZEB8WgVv/8LatGyWNMNegD/LyGF9EeV/mlKEXk7sIREzk/R31PkT
         uYGjOcwKwIr3xephKJvVm/0foyLp6Wi+gBE0GLjFQAIJUlJT9INGT5fXMvl8+3aqHVB+
         2aiTB40nWOwHP0IPOiLPcL3H8XI6/zCpfGK3D/Z7Zh0tva8Qqo0MBWDv6iVR0QsRT7n0
         VjajtQIyieUT68fRTkj9tQqckTpr56CQDZyw63dLJCg+2BlNto3IRqCt4Olvy3tce0Pc
         L6s64IzZLKbg+iJl8s8l6QeyjjjgUsEqtO4GMMOsjiUIrPLlS+CI9HI5WsPQ44BAzepZ
         puyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3AKb3kB6QuHTfVeEgrjjQ8k6lbYl8zbFZD9EL5gGBY=;
        b=BmDotAj3KjBYmyn+pD+ta5aNYE4lnir05Un7QRqAa+LUeWbxTAbrmsoHkCnCQIi1E7
         /1bjpRdO/j/MqTb0ACvzJTkDTQAEg73ebsULSioe5ElNSZfGTuRhvpHFJKj6t/2LOVVr
         2VrhjGF1uZkfW5nSefusP1Ooe9VvVxKb+dqoyJ8E+0jzqGQIdkGPaQnujb+v4ch3bxum
         QFIl+KFy8skvD+c/mqYXU62sBz0Q2C/gHYKKZbkpoCgwPAPPpUn/S5vomduviPS32apX
         eapWN3/eAEfcaUWaJqbZda66JUxxTiqQdnId1Mhwx7F8dQorgbgatu2HZxTMcMZsigGV
         OMVw==
X-Gm-Message-State: APjAAAVKh6Ync47fABRMbz/9cliLcfdbM1Hg4bVAlRzcacHu7VN5t2kZ
        k+yvLjtYqD2fSZRqUbeJmrrFW3R/SJE=
X-Google-Smtp-Source: APXvYqyJ27QZd8rLX8sid2hkJQiqwfNSsWmtmXHPeH5lFs07Azv9JKZnmziKJEitXVpUopbvd/R58g==
X-Received: by 2002:a63:c642:: with SMTP id x2mr2181098pgg.242.1581268276952;
        Sun, 09 Feb 2020 09:11:16 -0800 (PST)
Received: from x1.localdomain ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o9sm9703271pfg.130.2020.02.09.09.11.15
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 09:11:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET v2] io_uring: Allow relative lookups
Date:   Sun,  9 Feb 2020 10:11:10 -0700
Message-Id: <20200209171113.14270-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Due to an oversight on my part, AT_FDCWD lookups only work when the
lookup can be done inline, not async. This patchset rectifies that,
aiming for 5.6 for this one as it would be a shame to have openat etc
without that.

Just 3 small simple patches - add io-wq support for passing in fs and
setting it, and add a ->needs_fs to the opcode table list of
requirements for opcodes that could potentially do lookups.

Last patch just ensures we allow AT_FDCWD.

-- 
Jens Axboe


