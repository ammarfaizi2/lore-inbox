Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C58C43603
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5FA2053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CWTH+xD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJP5r (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:47 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:44415 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJP5r (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:47 -0500
Received: by mail-io1-f45.google.com with SMTP id z23so19250961iog.11
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuDXucHckgeeAXB1fxAFyJJDQE4Ncc2mRn8uM+PjxBY=;
        b=CWTH+xD+Yiiz+3NdIiqqi+8DOKAYZgMIzgX3cZRGYY/MA1w9CQRV6bfg4M9AY9acLE
         pULUc0XDsGYbuEH0wgual5cATAjp83TLBKXMvPkWIXzVehwNjbNVrQCqdjvVdnBCdtNg
         e/iDG39jfC3BzZhB3VXHr+6qXVNUCSGwQHYz/k6oR/KITGHlj3H38nT3qDyI4Zzxp6wf
         vt0TC0I1NKN5ujArIUQSQO8M6oXNg/7tZLEtggvApL486b/INou/LTZlbnvYIQ2E64XC
         C1jAKVbQofUUiNsFRpqhRRQOoFIICfszeA7XhLt8pf+hm27TmdK4uTSg2JjJbA7TEJ4l
         koOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuDXucHckgeeAXB1fxAFyJJDQE4Ncc2mRn8uM+PjxBY=;
        b=BaRdKkLTfgtsne05i1L8+R0mXkW9hky35KZjPc0aCbmi+3hR+AGsQhgsJPkcvLwT9+
         9hiyzf3sVgRTxAp35mKZdWmSMYHmD0Ebd566edYsaay0XhMbFv51GHWYgPFkkXLPxBcA
         xTh1dDv0GFg0vV5BiVt//4b0T05UN5SUDpdwxbXDYGwEgZyAPspVc/Ph7PETeQu+0tQ5
         A+RWJledZZaItvouMdIPxDnoqJJJ/BiA5njCAIkTjrabfjMAnAqzke9rfLQQ62/ahoLr
         VVekL4wCE22PSovJk9lK2Ga1CbL3eAtXKdhWQbe0y8okN5kcElCXp2bTirAroKLV1E+/
         zRww==
X-Gm-Message-State: APjAAAXHdOSukJZofkxyoWvNv+vTaVgDLcoTH3F0APE7Min1nLoKOvL5
        I1+jcgCXytnLiwtjmZx5e0shSLYjr/Q1fw==
X-Google-Smtp-Source: APXvYqwhwNCZsqhj9vtBOA/xqdO0nnbz63J/4CgQYAg8qVkZL04qI0CurKkduTgsfnEY9zjHAYa7gg==
X-Received: by 2002:a5e:8e04:: with SMTP id a4mr5377748ion.155.1575993466217;
        Tue, 10 Dec 2019 07:57:46 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.44
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 0/11] io_uring improvements/fixes for 5.5-rc
Date:   Tue, 10 Dec 2019 08:57:31 -0700
Message-Id: <20191210155742.5844-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Here's a list of patches I'm propsing for 5.5. The first 4 are the same
as the v1 posting, except I've made changes to the HARDLINK support
after Pavel's review.

The rest is just little tweaks and fixes. Also find them in my
io_uring-5.5 branch.

-- 
Jens Axboe


