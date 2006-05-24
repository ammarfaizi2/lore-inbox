Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWEXXfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWEXXfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEXXfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:35:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51851 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932284AbWEXXfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:35:21 -0400
Subject: Remove unecessary NULL check in kernel/acct.c
From: Matt Helsley <matthltc@us.ibm.com>
To: Trivial <trivial@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 May 2006 16:28:09 -0700
Message-Id: <1148513289.6853.1120.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_process() appears to be the only caller of acct_clear_integrals() and
does not pass in NULL task pointers. Remove the unecessary check.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--
 
 kernel/acct.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.17-rc4-mm1/kernel/acct.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/kernel/acct.c
+++ linux-2.6.17-rc4-mm1/kernel/acct.c
@@ -597,11 +597,9 @@ void acct_update_integrals(struct task_s
  * acct_clear_integrals - clear the mm integral fields in task_struct
  * @tsk: task_struct whose accounting fields are cleared
  */
 void acct_clear_integrals(struct task_struct *tsk)
 {
-	if (tsk) {
-		tsk->acct_stimexpd = 0;
-		tsk->acct_rss_mem1 = 0;
-		tsk->acct_vm_mem1 = 0;
-	}
+	tsk->acct_stimexpd = 0;
+	tsk->acct_rss_mem1 = 0;
+	tsk->acct_vm_mem1 = 0;
 }


