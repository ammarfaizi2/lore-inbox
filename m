Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVBKS7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVBKS7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVBKS62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:58:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262293AbVBKSyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:36 -0500
Date: Fri, 11 Feb 2005 19:54:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tim@cyberelk.net, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/paride/ cleanups (fwd)
Message-ID: <20050211185434.GH3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in each if the five changed
C files:
- #ifndef MODULE: remove unused setup function
- make a needlessly global struct static
- pf.c: pf_init_units can be static and __init

After this cleanup, setup.h is completely unused and therefore removed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 29 Jan 2005

 drivers/block/paride/pcd.c   |   22 -----------
 drivers/block/paride/pd.c    |   23 -----------
 drivers/block/paride/pf.c    |   25 +-----------
 drivers/block/paride/pg.c    |   21 ----------
 drivers/block/paride/pt.c    |   22 -----------
 drivers/block/paride/setup.h |   69 -----------------------------------
 6 files changed, 6 insertions(+), 176 deletions(-)

--- linux-2.6.11-rc2-mm1-full/drivers/block/paride/pcd.c.old	2005-01-29 14:10:23.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/paride/pcd.c	2005-01-29 14:10:50.000000000 +0100
@@ -142,26 +142,6 @@
 
 static spinlock_t pcd_lock;
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pcd_stt[6] = {
-	{"drive0", 6, drive0},
-	{"drive1", 6, drive1},
-	{"drive2", 6, drive2},
-	{"drive3", 6, drive3},
-	{"disable", 1, &disable},
-	{"nice", 1, &nice}
-};
-
-void pcd_setup(char *str, int *ints)
-{
-	generic_setup(pcd_stt, 6, str);
-}
-
-#endif
-
 module_param(verbose, bool, 0644);
 module_param(major, int, 0);
 module_param(name, charp, 0);
@@ -218,7 +198,7 @@
 	struct gendisk *disk;
 };
 
-struct pcd_unit pcd[PCD_UNITS];
+static struct pcd_unit pcd[PCD_UNITS];
 
 static char pcd_scratch[64];
 static char pcd_buffer[2048];	/* raw block buffer */
--- linux-2.6.11-rc2-mm1-full/drivers/block/paride/pd.c.old	2005-01-29 14:11:08.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/paride/pd.c	2005-01-29 14:11:45.000000000 +0100
@@ -157,27 +157,6 @@
 
 static DEFINE_SPINLOCK(pd_lock);
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pd_stt[7] = {
-	{"drive0", 8, drive0},
-	{"drive1", 8, drive1},
-	{"drive2", 8, drive2},
-	{"drive3", 8, drive3},
-	{"disable", 1, &disable},
-	{"cluster", 1, &cluster},
-	{"nice", 1, &nice}
-};
-
-void pd_setup(char *str, int *ints)
-{
-	generic_setup(pd_stt, 7, str);
-}
-
-#endif
-
 module_param(verbose, bool, 0);
 module_param(major, int, 0);
 module_param(name, charp, 0);
@@ -255,7 +234,7 @@
 	struct gendisk *gd;
 };
 
-struct pd_unit pd[PD_UNITS];
+static struct pd_unit pd[PD_UNITS];
 
 static char pd_scratch[512];	/* scratch block buffer */
 
--- linux-2.6.11-rc2-mm1-full/drivers/block/paride/pf.c.old	2005-01-29 14:11:57.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/paride/pf.c	2005-01-29 14:13:16.000000000 +0100
@@ -156,27 +156,6 @@
 
 static spinlock_t pf_spin_lock;
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pf_stt[7] = {
-	{"drive0", 7, drive0},
-	{"drive1", 7, drive1},
-	{"drive2", 7, drive2},
-	{"drive3", 7, drive3},
-	{"disable", 1, &disable},
-	{"cluster", 1, &cluster},
-	{"nice", 1, &nice}
-};
-
-void pf_setup(char *str, int *ints)
-{
-	generic_setup(pf_stt, 7, str);
-}
-
-#endif
-
 module_param(verbose, bool, 0644);
 module_param(major, int, 0);
 module_param(name, charp, 0);
@@ -256,7 +235,7 @@
 	struct gendisk *disk;
 };
 
-struct pf_unit units[PF_UNITS];
+static struct pf_unit units[PF_UNITS];
 
 static int pf_identify(struct pf_unit *pf);
 static void pf_lock(struct pf_unit *pf, int func);
