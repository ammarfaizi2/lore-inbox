Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241BC5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89902087E
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 15:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQeF+X9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbfKEPd0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:33:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389399AbfKEPd0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 10:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572968005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1l1k+QnzLSFnvfngXuELUOYZtMr3G0iV7dGkIVXrzGM=;
        b=JQeF+X9ai7jtTEJaoLD1vprXHjepq84Ua5HlKi5nRttnvj3lC7ST4UZiohLjjD/NXdlrGj
        hJMQh0uJsano3va/zkCFGB8SDerfujkHDNXhRzPUlP6BbVHENVpGj3NIH8rpGyZIqKU++g
        SDOGneZBaUKXSxcPrD/vEcdw7nezAkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-EFUTwJ4kPBScI1diwmdVQg-1; Tue, 05 Nov 2019 10:33:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A824107ACC3;
        Tue,  5 Nov 2019 15:33:21 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9998289AC;
        Tue,  5 Nov 2019 15:33:20 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [liburing patch] barrier.h: add generic smp_mb implementation
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 05 Nov 2019 10:33:19 -0500
Message-ID: <x49k18e9w3k.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EFUTwJ4kPBScI1diwmdVQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This missing define causes build failures on s390:

  src/include/liburing.h:298: undefined reference to `io_uring_smp_mb'

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/src/include/liburing/barrier.h b/src/include/liburing/barrier.=
h
index fc40a8a..aca308a 100644
--- a/src/include/liburing/barrier.h
+++ b/src/include/liburing/barrier.h
@@ -76,6 +76,7 @@ do {=09=09=09=09=09=09\
  * Add arch appropriate definitions. Be safe and use full barriers for
  * archs we don't have support for.
  */
+#define io_uring_smp_mb()=09__sync_synchronize()
 #define io_uring_smp_rmb()=09__sync_synchronize()
 #define io_uring_smp_wmb()=09__sync_synchronize()
 #endif /* defined(__x86_64__) || defined(__i386__) */

