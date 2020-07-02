Return-Path: <SRS0=yY1C=AN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B8C433E0
	for <io-uring@archiver.kernel.org>; Thu,  2 Jul 2020 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEFF20780
	for <io-uring@archiver.kernel.org>; Thu,  2 Jul 2020 23:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XLXj8Isa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGBXG6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXG5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 2 Jul 2020 19:06:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827BC08C5C1
        for <io-uring@vger.kernel.org>; Thu,  2 Jul 2020 16:06:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a9so2651342pjh.5
        for <io-uring@vger.kernel.org>; Thu, 02 Jul 2020 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwFlnMCUcULaQ6jE2MkPtNJcbDl1avaWFVZFEMQif8Q=;
        b=XLXj8IsauQeabzvHcCbnq32qmOl+k16OwJQ2r/C13FWH99iZEyZY3wATs1fFX6M+EU
         SRqHwZog0RidwTuIotj6OfXMTNuNlUoY7uTV5napRfQLtBv9YVRCW5FFQjROwM/5kOQR
         uAM4q6nAZobM0rL8faMA1rB2kMFm5+JFiKeZFNj3oSgwo8jrGd9UMRJ8VBUTmYb6B4YU
         XJodcILf5MTgT9djqJ9N+g4VHD7BieU1bmySxkdRUneRA1Od0P9RHRUuCA7HDh0t5n6P
         xmnXUOehPIVhIL0yPACPgR8asnOSB4/d/EUg9NCzhUXP+TGgdlZvHxQ2KBwEyzApngLJ
         y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwFlnMCUcULaQ6jE2MkPtNJcbDl1avaWFVZFEMQif8Q=;
        b=RPljgnKG+2R61ax7qEXHx421iQZl24Q1T2mOUxyA7lCbZeMuvqp5Wz1mOziru0GX6b
         8MafTU9pNeF0TnP5mlYNGqD3HEZhDDRXnNR220RBjbEBrnyXj4MW9uy/2Jcx75niTmAQ
         bE2WI1EvU11h67RShevGVGZjXbzu+VeinmEEdp3J+pcxmLtEVTuEAFwVsClvgWd5mmK5
         EB7c/qWutYKvMlSQMClH5VPdMBzuB5S/EHkfSSyzUZ2HRMAyOmdxxiyz05qsHBXaD328
         fFozA1JhR/OiCfQv5LifPdIjQvZa2FZQmwUE9/rHbnlD7QSGdDVfNIj1tcejFaAjHOJD
         msvQ==
X-Gm-Message-State: AOAM533KPI+wmBb/aEdBeYEA+ZM4uDhaXpDkZr9vlXhCOEp2TLxKyUqG
        qFo+CiOQbCx4vnHqEXXxvXOdXz1AC29RYA==
X-Google-Smtp-Source: ABdhPJzkEiwE2j3QCwrtikw503bc28rOt3gu1VudtBpvbjEjz7hF7RMNMdPXJfbmuNOcuSiy5bp82A==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr34461724pjb.111.1593731216921;
        Thu, 02 Jul 2020 16:06:56 -0700 (PDT)
Received: from x1.mib2p ([204.156.180.104])
        by smtp.gmail.com with ESMTPSA id j36sm10024463pgj.39.2020.07.02.16.06.55
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:06:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 5.9 0/2] io_uring task_work cleanups
Date:   Thu,  2 Jul 2020 17:06:51 -0600
Message-Id: <20200702230653.1379419-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Nothing exciting here, just a set of cleanups around task_work.

-- 
Jens Axboe


