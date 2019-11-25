Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4BC432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068DB20659
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXh7Ni0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfKYUPI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:15:08 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37053 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYUPI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 15:15:08 -0500
Received: by mail-wm1-f48.google.com with SMTP id f129so732811wmf.2
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHVh+PNnim8ehMq4maake9r2qSZZFmrWNYmN5qAtsIc=;
        b=cXh7Ni0W1eU4G61P9rhtDo5GOE+WQLFToH7qHOEYzx+fhGoW/Yr7f1Z5LRqD1c+xe1
         EMwrcRXGuYcq6zTgWPe2j5KyCaFtXldiVybzUrYk4p9Ne7MvlcFGD0CQTPKOKU1b8Q5X
         z3/cPWK5ZSl+CKQQXu/Dy2KhglfzdFddObjY2IIXc7NAGW63JLnEV4Fs1OknVMzgf2IN
         VRIfJVMqB2U/5B7COK/XJJInGAPVoG6aWMFYqDqAWpfQrtG4v05zAT7CZPPp6Yaqae1o
         rXnq0YcoVuLSmZgXm8e306NXpJ5mSsq4IcRgt7U1r6zQ1TurUmiEYhqUGG4yjNpfzT7j
         n+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHVh+PNnim8ehMq4maake9r2qSZZFmrWNYmN5qAtsIc=;
        b=G7X1NHbrv21WaGzu2f+GD99Ug6De7qv1Cucf3sUech+qp3ZN9sYSK6/ZrMUGTxIQq6
         4ZkUIE6PnDoM/yS3z6uAOf5DBMHkGxPCZEHfu2FFxTUPvy/fOHV6SaAUytqrR+iUqaIy
         msWLm8nl6VbPapbgptHlpWgzhKJKm21fQ2Dyvk2MzIbpp7ZlWLh073Wj9fN7RQR8aZPm
         qYg6Km1G5LPB412RLBpp31bKcOMbab/pKQIkKQAKhmDFq2FKvKh7Kt2TwSlLdACboE+P
         aQ1wXrKOH7EbytI8c1859guytkHb0eBceXF1wZaXrxUIHlFvZM38CQFhaQjo1jy0e6Ok
         3Svg==
X-Gm-Message-State: APjAAAVp8evJ1igpcbKhlRImvVEL4YXmTRno/f4T+F6kmsWeIHzgL6Sl
        aEkktR46TRT0FffWbl+0dQg=
X-Google-Smtp-Source: APXvYqyWZnv5luxKv6QOOQCa1Axxmgm7ucY2o+jtIl/G5btlhI+D8uwdxUJznstjinUuRw2g3UQ8qQ==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr592803wmi.80.1574712906325;
        Mon, 25 Nov 2019 12:15:06 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id x7sm11584407wrq.41.2019.11.25.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:15:05 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCHSET 0/3] io_uring minor cleanup
Date:   Mon, 25 Nov 2019 23:14:37 +0300
Message-Id: <cover.1574712375.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

A set of a bit bulky but straightward cleanups.
The main part is removing/inlining struct sqe_submit.

Pavel Begunkov (3):
  io_uring: store timeout's sqe->off in proper place
  io_uring: inline struct sqe_submit
  io_uring: cleanup io_import_fixed()

 fs/io_uring.c | 188 +++++++++++++++++++++++---------------------------
 1 file changed, 87 insertions(+), 101 deletions(-)

-- 
2.24.0

