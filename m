Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077CC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6412075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GuOB+//9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKTUJu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43495 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTUJu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:50 -0500
Received: by mail-io1-f65.google.com with SMTP id r2so598341iot.10
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEDYyRDr7itvWVWJb91g9Nr9lFLly++xp+1YF+K1ymQ=;
        b=GuOB+//9raVyNZjxem2kCmI+KVIfJD6NTQeHqLFXaEs3s1t2PH0Wqgz1rN28BvJfKZ
         8POYaDH8bR23yjmZU+xmXNCSc4ocZTVwDDFU9lNIlKBjPxXwMV+hTPncYMGDYOIrnGJ6
         ugGA3qjbFyLPxJBxLhAi2FD61+m2birr9I7G0lSqNOVm0PniNtIxOmssxprhIVMwPi7N
         K1FGKcYhgBf2w8yieGZkoE1kmwk1tND4/6aPfhGUftNXKfdChbkOBYhFMO8R6FuXYNtK
         fa+pvjn5i+Z03HoqaclL51SRQg+aAxe0InsR1MXxM0Cvf5xXC4wQokRa/qw+EIZWPGb7
         +j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEDYyRDr7itvWVWJb91g9Nr9lFLly++xp+1YF+K1ymQ=;
        b=OQjTHDwa5O9ntpKfe3gnRN682NYO6eJftRuRZXnnIs+BuZDX/vactL0+n5/Bn6mqmT
         YSAQ+Mg3AtbhcghVPMSQgGM60LpIde6/KP5RD1U5ya5GshzP5/h1gAV6xkwipNgJbyt8
         0/+nwu9EWvnPvPpHBiNYL60wS096BLmlGYEznVi7Oys246WX2GZBGo5AxWDXo1eXwbeY
         NxAdcgobRIhhpjT6XDwDzAfTf4aycnptwiySb5hOJAp0ws36/+2ov/QiZc1PHKCz1T5l
         W8xbWBPjW0J0FU9Ud3LnfvBlU5pnF4qtKHipxJmNKaqFdsq2UmmTMPh8SCRL2LR67CIX
         vJkg==
X-Gm-Message-State: APjAAAXn0zT789M5Jfzf5bq3kika3l2Flh1H+0MvqdU5soZxRasjyeu2
        gf6bcn1fOBCKWMbu+YukLzcNDBqrc0sPmA==
X-Google-Smtp-Source: APXvYqwDpJwnzj6TP6rGXTnQ0MEI6Xz5mjQiOtGH9qBDwIualI0Z4QBKYzNMp+20SMOui08Ve5JBvQ==
X-Received: by 2002:a6b:c8cd:: with SMTP id y196mr3907224iof.266.1574280588542;
        Wed, 20 Nov 2019 12:09:48 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCHSET 0/2] io_uring: close lookup gap for dependent work
Date:   Wed, 20 Nov 2019 13:09:28 -0700
Message-Id: <20191120200936.22588-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

As discussed earlier today on this list, there's a gap between finding
dependent work and ensuring we can look it up for cancellation purposes.
On top of that, we also currently NEVER find dependent work due to how
we do lookups of it, so that is fixed in patch 1 while patch 2
implements the fix for the lookup gap.

Patches are against for-5.5/io_uring-post

 fs/io-wq.c    |  3 +++
 fs/io-wq.h    | 12 +++++++++++-
 fs/io_uring.c | 34 +++++++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 8 deletions(-)

-- 
Jens Axboe


