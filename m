Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWI1QH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWI1QH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWI1QHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:07:53 -0400
Received: from mx.pathscale.com ([64.160.42.68]:1974 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751728AbWI1QBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:23 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 28] IB/ipath - fix compiler warnings and errors on
	non-x86_64 systems
X-Mercurial-Node: 2a328f7db58fad9a19ff44a979ad4d5227cf6d17
Message-Id: <2a328f7db58fad9a19ff.1159459209@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:09 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r a7ba4b73f972 -r 2a328f7db58f drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:12 2006 -0700
@@ -206,11 +206,10 @@ static int ipath_get_base_info(struct fi
 		kinfo->spi_subport_rcvhdr_base =
 			(u64) pd->subport_rcvhdr_base & MMAP64_MASK;
 		ipath_cdbg(PROC, "port %u flags %x %llx %llx %llx\n",
-			kinfo->spi_port,
-			kinfo->spi_runtime_flags,
-			kinfo->spi_subport_uregbase,
-			kinfo->spi_subport_rcvegrbuf,
-			kinfo->spi_subport_rcvhdr_base);
+			kinfo->spi_port, kinfo->spi_runtime_flags,
+			(unsigned long long) kinfo->spi_subport_uregbase,
+			(unsigned long long) kinfo->spi_subport_rcvegrbuf,
+			(unsigned long long) kinfo->spi_subport_rcvhdr_base);
 	}
 
 	if (copy_to_user(ubase, kinfo, sizeof(*kinfo)))
