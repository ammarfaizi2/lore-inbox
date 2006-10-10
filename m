Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWJJI2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWJJI2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWJJI2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:28:17 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30599 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965084AbWJJI2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:28:16 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
Subject: [PATCH] spufs: fix  support for read/write on cntl
Date: Tue, 10 Oct 2006 10:27:29 +0200
User-Agent: KMail/1.9.4
Cc: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3E7@jptkyxms38.jp.sony.com>
In-Reply-To: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3E7@jptkyxms38.jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101027.30329.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>

This fixes a memory leak introduced by "spufs: add support
for read/write oncntl", which was missing a call to simple_attr_close.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

On Tuesday 10 October 2006 08:49, Noguchi, Masato wrote:
> Oops,
> I'm so sorry. I mistake to send wrong patch.

Ok, no worries. Paul, please use this patch instead.

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -246,6 +246,7 @@ static int spufs_cntl_open(struct inode 
 
 static struct file_operations spufs_cntl_fops = {
 	.open = spufs_cntl_open,
+	.release = simple_attr_close,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
 	.mmap = spufs_cntl_mmap,