@@ -290,7 +269,7 @@
 	.media_changed	= pf_check_media,
 };
 
-void pf_init_units(void)
+static void __init pf_init_units(void)
 {
 	struct pf_unit *pf;
 	int unit;
--- linux-2.6.11-rc2-mm1-full/drivers/block/paride/pg.c.old	2005-01-29 14:13:47.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/paride/pg.c	2005-01-29 14:14:10.000000000 +0100
@@ -167,25 +167,6 @@
 
 #include <asm/uaccess.h>
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pg_stt[5] = {
-	{"drive0", 6, drive0},
-	{"drive1", 6, drive1},
-	{"drive2", 6, drive2},
-	{"drive3", 6, drive3},
-	{"disable", 1, &disable}
-};
-
-void pg_setup(char *str, int *ints)
-{
-	generic_setup(pg_stt, 5, str);
-}
-
-#endif
-
 module_param(verbose, bool, 0644);
 module_param(major, int, 0);
 module_param(name, charp, 0);
@@ -237,7 +218,7 @@
 	char name[PG_NAMELEN];	/* pg0, pg1, ... */
 };
 
-struct pg devices[PG_UNITS];
+static struct pg devices[PG_UNITS];
 
 static int pg_identify(struct pg *dev, int log);
 
--- linux-2.6.11-rc2-mm1-full/drivers/block/paride/pt.c.old	2005-01-29 14:14:21.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/paride/pt.c	2005-01-29 14:14:38.000000000 +0100
@@ -150,26 +150,6 @@
 
 #include <asm/uaccess.h>
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pt_stt[5] = {
-	{"drive0", 6, drive0},
-	{"drive1", 6, drive1},
-	{"drive2", 6, drive2},
-	{"drive3", 6, drive3},
-	{"disable", 1, &disable}
-};
-
-void
-pt_setup(char *str, int *ints)
-{
-	generic_setup(pt_stt, 5, str);
-}
-
-#endif
-
 module_param(verbose, bool, 0);
 module_param(major, int, 0);
 module_param(name, charp, 0);
@@ -247,7 +227,7 @@
 
 static int pt_identify(struct pt_unit *tape);
 
-struct pt_unit pt[PT_UNITS];
+static struct pt_unit pt[PT_UNITS];
 
 static char pt_scratch[512];	/* scratch block buffer */
 
--- linux-2.6.11-rc2-mm1-full/drivers/block/paride/setup.h	2004-12-24 22:35:29.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,69 +0,0 @@
-/*
-	setup.h	   (c) 1997-8   Grant R. Guenther <grant@torque.net>
-		                Under the terms of the GNU General Public License.
-
-        This is a table driven setup function for kernel modules
-        using the module.variable=val,... command line notation.
-
-*/
-
-/* Changes:
-
-	1.01	GRG 1998.05.05	Allow negative and defaulted values
-
-*/
-
-#include <linux/ctype.h>
-#include <linux/string.h>
-
-struct setup_tab_t {
-
-	char	*tag;	/* variable name */
-	int	size;	/* number of elements in array */
-	int	*iv;	/* pointer to variable */
-};
-
-typedef struct setup_tab_t STT;
-
-/*  t 	  is a table that describes the variables that can be set
-	  by gen_setup
-    n	  is the number of entries in the table
-    ss	  is a string of the form:
-
-		<tag>=[<val>,...]<val>
-*/
-
-static void generic_setup( STT t[], int n, char *ss )
-
-{	int	j,k, sgn;
-
-	k = 0;
-	for (j=0;j<n;j++) {
-		k = strlen(t[j].tag);
-		if (strncmp(ss,t[j].tag,k) == 0) break;
-	}
-	if (j == n) return;
-
-	if (ss[k] == 0) {
-		t[j].iv[0] = 1;
-		return;
-	}
-
-	if (ss[k] != '=') return;
-	ss += (k+1);
-
-	k = 0;
-	while (ss && (k < t[j].size)) {
-		if (!*ss) break;
-		sgn = 1;
-		if (*ss == '-') { ss++; sgn = -1; }
-		if (!*ss) break;
-		if (isdigit(*ss))
-		  t[j].iv[k] = sgn * simple_strtoul(ss,NULL,0);
-		k++; 
-		if ((ss = strchr(ss,',')) != NULL) ss++;
-	}
-}
-
-/* end of setup.h */
-

