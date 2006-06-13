Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWFMCNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWFMCNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 22:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWFMCNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 22:13:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53971 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932736AbWFMCNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 22:13:20 -0400
Subject: Mark profile notifier blocks __read_mostly
From: Matt Helsley <matthltc@us.ibm.com>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: oprofile-list@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 19:01:52 -0700
Message-Id: <1150164112.21787.68.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark profile notifier blocks __read_mostly since once registered they tend
not to be written. This seems like a good idea but I'm not yet familiar
enough with the profile paths to be certain.

Compiles, boots, and runs with CONFIG_PROFILING=y and readprofile on a 4-way
Opteron running Debian Sarge.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: oprofile-list@lists.sf.net
--

Booted with profile=2
Profiling 3 iterations of kernbench
readprofile output | grep profile:
	without this patch:
	     1 write_profile                              0.0037
	     1 profile_tick                               0.0112
	     1 profile_munmap                             0.0435

	with this patch:
	     1 write_profile                              0.0037

(full readprofile results available for posting upon request)

 drivers/oprofile/buffer_sync.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc6-mm2/drivers/oprofile/buffer_sync.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/oprofile/buffer_sync.c
+++ linux-2.6.17-rc6-mm2/drivers/oprofile/buffer_sync.c
@@ -115,23 +115,23 @@ static int module_load_notify(struct not
 #endif
 	return 0;
 }
 
  
-static struct notifier_block task_free_nb = {
+static struct notifier_block __read_mostly task_free_nb = {
 	.notifier_call	= task_free_notify,
 };
 
-static struct notifier_block task_exit_nb = {
+static struct notifier_block __read_mostly task_exit_nb = {
 	.notifier_call	= task_exit_notify,
 };
 
-static struct notifier_block munmap_nb = {
+static struct notifier_block __read_mostly munmap_nb = {
 	.notifier_call	= munmap_notify,
 };
 
-static struct notifier_block module_load_nb = {
+static struct notifier_block __read_mostly module_load_nb = {
 	.notifier_call = module_load_notify,
 };
 
  
 static void end_sync(void)


