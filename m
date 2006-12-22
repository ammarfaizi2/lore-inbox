Return-Path: <linux-kernel-owner+w=401wt.eu-S1946034AbWLVKzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946034AbWLVKzf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946035AbWLVKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:55:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48986 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946034AbWLVKze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:55:34 -0500
Date: Fri, 22 Dec 2006 11:55:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: omap compilation fixes
Message-ID: <20061222105521.GA23683@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is not yet complete set. set_map() is missing in latest kernels.

Fix DECLARE_WORK()-change-related compilation problems. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 28aed6101a8d8b4385db50dd7d08ac90db380b23
tree f80885ed5ef18cdded05aece527179cef096af75
parent 9c9252734f70ff04bb1ffad8a7c2d7e97e1e033f
author Pavel <pavel@amd.ucw.cz> Fri, 22 Dec 2006 11:38:40 +0100
committer Pavel <pavel@amd.ucw.cz> Fri, 22 Dec 2006 11:38:40 +0100

 Makefile                         |    5 +----
 arch/arm/plat-omap/dsp/dsp_mem.c |    9 ++++-----
 arch/arm/plat-omap/dsp/ipbuf.c   |    5 ++---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/dsp_mem.c b/arch/arm/plat-omap/dsp/dsp_mem.c
index ebf3c6b..dccd95d 100644
--- a/arch/arm/plat-omap/dsp/dsp_mem.c
+++ b/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -2009,7 +2009,7 @@ #ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
  * fbupd_cb() is called when fb update is done, in interrupt context.
  * mbox_fbupd() is called when KFUNC:FBCTL:UPD is received from DSP.
  */
-static void fbupd_response(void *arg)
+static void fbupd_response(struct work_struct *ignored)
 {
 	int status;
 
@@ -2022,8 +2022,7 @@ static void fbupd_response(void *arg)
 	}
 }
 
-static DECLARE_WORK(fbupd_response_work, (void (*)(void *))fbupd_response,
-		    NULL);
+static DECLARE_WORK(fbupd_response_work, fbupd_response);
 
 static void fbupd_cb(void *arg)
 {
@@ -2283,7 +2282,7 @@ #define MMUFAULT_MASK \
 	 DSP_MMU_FAULT_ST_TRANS)
 #endif /* CONFIG_ARCH_OMAP1 */
 
-static void do_mmu_int(void)
+static void do_mmu_int(struct work_struct *ignored)
 {
 #if defined(CONFIG_ARCH_OMAP1)
 
@@ -2417,7 +2416,7 @@ #endif
 	enable_irq(omap_dsp->mmu_irq);
 }
 
-static DECLARE_WORK(mmu_int_work, (void (*)(void *))do_mmu_int, NULL);
+static DECLARE_WORK(mmu_int_work, do_mmu_int);
 
 /*
  * DSP MMU interrupt handler
diff --git a/arch/arm/plat-omap/dsp/ipbuf.c b/arch/arm/plat-omap/dsp/ipbuf.c
index 26cdf74..aa6c6c9 100644
--- a/arch/arm/plat-omap/dsp/ipbuf.c
+++ b/arch/arm/plat-omap/dsp/ipbuf.c
@@ -245,7 +245,7 @@ static int try_yld(struct ipbuf_head *ip
 /*
  * balancing ipbuf lines with DSP
  */
-static void do_balance_ipbuf(void)
+static void do_balance_ipbuf(struct work_struct *ignored)
 {
 	while (ipbcfg.bsycnt <= ipbcfg.ln / 4) {
 		struct ipbuf_head *ipb_h;
@@ -257,8 +257,7 @@ static void do_balance_ipbuf(void)
 	}
 }
 
-static DECLARE_WORK(balance_ipbuf_work, (void (*)(void *))do_balance_ipbuf,
-		    NULL);
+static DECLARE_WORK(balance_ipbuf_work, do_balance_ipbuf);
 
 void balance_ipbuf(void)
 {



!-------------------------------------------------------------flip-


Fix DECLARE_WORK()-change-related compilation problems.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 4e72a7ffbd25b231dbb89ca5dc478c3e7ae2fd43
tree 857cdc4f32b5bd17eb79912ca2529ed09f48c9f2
parent 28aed6101a8d8b4385db50dd7d08ac90db380b23
author Pavel <pavel@amd.ucw.cz> Fri, 22 Dec 2006 11:43:45 +0100
committer Pavel <pavel@amd.ucw.cz> Fri, 22 Dec 2006 11:43:45 +0100

 drivers/mmc/omap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 3bf7a88..ca08490 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -2,7 +2,7 @@
  *  linux/drivers/media/mmc/omap.c
  *
  *  Copyright (C) 2004 Nokia Corporation
- *  Written by Tuukka Tikkanen and Juha Yrjölä<juha.yrjola@nokia.com>
+ *  Written by Tuukka Tikkanen and Juha Yrjölä <juha.yrjola@nokia.com>
  *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
  *  Other hacks (DMA, SD, etc) by David Brownell
  *
@@ -582,9 +582,10 @@ static void mmc_omap_switch_timer(unsign
 	schedule_work(&host->switch_work);
 }
 
-static void mmc_omap_switch_handler(void *data)
+static void mmc_omap_switch_handler(struct work_struct *w)
 {
-	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
+	struct mmc_omap_host *host = 
+		container_of(w, struct mmc_omap_host, switch_work);
 	struct mmc_card *card;
 	static int complained = 0;
 	int cards = 0, cover_open;
@@ -1122,7 +1123,7 @@ static int __init mmc_omap_probe(struct 
 	platform_set_drvdata(pdev, host);
 
 	if (host->switch_pin >= 0) {
-		INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
+		INIT_WORK(&host->switch_work, mmc_omap_switch_handler);
 		init_timer(&host->switch_timer);
 		host->switch_timer.function = mmc_omap_switch_timer;
 		host->switch_timer.data = (unsigned long) host;



!-------------------------------------------------------------flip-



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
