Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUK2M1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUK2M1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUK2M1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:27:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261696AbUK2M01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:26:27 -0500
Date: Mon, 29 Nov 2004 13:26:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tim@cyberelk.net, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/paride/ cleanups
Message-ID: <20041129122625.GF9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in each if the five changed 
C files:
- #ifndef MODULE: remove unused setup function
- make a needlessly global struct static

After this cleanup, setup.h is completely unuse and therefore removed.


diffstat output:
 drivers/block/paride/setup.h |   70 -----------------------------------
 drivers/block/paride/pcd.c   |   22 -----------
 drivers/block/paride/pd.c    |   23 -----------
 drivers/block/paride/pf.c    |   23 -----------
 drivers/block/paride/pg.c    |   21 ----------
 drivers/block/paride/pt.c    |   23 -----------
 6 files changed, 5 insertions(+), 177 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pcd.c.old	2004-11-24 23:45:49.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pcd.c	2004-11-24 23:46:42.000000000 +0100
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
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -218,7 +198,7 @@
 	struct gendisk *disk;
 };
 
-struct pcd_unit pcd[PCD_UNITS];
+static struct pcd_unit pcd[PCD_UNITS];
 
 static char pcd_scratch[64];
 static char pcd_buffer[2048];	/* raw block buffer */
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pd.c.old	2004-11-24 23:46:42.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pd.c	2004-11-24 23:46:55.000000000 +0100
@@ -157,27 +157,6 @@
 
 static spinlock_t pd_lock = SPIN_LOCK_UNLOCKED;
 
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
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -255,7 +234,7 @@
 	struct gendisk *gd;
 };
 
-struct pd_unit pd[PD_UNITS];
+static struct pd_unit pd[PD_UNITS];
 
 static char pd_scratch[512];	/* scratch block buffer */
 
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pf.c.old	2004-11-24 23:46:55.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pf.c	2004-11-24 23:47:06.000000000 +0100
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
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -256,7 +235,7 @@
 	struct gendisk *disk;
 };
 
-struct pf_unit units[PF_UNITS];
+static struct pf_unit units[PF_UNITS];
 
 static int pf_identify(struct pf_unit *pf);
 static void pf_lock(struct pf_unit *pf, int func);
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pg.c.old	2004-11-24 23:47:06.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pg.c	2004-11-24 23:47:19.000000000 +0100
@@ -165,25 +165,6 @@
 
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
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -235,7 +216,7 @@
 	char name[PG_NAMELEN];	/* pg0, pg1, ... */
 };
 
-struct pg devices[PG_UNITS];
+static struct pg devices[PG_UNITS];
 
 static int pg_identify(struct pg *dev, int log);
 
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pt.c.old	2004-11-24 23:47:19.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pt.c	2004-11-24 23:47:30.000000000 +0100
@@ -149,26 +149,6 @@
 
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
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -246,7 +226,7 @@
 
 static int pt_identify(struct pt_unit *tape);
 
-struct pt_unit pt[PT_UNITS];
+static struct pt_unit pt[PT_UNITS];
 
 static char pt_scratch[512];	/* scratch block buffer */
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.10-rc1-mm3-full/drivers/block/paride/setup.h	2004-10-18 23:55:27.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
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



