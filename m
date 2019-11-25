Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BB5C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF3A2068E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JqDMeRGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfKYQwj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:52:39 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:39638 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfKYQwj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 11:52:39 -0500
Received: by mail-io1-f43.google.com with SMTP id k1so17017251ioj.6
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EiGrNClfc3px+Xz62g3OwouD8pJPy7SDYtsO4vFP+Qo=;
        b=JqDMeRGZzXVXzm9aYcfSgscVC6JP6OkCZehVJkP2P1smRu5RrSx6/wufag6ZBwFGWW
         CFXpJAPoIz7zXtHxMTR6aHh5FzKRdPpe0ryoEuhNZ1AAyjPNwro5VCw0YMvXlQbGc6Dr
         53a3wLNKnoL8DW0KGLzZklPjKZdwLHd5AJkWn/NMJ16selUKzaZqNVmREhe0rJMeFkes
         ig9xk0L7DtvVD8rVXNOuqCFXRKSze69seD1bzkxylTCB49/o+IqEmzvKJOWirlg/Fyca
         kW+DOW9F0L5F0hat0WvVopLRvyFPBmXKzqPwBkwRMFWYghLMX8cF6MTZSdp3oqsmCOvK
         3PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EiGrNClfc3px+Xz62g3OwouD8pJPy7SDYtsO4vFP+Qo=;
        b=VZZ3KeruXIDdHatJS4anAA6pfjrE+tJmx42O+TfTseWVgiQ9grlN9Yg9Wp3u1wXzb1
         vN98AxhoAs6A3SONs5dKOqrhjXY+Uiqnki5IT+Kxympzhvb8WNx5/UyQ9pTliPTIsz9L
         waW4KH3/STNexs1c8vjiFBT6v+MJW8Y+DfzkicmVXlh4jumZ3reRuosgwMaCS4lKGiCY
         ZW8he7R1tufz1oyBqx27l96bnQyBNLdSSpONAiIU6PrHSmNH7t+A+F8Sa9Rp26jOjJzT
         AbbKh+OFyAOzNMGZo5Hoy+1n4NVYhQhRxvRoN04C4RWx/SRcDHTHnf2y7TcAQmZVSRdD
         4Axg==
X-Gm-Message-State: APjAAAWNmORdDY3VPJ/nMPSGi5iANHFmgWjfCE2QIeEamWatC+MWuRrJ
        lTP59pmTDMTOYKAgxlHPyLyxYjTADKS4eg==
X-Google-Smtp-Source: APXvYqw+s+cu3JyKgA30I8b4vRINq0luZxPnLpo7X40GVQ5W0egzIWIq1tTZEHnxyAz05Hi4zkiKuA==
X-Received: by 2002:a05:6638:1fd:: with SMTP id t29mr28374025jaq.55.1574700757014;
        Mon, 25 Nov 2019 08:52:37 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l63sm1945004ioa.19.2019.11.25.08.52.35
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:52:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET v2 0/2] io_uring: ensure we inherit task creds
Date:   Mon, 25 Nov 2019 09:52:32 -0700
Message-Id: <20191125165234.16762-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

(resend as v1 included a 5.4 backport by accident)

As referenced in patch #2, fuse + fsync fails with aio because of the
async punt of fsync not inheriting the original task creds. Apply the
same sort of fix for io_uring, and apply it globally to all requests
so we ensure we always present the rights creds when offloaded.

 fs/io-wq.c    | 24 ++++++++++++++++--------
 fs/io-wq.h    | 13 ++++++++++---
 fs/io_uring.c | 23 +++++++++++++++++++++--
 3 files changed, 47 insertions(+), 13 deletions(-)

-- 
Jens Axboe


