Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C23C4742C
	for <io-uring@archiver.kernel.org>; Fri, 13 Nov 2020 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5C220791
	for <io-uring@archiver.kernel.org>; Fri, 13 Nov 2020 23:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0vFkjnEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKMXvf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKMXvf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 13 Nov 2020 18:51:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD21C0613D1
        for <io-uring@vger.kernel.org>; Fri, 13 Nov 2020 15:51:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 62so8356472pgg.12
        for <io-uring@vger.kernel.org>; Fri, 13 Nov 2020 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JgQSAw5E2bIGSZOAS6+C2I08tRyjVW0ZRu+srJkJ8Q=;
        b=0vFkjnEKSVLWUJArD7PO2KDuOTuecmia6eDfFPkJeGEKsdFf70tlFoSXJODKCmIOLW
         ls3jL5CU+lZV/DzL2HoPYUd+ujBoGDHC5NjmRDzHqDpfo1ihEw+b5A5RM7Ub2aweAfUQ
         Sr73uJixrJnmvaj/UI0KU3l9LzgpW3WYbABF3NuiH2rmslP5dFimIWSfTi1fkT8RDEZE
         l725cmjIiSTxoOy0FDaFwagYOmaFEiboyBEd/bBV4jHwofeT9Ec8mhdRTwwnooZ2AHmL
         L7RVtccd/ZendSWvGV7XROXhwesBvPOflkKN1ZtRZ7IvYVCXMRw5j43sMGL/KLEHMKgu
         z75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JgQSAw5E2bIGSZOAS6+C2I08tRyjVW0ZRu+srJkJ8Q=;
        b=Ckjc99p6NrhIosjcMEu54F26SxGF8/vhA9F3XYWJSya5DPKtkvBbiPUE8a//uL8Ztr
         Zr+NTMnzNMgtiYvYFfC8gRS1VYYa1pycWTmCMKxWnMTGfrSgVLJlAIB8Pyqge9q40k2M
         YFbY+m8CfUN4INrpwsXhfLVSQts5VGFm3dOkLxKrswV0Kme0/ia6VJ0o1tHgB+Y+N9Z6
         dHehqYgEosJB/PN/EDihEPu8VDnUVNBq58Am+f9mj4nIqmCNxV9nZSpQSMXj/d5f/Nsq
         E4aPY0cSAQ2XBZtA1ahvkm988pYbv/E2uvmOAqQGp+Baj5V1IVTFnaDpoAjfk2b/2A54
         UWJg==
X-Gm-Message-State: AOAM5308n3PhBsXPf6QZPJjMlcmIYboe5vkOVJEbCBxubox1LvvkK/G7
        g4ymb12Ciyal6tD6u3bHw8cr09hkf1sbKA==
X-Google-Smtp-Source: ABdhPJzTdSjV11XTAdCVSq2E3I2d+sBQ6BFi+39YlOARMegerGZOnKDUywW0d3MgCJGJG5n3q7oPOQ==
X-Received: by 2002:a62:870c:0:b029:18b:d345:70f3 with SMTP id i12-20020a62870c0000b029018bd34570f3mr4324343pfe.30.1605311494000;
        Fri, 13 Nov 2020 15:51:34 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n4sm2634751pgh.12.2020.11.13.15.51.32
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 15:51:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 0/2] Fix async path resolution
Date:   Fri, 13 Nov 2020 16:51:28 -0700
Message-Id: <20201113235130.552593-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi,

Looking up anything in /proc/self from the io-wq worker doesn't always
yield the right result. We can't easily add the necessary context, so
until we can, forbid the lookup and have the task do it itself.

-- 
Jens Axboe


