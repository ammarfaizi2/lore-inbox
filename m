Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC4C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C22120656
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 14:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gpkiVVBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfKLO7B (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:59:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39076 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfKLO7A (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 09:59:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so9489590plk.6
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 06:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zzeupHCZgldZNZ3i0l8Y26rk8uKb258smJQs+egMdxs=;
        b=gpkiVVBwptKXL7GL0HgSMMCae/kggN/RlgJ44i+kmkVWlH2DrCRAbf6urXdUe19L2M
         6LsUnG0FfeVM4PmqGZb4eOsyLFEOQJs5vLZ2t0utyTkkhSyTgWrk5QKKI5zxQjdQUGEe
         dFHCWv/twDK3kbn/DBcrp7se0sYRm/STcWfN/I0aVlh+MUzLFIeUj72IMdz2kQJcOaUL
         W9DvgCm9NWsqxhusMglNeNEVuDPSvVakeS8HClfC2xV8jecP9VcbpFVcvnSWE/z3yMHY
         aIECDQE3Skg4FhpWiNX8LIdtKa4nGxUamzz/X9f1HisABcEsY7HP8Bz2UyjC/m/cuXLV
         ta7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zzeupHCZgldZNZ3i0l8Y26rk8uKb258smJQs+egMdxs=;
        b=f555tIDS1hvIvp41c9HZNuqPzslY38wPpJ7FMZerDXIVUbpS+faHhyIp8QD7halE4r
         z6RKongtGnys1dhS7ujL5GDBZQ/rRvM10ZfYh9NT/IVEwe0zMdrT9+EWHt/f/SIzARn+
         7kCaKL8WlE7oiuykE4EdFLbrtXK9LZbG9S+iCYwg/DSCPPnTZAZ+jRV9xWT3wLdvCuDg
         mOKNZmNmywy7UWg84NlsGEGP8yQV3v/OU3NJkj61Yg0nBHrmlAXtokl1v20u7RLLU4t3
         P9ogbE0WQ/6l9UVX7et+Kf4s3FDHP9eyaaG3C6JwZklfpoSvRJOaZ/wp+8Rc7IC6s486
         9e1A==
X-Gm-Message-State: APjAAAWefjewlWY5aqfwqxuqaa/YKrJs6LKp/hR7PPbvF/Yx7G6E1BRn
        Bz0RlLOICfHerkZzVCUssDOE92qXDOY=
X-Google-Smtp-Source: APXvYqwzo1NGoKSd9m+HHBJHqLMlENa/Xspm+MNBWk71yShmefuyy3Qucpx+mfEpoGnBeG0F5+TA9Q==
X-Received: by 2002:a17:902:b68b:: with SMTP id c11mr19663078pls.17.1573570739550;
        Tue, 12 Nov 2019 06:58:59 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id h195sm2973266pfe.88.2019.11.12.06.58.57
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 06:58:58 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: use correct "is IO worker" helper
Message-ID: <fcf4ecd5-f544-4ad0-44b9-96a451eae160@kernel.dk>
Date:   Tue, 12 Nov 2019 06:58:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Since we switched to io-wq, the dependent link optimization for when to
pass back work inline has been broken. Fix this by providing a suitable
io-wq helper for io_uring to use to detect when to do this.

Fixes: 561fb04a6a22 ("io_uring: replace workqueue usage with io-wq")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io-wq.h b/fs/io-wq.h
index 8cb345256f35..cc50754d028c 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -62,4 +62,8 @@ static inline void io_wq_worker_running(struct task_struct *tsk)
 }
 #endif
 
+static inline bool io_wq_current_is_worker(void)
+{
+	return in_task() && (current->flags & PF_IO_WORKER);
+}
 #endif
diff --git a/fs/io_uring.c b/fs/io_uring.c
index a0a69f115677..a37daa0e9893 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -871,7 +871,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 			/* we dropped this link, get next */
 			nxt = list_first_entry_or_null(&req->link_list,
 							struct io_kiocb, list);
-		} else if (nxtptr && current_work()) {
+		} else if (nxtptr && io_wq_current_is_worker()) {
 			*nxtptr = nxt;
 			break;
 		} else {

-- 
Jens Axboe

