Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWI3MPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWI3MPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWI3MPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:15:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:16882 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750938AbWI3MPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:15:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=Oo3GbDgvWJ9yNb4BfYr08mc2aNuCO2JWe8uw4bpLFJTV9+qaIitRdsxhmBtU9evHjc1E+VwLcJ5foJo1PHp9IhjJiMEiNuVSA0NO9S4LHEg6xEZ2RNIWhf3gDE74Cu31y3A2xOlOhQMGzZ9oqi/MIN8LNzz+xPHRRbNgtoi5KI0=
Date: Sat, 30 Sep 2006 14:13:48 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [-mm patch] fix nftl_write warning
Message-ID: <20060930141348.GB1195@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Building 2.6.18-mm2 issues the following warning if CONFIG_NFTL_RW is not set:
  CC [M]  drivers/mtd/nftlcore.o
drivers/mtd/nftlcore.c:183: warning: 'nftl_write' defined but not used
The following patch only compiles nftl_write if CONFIG_NFTL_RW is set.

Regards,
Frederik


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index dd5cea8..b5a5f8d 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -175,6 +175,8 @@ int nftl_write_oob(struct mtd_info *mtd,
 	return res;
 }
 
+#ifdef CONFIG_NFTL_RW
+
 /*
  * Write data and oob to flash
  */
@@ -196,8 +198,6 @@ static int nftl_write(struct mtd_info *m
 	return res;
 }
 
-#ifdef CONFIG_NFTL_RW
-
 /* Actual NFTL access routines */
 /* NFTL_findfreeblock: Find a free Erase Unit on the NFTL partition. This function is used
  *	when the give Virtual Unit Chain
