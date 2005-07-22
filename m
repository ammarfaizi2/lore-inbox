Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVGVP2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVGVP2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVGVP2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:28:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64188 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261292AbVGVP2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:28:18 -0400
Date: Fri, 22 Jul 2005 17:28:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: [patch] Fix preempt warning in kernel/power/smp.c
Message-ID: <20050722152818.GA2561@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Cunningham <nigel@suspend2.net>

This patch fixes a warning in the disable_nonboot_cpus call in
kernel/power/smp.c.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 93fb99fd9f170b5418ed73475b7664d355465359
tree f2bd09522ef68da1010e423fde07ad902f50eda5
parent 3bd0270be587b87ec14f1fdc50bd8c9e3f1142dc
author <pavel@amd.(none)> Fri, 22 Jul 2005 17:27:11 +0200
committer <pavel@amd.(none)> Fri, 22 Jul 2005 17:27:11 +0200

 kernel/power/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/smp.c b/kernel/power/smp.c
--- a/kernel/power/smp.c
+++ b/kernel/power/smp.c
@@ -38,7 +38,7 @@ void disable_nonboot_cpus(void)
 		}
 		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	BUG_ON(smp_processor_id() != 0);
+	BUG_ON(raw_smp_processor_id() != 0);
 	if (error)
 		panic("cpus not sleeping");
 }
