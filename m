Return-Path: <SRS0=qbp9=ZY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2769CC432C0
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 22:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9E206F0
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 22:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MiF3C3H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfLBWbH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:31:07 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:41726 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBWbH (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 17:31:07 -0500
Received: by mail-io1-f48.google.com with SMTP id z26so1297807iot.8
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 14:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqeezy/+lwDvnMk76buES953jUJ3LmuOeI47STi9xg0=;
        b=MiF3C3H0CLspn7nhBiz0wBEHADGEmPWzGb7xBCxrNYg7U2XGk55tgtAqbn5Vr2jNam
         vUuBYkupYL+fMbnoVqq0cNG/EEAWs9fW+DqrYgCKo5I2wIDdn2/e8iuFZI/MND2Co209
         38w3LFv1AZmw1kuYGfdmhxEuJ4pHMTeOQRGYLLE7feyJpc0qVGnp3SiLA+V1MreiY7Ej
         ebspkN4+RYyi0YgJm3KS+HwnC30Dzo0NLIcnCLy4Pwr8z/VZR72/nkCf83gEB+lk65U/
         +JJ6A+ePhP0tBpwQdav9P+bQl5aDDCQ1lynkySjsG3+w0slehbhXx1o+VdKRf+TcoI3e
         Zl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqeezy/+lwDvnMk76buES953jUJ3LmuOeI47STi9xg0=;
        b=tdNXzThketUQxJ0EjaaUjL9AdcPDUpS+F64OaZkHdb1xIQWJuOnd216jWu7sfxWvwq
         ZC8QPtU2QQNhOh7LPmCbCjANtqdkphYTV3YFDPqXe4cUmxv5X0J+/9+h4NeXnOVkPbSx
         R/qF/h1JRGqOxuaEZUCIHlAYuPMjfkiPdVxN4P2WVvHt/30YqaFlEa/7dmJHImFhknvg
         hl0Xu7uO/MkzObN5zWI9pUxhjY7PT6tRqkjOjcYe114jAOctX/7cyrjsF+QX2nRzZqZg
         xYY6hxejghY/tfMs9rbH0rifarqWzh3wQFGXzxBoYMqAOVGHgtQOTPReANwvw0u8bomV
         I0fQ==
X-Gm-Message-State: APjAAAWGxe++iuyrvltoqla0hsNwG7L2H7edgLW+3KCCVxvRmrkUmpLH
        ecD2A6jXfIkWeQjUYkjAemSPey7B3T5C9w==
X-Google-Smtp-Source: APXvYqxiTtaGGEq+HJEQ+AwpHljQqAyAdkIZSZeusj07b5AOIYbLTrg3cKYPiGKXHx2lQmbIGQMfcw==
X-Received: by 2002:a6b:d119:: with SMTP id l25mr1172041iob.44.1575325864515;
        Mon, 02 Dec 2019 14:31:04 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k6sm191184iom.52.2019.12.02.14.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 14:31:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     carter.li@eoitek.com
Subject: [PATCHSET 0/2] Ensure all needed read/write data is stable
Date:   Mon,  2 Dec 2019 15:30:59 -0700
Message-Id: <20191202223101.10836-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we don't copy the associated iovecs when we punt to async
context, and this can prove problematic if the caller only ensures
the iovec is valid for the submission. This is a perfectly valid
assumption, and I think io_uring should make sure that this is safe
to do.

First patch is a prep patch, second patch adds the necessary support
for IORING_OP_READV and IORING_OP_WRITEV to handle this appropriately.
We really need to do the same for the other calls that pass in pointers
to structs, like sendmsg/recvmsg, connect, and accept. I will deal with
those next.

Also see: https://github.com/axboe/liburing/issues/27

-- 
Jens Axboe


