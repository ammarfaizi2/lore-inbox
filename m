Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933427AbWF0EqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933427AbWF0EqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030688AbWF0Emo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:44 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:55259 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030704AbWF0Eml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/13] [Suspend2] Follow page routine.
Date: Tue, 27 Jun 2006 14:42:40 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044238.15066.77126.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This variant of the follow page routine is used by Suspend2 to find
existing pages that belong to a process without changing anything in the
process.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 mm/memory.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0ec7bc6..1021043 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -958,6 +958,15 @@ no_page_table:
 	return page;
 }
 
+/*
+ * We want the address of the page for Suspend2 to mark as being in pageset1. 
+ */
+
+struct page *suspend2_follow_page(struct mm_struct *mm, unsigned long address)
+{
+	return follow_page(mm->mmap, address, 0);
+}
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)

--
Nigel Cunningham		nigel at suspend2 dot net
