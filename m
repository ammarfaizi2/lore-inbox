Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWCUTul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWCUTul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWCUTul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:50:41 -0500
Received: from mga03.intel.com ([143.182.124.21]:1353 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965097AbWCUTuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:50:40 -0500
X-IronPort-AV: i="4.03,115,1141632000"; 
   d="scan'208"; a="14013045:sNHT2237384268"
Subject: [patch] add private data to notifier_block
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: stern@rowland.harvard.edu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Mar 2006 11:42:33 -0800
Message-Id: <1142970154.31210.10.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 21 Mar 2006 19:35:30.0359 (UTC) FILETIME=[9CEA3470:01C64D1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While most current uses of notifier_block use a global struct, I would
like to be able to use it on a per device basis for drivers which have
multiple device instances.  I would also like to be able to have a
private data struct associated with the notifier block so that per
device data can be easily accessed.  This patch will modify the
notifier_block struct to add a void *, and will require no modifications
to any other users of the notifier_block.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 include/linux/notifier.h |    1 +
 1 files changed, 1 insertion(+)

--- 2.6-git-kca.orig/include/linux/notifier.h
+++ 2.6-git-kca/include/linux/notifier.h
@@ -15,6 +15,7 @@ struct notifier_block
 {
 	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
 	struct notifier_block *next;
+	void *data;
 	int priority;
 };
 
