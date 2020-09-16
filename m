Return-Path: <SRS0=p23A=CZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6013CC43461
	for <io-uring@archiver.kernel.org>; Wed, 16 Sep 2020 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F252C206E6
	for <io-uring@archiver.kernel.org>; Wed, 16 Sep 2020 17:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2pVdDJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgIPRrT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbgIPRrK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 16 Sep 2020 13:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600278422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F9u9qYwCYGwnKvUW3Qwuq0EBArWLV1qdPypf2tsQD8g=;
        b=C2pVdDJrzy/OclyUNgubKdwhQ0MkubJ//8jQh/mcU8Yv2qqjH7jCSiEeiB/4IRYS10Yx00
        NU/SS6ALMYBEgqBkfWyp8Wf1GWdrcEqbVucxzqnEmWye9GuV/AP2mUoDi36iujasYGXU3U
        SspExmQxkxAX6DfQOl3HHUE1RtQF8O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-2wAkm_qOOlCvPo6x_Jpw7A-1; Wed, 16 Sep 2020 08:23:36 -0400
X-MC-Unique: 2wAkm_qOOlCvPo6x_Jpw7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 225D580F04E;
        Wed, 16 Sep 2020 12:23:35 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-13-242.pek2.redhat.com [10.72.13.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDBC87EEA7;
        Wed, 16 Sep 2020 12:23:30 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     io-uring@vger.kernel.org
Subject: [PATCH 0/3] src/feature: add IO_URING feature checking
Date:   Wed, 16 Sep 2020 20:23:24 +0800
Message-Id: <20200916122327.398-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This patchset bases on https://patchwork.kernel.org/cover/11769847/, which
makes xfstests fsstress and fsx supports IO_URING.

The io_uring IOs in fsstress will be run automatically when fsstress get
running. But fsx need a special option '-U' to run IO_URING read/write, so
add two new cases to xfstests to do fsx buffered and direct IO IO_URING
test.

[1/3] new helper to require io_uring feature
[2/3] fsx buffered IO io_uring test
[3/3] fsx direct IO io_uring test

And the [2/3] just found an io_uring regression bug (need LVM TEST_DEV):
https://bugzilla.kernel.org/show_bug.cgi?id=209243

Feel free to tell me, if you have more suggestions to test io_uring on
filesystem.

Thanks,
Zorro

