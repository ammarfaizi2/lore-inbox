Return-Path: <linux-kernel-owner+w=401wt.eu-S1755037AbWL2CKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbWL2CKi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 21:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755039AbWL2CKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 21:10:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1810 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755034AbWL2CKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 21:10:24 -0500
Date: Fri, 29 Dec 2006 03:10:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Artem Bityutskiy <dedekind@infradead.org>,
       dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [-mm patch] drivers/mtd/ubi/vtbl.c: make 2 functions static
Message-ID: <20061229021027.GP20714@stusta.de>
References: <20061228024237.375a482f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc1-mm1:
>...
>  git-ubi.patch
>...
>  git trees
>...

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/ubi/vtbl.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.20-rc2-mm1/drivers/mtd/ubi/vtbl.c.old	2006-12-29 01:52:47.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/mtd/ubi/vtbl.c	2006-12-29 01:53:30.000000000 +0100
@@ -178,8 +178,8 @@
 	return 0;
 }
 
-const struct ubi_vtbl_vtr *get_ivol_vtr(const struct ubi_info *ubi,
-					    int vol_id);
+static const struct ubi_vtbl_vtr *get_ivol_vtr(const struct ubi_info *ubi,
+					       int vol_id);
 
 const struct ubi_vtbl_vtr *ubi_vtbl_get_vtr(const struct ubi_info *ubi,
 					    int vol_id)
@@ -237,7 +237,7 @@
 
 static void __exit free_volume_info(const struct ubi_info *ubi);
 
-void __init init_ivols(struct ubi_info *ubi);
+static void __init init_ivols(struct ubi_info *ubi);
 
 int __init ubi_vtbl_init_scan(struct ubi_info *ubi, struct ubi_scan_info *si)
 {
@@ -778,7 +778,7 @@
  * This function initializes information about internal UBI volumes. This
  * information is not stored on flash but instead, is kept only in RAM.
  */
-void __init init_ivols(struct ubi_info *ubi)
+static void __init init_ivols(struct ubi_info *ubi)
 {
 	struct ubi_vtbl_vtr *vtr;
 	struct ubi_vtbl_info *vtbl = ubi->vtbl;
@@ -818,8 +818,8 @@
  * This function returns a pointer to the volume tabe record. The @vol_id must
  * be correct.
  */
-const struct ubi_vtbl_vtr *get_ivol_vtr(const struct ubi_info *ubi,
-					    int vol_id)
+static const struct ubi_vtbl_vtr *get_ivol_vtr(const struct ubi_info *ubi,
+					       int vol_id)
 {
 	ubi_assert(ubi_is_ivol(vol_id));
 	return &ubi->vtbl->ivol_vtrs[vol_id - UBI_INTERNAL_VOL_START];

