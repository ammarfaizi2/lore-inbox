Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWF2Vp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWF2Vp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbWF2VoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:20 -0400
Received: from mx.pathscale.com ([64.160.42.68]:39311 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932912AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 33 of 39] IB/ipath - read/write correct sizes through diag
	interface
X-Mercurial-Node: a7c1ad1e090b34dab63255369cdd85bbcc835174
Message-Id: <a7c1ad1e090b34dab632.1151617284@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:24 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We must increment uaddr by size we are reading or writing, since it's
passed as a char *, not a pointer to the appropriate size.

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 8fbb5d71823a -r a7c1ad1e090b drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Jun 29 14:33:26 2006 -0700
@@ -115,7 +115,7 @@ static int ipath_read_umem64(struct ipat
 			goto bail;
 		}
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u64);
 	}
 	ret = 0;
 bail:
@@ -154,7 +154,7 @@ static int ipath_write_umem64(struct ipa
 		writeq(data, reg_addr);
 
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u64);
 	}
 	ret = 0;
 bail:
@@ -192,7 +192,8 @@ static int ipath_read_umem32(struct ipat
 		}
 
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u32);
+
 	}
 	ret = 0;
 bail:
@@ -231,7 +232,7 @@ static int ipath_write_umem32(struct ipa
 		writel(data, reg_addr);
 
 		reg_addr++;
-		uaddr++;
+		uaddr += sizeof(u32);
 	}
 	ret = 0;
 bail:
