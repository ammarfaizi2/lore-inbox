Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWI2JfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWI2JfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWI2JfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:35:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7375 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750895AbWI2JfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:35:22 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Don't try and give NULL to fput()
Date: Fri, 29 Sep 2006 10:35:14 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Message-Id: <20060929093514.5688.55320.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Lambert <gavinl@compacsort.com>

Don't try and give NULL to fput() in the error handling in do_mmap_pgoff() as
it'll cause an oops.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 5645406..3650195 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -948,7 +948,8 @@ #endif
 	up_write(&nommu_vma_sem);
 	kfree(vml);
 	if (vma) {
-		fput(vma->vm_file);
+		if (vma->vm_file)
+			fput(vma->vm_file);
 		kfree(vma);
 	}
 	return ret;
