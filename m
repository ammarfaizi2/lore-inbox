Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC15C43331
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB132077C
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 21:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvMXrEGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfKGVTE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:19:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725770AbfKGVTD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 16:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573161542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=av2lg5LGM9tY5c6/p6CY9hPISd+826dc9jBqXLg6XQE=;
        b=EvMXrEGYig5w3KDMBLBgw6Uprqv/bg4BoWaGRXA64tUh6s+YNabwiJ1eZd7SXx87ss0yti
        nsR4POEBIxr/3Lk48Af3zGa0Z92yL2n+E8NnnTGxLbhePa65eme+2CG/LRhSm+4GrApt9W
        H/ru2Yo68yIMCwYeVSiGlsgLVjYSECk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-nrgVwOhFOyGVU1Fl5TCw9g-1; Thu, 07 Nov 2019 16:18:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0CD5107ACC3;
        Thu,  7 Nov 2019 21:18:58 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D9695DA76;
        Thu,  7 Nov 2019 21:18:58 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org
Subject: [liburing patch] document IORING_SETUP_CQSIZE
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 07 Nov 2019 16:18:57 -0500
Message-ID: <x49ftizz8ou.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nrgVwOhFOyGVU1Fl5TCw9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Add text in the io_uring_setup man page for the IORING_SETUP_CQSIZE
option.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/man/io_uring_setup.2 b/man/io_uring_setup.2
index 9ab0143..c6e3dec 100644
--- a/man/io_uring_setup.2
+++ b/man/io_uring_setup.2
@@ -131,6 +131,13 @@ field of the
 This flag is only meaningful when
 .B IORING_SETUP_SQPOLL
 is specified.
+.TP
+.B IORING_SETUP_CQSIZE
+Create the completion queue with
+.IR "struct io_uring_params.cq_entries"
+entries.  The value must be greater than
+.IR entries ,
+and may be rounded up to the next power-of-two.
 .PP
 If no flags are specified, the io_uring instance is setup for
 interrupt driven I/O.  I/O may be submitted using
@@ -300,11 +307,15 @@ params is outside your accessible address space.
 The resv array contains non-zero data, p.flags contains an unsupported
 flag,
 .I entries
-is out of bounds, or
+is out of bounds,
 .B IORING_SETUP_SQ_AFF
 was specified, but
 .B IORING_SETUP_SQPOLL
-was not.
+was not, or
+.B IORING_SETUP_CQSIZE
+was specified, but
+.I io_uring_params.cq_entries
+was invalid.
 .TP
 .B EMFILE
 The per-process limit on the number of open file descriptors has been

