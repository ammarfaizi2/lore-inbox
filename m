Return-Path: <SRS0=xzJI=55=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F3C2BA19
	for <io-uring@archiver.kernel.org>; Mon, 13 Apr 2020 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002F92072D
	for <io-uring@archiver.kernel.org>; Mon, 13 Apr 2020 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SzcAiu1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgDMRWD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732579AbgDMRWD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 13 Apr 2020 13:22:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C2C0A3BDC
        for <io-uring@vger.kernel.org>; Mon, 13 Apr 2020 10:22:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w11so4714050pga.12
        for <io-uring@vger.kernel.org>; Mon, 13 Apr 2020 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESe/ViTItUM6guxstHPQRYVYJBOwh4O17wPhnJQcKbk=;
        b=SzcAiu1wbPFwpg648nRmgStYQFlMuMMcKrzS3zeQ25udm/6A179gLtgPXjtwhRQ5za
         WQu7KimhBIXyMJ1DaQ9m0wl1Cc3X61URR1jOXR9NpwYeAwmcBGyyXEon7p/DSfZLOlI2
         T5VbGdKvHniKNyq5KxiclslFYxEqdxE08qRrcXibmy1JSsJxX12WoUtFXl8NyQ2e/CLy
         UxZnSY4GUV1eFWVpkY+zrRGOX79tkaCCwEdpXYcdytCySJbBlz7ZwomI+PFa/zTwbm6I
         FaR3v0rr3XWjxjKXKIlMBt6P8P2Fs95qgW95IxeqKREqn18kfSieotyx2d0HtCgBvJAZ
         EV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESe/ViTItUM6guxstHPQRYVYJBOwh4O17wPhnJQcKbk=;
        b=MWJW79z0ClhEcqJ6Oa4NzfL7TnvejGeUy7NS9fWmnK4KEj/FdMPfKdptjgwgZxpC3B
         oiXouY/dLPq8LSRADVn2vWFJSiL7iY/CzeVCLpPp5EApuVBqIzaQOuSM/yQ/ku8FkQ0j
         GMQJZxSy/LqEwr8lvEIpczf/ByGSIoaTEvtfzlsFFpG+zy7sZRgKMIx1lGsBiaWwStP4
         P/ICasZDnCMwvVAwGfgxFzWTrK/8GEbVwELIE5frUOYgwwV1kfz1d2xyRZLcRc1zEGW+
         bdm9Mf/bn4+e1ccINqTs0Ckj1cR3fMiYxcFXdLxKwj7Vc2W+LhqzDPZjBEuEEMWDfwnz
         y0Cg==
X-Gm-Message-State: AGi0PuYv/aQf0tmfQoBgc075iHMXH0LJ/S1TxO5EkN8AyehgI4u96PgY
        RqJzrFw3yYS7vkxUgHsJBfxOxjBVJ85dTQ==
X-Google-Smtp-Source: APiQypIHwfFw60D3ln+yM4swAolsnFn4X/ozjHTtnLFM31IiWKO2PoMbWKsC3TniqC2YWdAd+u4UDQ==
X-Received: by 2002:a63:ee46:: with SMTP id n6mr6194895pgk.266.1586798521679;
        Mon, 13 Apr 2020 10:22:01 -0700 (PDT)
Received: from x1.localdomain ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v25sm8615686pgl.55.2020.04.13.10.22.00
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:22:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 0/2] io_uring async poll fixes
Date:   Mon, 13 Apr 2020 11:21:56 -0600
Message-Id: <20200413172158.8126-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Just two minor fixes here that should go into 5.7:

- Honor async request cancelation instead of trying to re-issue when
  it triggers

- Apply same re-wait approach for async poll that we do for regular poll,
  in case we get spurious wakeups.

-- 
Jens Axboe


