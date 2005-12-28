Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVL1Rhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVL1Rhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVL1Rhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:37:45 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:46084 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932536AbVL1Rho convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:37:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fcQMYMsyWxyBCaCbdeIfIjbyqyGMAd3GKzoDCS1jdMrVwdfp1/dwIWCZslDHweiR2Zp0LZvc+oJRKQFALHTQO2Gr3txzgxEs+36Sg5hMkVamPgQYrXoaTrXxosgHEkxv73JlLAQOyflaswVtbkj2d0EH2DMiYpdK1tma8JMDwCo=
Message-ID: <82e4877d0512280937k21cc6b68s356093083ef2ce63@mail.gmail.com>
Date: Wed, 28 Dec 2005 12:37:43 -0500
From: Parag Warudkar <parag.warudkar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc7] udf/balloc.c : Fix use of uninitialized data
Cc: akpm@osdl.org
In-Reply-To: <82e4877d0512280913s66a43d4ida9eda3640520c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <82e4877d0512280913s66a43d4ida9eda3640520c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add Signed-off-by - corrected patch follows -

Signed-off-by: Parag Warudkar <parag.warudkar@gmail.com>

Variable goal_eloc is automatic, non-static and initialized conditionally.
 The following patch fixes this by initializing the goal_eloc variable to zero.
Hopefully zero should be better than some random data! (Patch also
attached in case of problem with below inline version.) Compile
tested.

--- linux-2.6/fs/udf/balloc.c.orig      2005-12-28 11:53:12.000000000 -0500
+++ linux-2.6/fs/udf/balloc.c   2005-12-28 11:53:19.000000000 -0500
@@ -754,7 +754,8 @@ static int udf_table_new_block(struct su
        uint32_t spread = 0xFFFFFFFF, nspread = 0xFFFFFFFF;
        uint32_t newblock = 0, adsize;
        uint32_t extoffset, goal_extoffset, elen, goal_elen = 0;
-       kernel_lb_addr bloc, goal_bloc, eloc, goal_eloc;
+       kernel_lb_addr bloc, goal_bloc, eloc,
+       goal_eloc = { .logicalBlockNum=0, .partitionReferenceNum=0 } ;
        struct buffer_head *bh, *goal_bh;
        int8_t etype;
