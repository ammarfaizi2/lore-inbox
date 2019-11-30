Return-Path: <SRS0=jwyC=ZW=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2831C432C0
	for <io-uring@archiver.kernel.org>; Sat, 30 Nov 2019 02:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEB20869
	for <io-uring@archiver.kernel.org>; Sat, 30 Nov 2019 02:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZJHBHC0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfK3Cwl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 21:52:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37878 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfK3Cwk (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 29 Nov 2019 21:52:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so13662256plb.4
        for <io-uring@vger.kernel.org>; Fri, 29 Nov 2019 18:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CNgnbZ9uqIHTGRk+GinAMOG287w5oYysr926VSnVrqA=;
        b=ZJHBHC0dcCe3bub2ocBVheMfP/X03Hiov648L4LE9eKq5UxKZsGIcNSdoRnhXs2RNB
         Ni7SPOwcE40USE4hwOnu/GzVJqDGEKRlO3lJPbZswHO3W8fct5mISHbSCGf2Wv4Rkzmv
         4lYMKCE5sVzRpgWE9GIbzJV6c6gaB4fHu3eBMrfBBmv+pkQpKTJ+l5di2minsJzkuKXd
         akNvRPTMcmD+rY6BMtwLbvZO3HrjpSRG56Ev2wt1amhNtIzunBYsLcBAa4cpiWynSD+e
         gULJojOP9+CuAOcUtR6HfV4DPtJI9NOEeRnpQKlNhCr7D6JhNhaSJyQm+ITFGgE2NLPk
         gnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CNgnbZ9uqIHTGRk+GinAMOG287w5oYysr926VSnVrqA=;
        b=XmFyatCXQQFTWd08tQGosJu/HJl+BoZHpdn37Gtb2yZ+qibhOSGKG49ZRfVJRSBvr+
         AqGXMgbmnPu1FlPt6H2vIF9h0WmaDeWpoTAiAS9K3L49oGu+BdjTV79ev8EQnPow2/1P
         Mb0mBKMsp/7Ksk6wpB50hfhjupoBQ/omqAD4z4NwTz5bEbjySAOJjaJ8VmUWhGSeko+M
         LgGWilIWu6E/g+hMq+5jy2gVgUJuzke3aiJFzLOOGaoPBFq9ULvRP7xUHyZ+rAuVSj67
         4fMtDyebbtVBWAy1ZHzS+nMAQwgpyf1IOfvOpWYCKh2lTAW8OYjyGRFDVnZrRE0mC5Hn
         9Q0A==
X-Gm-Message-State: APjAAAXJvWJfswuem/KZsG6mLH5qrhOB5XHbXXc/SNP0gJfNj/yYl0VD
        JksSUAFa3CJ3/RrVjDl2H2kAX/b7AtkXRQ==
X-Google-Smtp-Source: APXvYqxZ9XMY8IJkzTICSvEHYgXrdlsYAYyQtgl+Ho3W9FV846mCcCFxt2w10gWPaRTcCOix/tEpNw==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr15506680plp.99.1575082358279;
        Fri, 29 Nov 2019 18:52:38 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:9062:6a04:387d:c19c? ([2605:e000:100e:8c61:9062:6a04:387d:c19c])
        by smtp.gmail.com with ESMTPSA id q4sm24822797pgp.30.2019.11.29.18.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 18:52:37 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Fixes for 5.5-rc1
Message-ID: <217fa992-cdb0-22b5-b561-e461e3c8c3b8@kernel.dk>
Date:   Fri, 29 Nov 2019 18:52:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Linus,

Wasn't going to send this one off so soon, but unfortunately one of the
fixes from the previous pull broke the build on some archs. So I'm
sending this sooner rather than later. This pull request contains:

- Add highmem.h include for io_uring, because of the kmap() additions
   from last round. For some reason the build bot didn't spot this even
   though it sat for days.

- Three minor ';' removals

- Add support for the Beurer CD-on-a-chip device

- Make io_uring work on MMU less archs

Please pull!


   git://git.kernel.dk/linux-block.git tags/for-linus-20191129


----------------------------------------------------------------
Diego Elio Pettenò (2):
       cdrom: respect device capabilities during opening action
       sr_vendor: support Beurer GL50 evo CD-on-a-chip devices.

Jens Axboe (1):
       io_uring: fix missing kmap() declaration on powerpc

Roman Penyaev (1):
       io_uring: add mapping support for NOMMU archs

zhengbin (3):
       drbd: Remove unneeded semicolon
       block: sunvdc: Remove unneeded semicolon
       ataflop: Remove unneeded semicolon

  drivers/block/ataflop.c       |  2 +-
  drivers/block/drbd/drbd_req.c |  2 +-
  drivers/block/sunvdc.c        |  2 +-
  drivers/cdrom/cdrom.c         | 12 ++++++++-
  drivers/scsi/sr_vendor.c      | 18 ++++++++++++++
  fs/io_uring.c                 | 58 ++++++++++++++++++++++++++++++++++++++-----
  6 files changed, 84 insertions(+), 10 deletions(-)

-- 
Jens Axboe

