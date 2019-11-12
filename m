Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CD5C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 23:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB29F214E0
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 23:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0yhQwTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLXrq (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:47:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34510 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726912AbfKLXrq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 18:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573602465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a1U6YEKeY8ejcQLp8MjVHKTX9RyQ4PKKjGL2Mb80pEg=;
        b=P0yhQwTrxIBPo6NRPv0FetYhSC0zxA8dNxUZYHvsQdhgfqfLleC+ZpOcV5Pl2+eytY5So3
        Qv0K4CTdl8Kjoaov/+CrgaRZV5va82p6uukaZ4lcmGsaBANeGCubr99kpmhuYCmtcwGwGk
        PnUch9LnUoJ6XzcVC6bhuyoPRFrC2GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-etL_mD1uMp6xOKq4tRRJjg-1; Tue, 12 Nov 2019 18:47:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8260C800C72;
        Tue, 12 Nov 2019 23:47:42 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 282B35DDA8;
        Tue, 12 Nov 2019 23:47:41 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk
Subject: [liburing patch] test: fix up dead code bugs
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 12 Nov 2019 18:47:41 -0500
Message-ID: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: etL_mD1uMp6xOKq4tRRJjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Coverity pointed out some dead code.  Fix it.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/test/fsync.c b/test/fsync.c
index e6e0898..3c67190 100644
--- a/test/fsync.c
+++ b/test/fsync.c
@@ -96,14 +96,14 @@ static int test_barrier_fsync(struct io_uring *ring)
 =09io_uring_sqe_set_flags(sqe, IOSQE_IO_DRAIN);
=20
 =09ret =3D io_uring_submit(ring);
-=09if (ret < 5) {
-=09=09printf("Submitted only %d\n", ret);
-=09=09goto err;
-=09} else if (ret < 0) {
+=09if (ret < 0) {
 =09=09printf("sqe submit failed\n");
 =09=09if (ret =3D=3D EINVAL)
 =09=09=09printf("kernel may not support barrier fsync yet\n");
 =09=09goto err;
+=09} else if (ret < 0) {
+=09=09printf("Submitted only %d\n", ret);
+=09=09goto err;
 =09}
=20
 =09for (i =3D 0; i < 5; i++) {
diff --git a/test/nop.c b/test/nop.c
index 1373695..4b072fc 100644
--- a/test/nop.c
+++ b/test/nop.c
@@ -62,12 +62,12 @@ static int test_barrier_nop(struct io_uring *ring)
 =09}
=20
 =09ret =3D io_uring_submit(ring);
-=09if (ret < 8) {
-=09=09printf("Submitted only %d\n", ret);
-=09=09goto err;
-=09} else if (ret < 0) {
+=09if (ret < 0) {
 =09=09printf("sqe submit failed: %d\n", ret);
 =09=09goto err;
+=09} else if (ret < 8) {
+=09=09printf("Submitted only %d\n", ret);
+=09=09goto err;
 =09}
=20
 =09for (i =3D 0; i < 8; i++) {
diff --git a/test/stdout.c b/test/stdout.c
index 7b64c8c..b12d75c 100644
--- a/test/stdout.c
+++ b/test/stdout.c
@@ -28,12 +28,12 @@ static int test_pipe_io(struct io_uring *ring)
 =09io_uring_prep_writev(sqe, STDOUT_FILENO, &vecs, 1, 0);
=20
 =09ret =3D io_uring_submit(ring);
-=09if (ret < 1) {
-=09=09printf("Submitted only %d\n", ret);
-=09=09goto err;
-=09} else if (ret < 0) {
+=09if (ret < 0) {
 =09=09printf("sqe submit failed: %d\n", ret);
 =09=09goto err;
+=09} else if (ret < 1) {
+=09=09printf("Submitted only %d\n", ret);
+=09=09goto err;
 =09}
=20
 =09ret =3D io_uring_wait_cqe(ring, &cqe);

