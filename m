Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267039AbVBFAfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267039AbVBFAfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbVBFAcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:32:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S266513AbVBFAaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:30:55 -0500
Date: Sun, 6 Feb 2005 01:30:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Carsten Paeth <calle@calle.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/capi/: make some code static
Message-ID: <20050206003048.GJ3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/capi/capi.c       |   10 +++++-----
 drivers/isdn/capi/kcapi_proc.c |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/capi/capi.c.old	2005-02-05 15:34:35.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/capi/capi.c	2005-02-05 15:35:37.000000000 +0100
@@ -60,12 +60,12 @@
 
 static struct class_simple *capi_class;
 
-int capi_major = 68;		/* allocated */
+static int capi_major = 68;		/* allocated */
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 #define CAPINC_NR_PORTS	32
 #define CAPINC_MAX_PORTS	256
-int capi_ttymajor = 191;
-int capi_ttyminors = CAPINC_NR_PORTS;
+static int capi_ttymajor = 191;
+static int capi_ttyminors = CAPINC_NR_PORTS;
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 
 module_param_named(major, capi_major, uint, 0);
@@ -268,7 +268,7 @@
 	kfree(mp);
 }
 
-struct capiminor *capiminor_find(unsigned int minor)
+static struct capiminor *capiminor_find(unsigned int minor)
 {
 	struct list_head *l;
 	struct capiminor *p = NULL;
@@ -1166,7 +1166,7 @@
 	return room;
 }
 
-int capinc_tty_chars_in_buffer(struct tty_struct *tty)
+static int capinc_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct capiminor *mp = (struct capiminor *)tty->driver_data;
 	if (!mp || !mp->nccip) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/capi/kcapi_proc.c.old	2005-02-05 15:36:10.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/capi/kcapi_proc.c	2005-02-05 15:36:43.000000000 +0100
@@ -89,14 +89,14 @@
 	return 0;
 }
 
-struct seq_operations seq_controller_ops = {
+static struct seq_operations seq_controller_ops = {
 	.start	= controller_start,
 	.next	= controller_next,
 	.stop	= controller_stop,
 	.show	= controller_show,
 };
 
-struct seq_operations seq_contrstats_ops = {
+static struct seq_operations seq_contrstats_ops = {
 	.start	= controller_start,
 	.next	= controller_next,
 	.stop	= controller_stop,
@@ -192,14 +192,14 @@
 	return 0;
 }
 
-struct seq_operations seq_applications_ops = {
+static struct seq_operations seq_applications_ops = {
 	.start	= applications_start,
 	.next	= applications_next,
 	.stop	= applications_stop,
 	.show	= applications_show,
 };
 
-struct seq_operations seq_applstats_ops = {
+static struct seq_operations seq_applstats_ops = {
 	.start	= applications_start,
 	.next	= applications_next,
 	.stop	= applications_stop,
@@ -287,7 +287,7 @@
 	return 0;
 }
 
-struct seq_operations seq_capi_driver_ops = {
+static struct seq_operations seq_capi_driver_ops = {
 	.start	= capi_driver_start,
 	.next	= capi_driver_next,
 	.stop	= capi_driver_stop,

