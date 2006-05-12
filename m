Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWELX5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWELX5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWELX5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:10 -0400
Received: from mx.pathscale.com ([64.160.42.68]:62633 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932283AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 42 of 53] ipath - increment pointer properly when doing a diag
	read
X-Mercurial-Node: 0aba84dce5063d74c3dad4a3e4a7ea8d8764ab8c
Message-Id: <0aba84dce5063d74c3da.1147477407@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:27 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 83f1832c6015 -r 0aba84dce506 drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Fri May 12 15:55:29 2006 -0700
@@ -113,7 +113,7 @@ static int ipath_read_umem64(struct ipat
 			goto bail;
 		}
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u64);
 	}
 	ret = 0;
 bail:
@@ -153,7 +153,7 @@ static int ipath_write_umem64(struct ipa
 		writeq(data, reg_addr);
 
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u64);
 	}
 	ret = 0;
 bail:
@@ -191,7 +191,8 @@ static int ipath_read_umem32(struct ipat
 		}
 
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u32);
+
 	}
 	ret = 0;
 bail:
@@ -230,7 +231,7 @@ static int ipath_write_umem32(struct ipa
 		writel(data, reg_addr);
 
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u32);
 	}
 	ret = 0;
 bail:
