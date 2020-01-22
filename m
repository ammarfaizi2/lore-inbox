Return-Path: <SRS0=hAot=3L=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C34CC2D0DB
	for <io-uring@archiver.kernel.org>; Wed, 22 Jan 2020 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7021835
	for <io-uring@archiver.kernel.org>; Wed, 22 Jan 2020 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q16enS5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVQCf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:02:35 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:33263 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgAVQCe (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 22 Jan 2020 11:02:34 -0500
Received: by mail-il1-f182.google.com with SMTP id v15so5562796iln.0
        for <io-uring@vger.kernel.org>; Wed, 22 Jan 2020 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkkBulRfFcaILGpsEq52tmNefXtFSwFkknnr5JWDFPo=;
        b=q16enS5dgT0AvlX+rQCwZhh8Gtmspa8pwOj753CKESy0YsFgSmgqSmeY6Fjzc7aecX
         xsaaljwlVl9jDD/4mplItQUKz8YwB2xesB9gb5puI9AqCHKV3AMHotoVI3V85Tj9IXzc
         asIql5R/HvWLkZVc1kEm8cuqToGvLgqGJCpGOIExcIsajIwaeBHTyb7Rdudi9RseMjd9
         bodFaZww9PBm3LluhVHUauHcdWc2UGeo8zrGlccALzDlYaI7JJe0ykX9fTuEShreuFT+
         8vGcy5+OR8F/TKG7IjccVOM3pT8DFMTOe9teqaQDr3oAi260Vb/Z0aayVhiPMwikzCLS
         aCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkkBulRfFcaILGpsEq52tmNefXtFSwFkknnr5JWDFPo=;
        b=SY5yk8qcrRT5BjbhGEGeJjzmwWOJU4XvCbqyxk0q3elCxpUzGbbsM3rItPJ1XBNPXu
         /0Zu/Aim1wo7iugsJ/3kY/TECs3P+POXBR7/3GoNXUGRHS85KNmQjNAnpTOST1hmJCwK
         GW389B7HVVnxeZFsKssL5+rCc22rfm6E2NaX+DimU0Z/hkP8Aa7sHhh2i7u+CRcQonhQ
         byLddNNz7njZ8HM/QVSncHPxNToCFJek1aYagrF+8CpjwE5pRZw4qdInEuY8vbH10893
         vCLifDBNka1ytz6D5ojryUhkYzMZziWdg/3piLJISEyTgvsfhMfJpJGQOgInOAUA8NIF
         oI5g==
X-Gm-Message-State: APjAAAV1Cu4EyQ+EI0lWHwB6Cd3Y2yQJxZnvVtOnDc/ZOJE3EvPUxLft
        jrXC7rmMhjMpbMOetvvGQ6kx1rRru4Y=
X-Google-Smtp-Source: APXvYqyK3mVXqUdP8atBQpf4r3XNJ+ieg2SfmpxvukRECA00+9rPqTteGj8oFdr2fyB761FbbT95tQ==
X-Received: by 2002:a92:b06:: with SMTP id b6mr8253760ilf.127.1579708954006;
        Wed, 22 Jan 2020 08:02:34 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v206sm796924iod.41.2020.01.22.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:02:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCHSET 0/3] Add io_uring support for epoll_ctl
Date:   Wed, 22 Jan 2020 09:02:28 -0700
Message-Id: <20200122160231.11876-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This adds support for epoll manipulation through io_uring, in particular
epoll_ctl(2). Patch 1 is just a prep patch, patch 2 adds non-block
support for epoll, and patch 3 wires it up for io_uring.

Patch 2 isn't the prettiest thing in the world, but we need to do
nonblock grabbing of the mutexes and be able to back out safely.

Please review, thanks.

-- 
Jens Axboe


