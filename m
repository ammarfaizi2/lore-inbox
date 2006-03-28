Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWC1C0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWC1C0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 21:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWC1C0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 21:26:33 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:29930 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932084AbWC1C0c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 21:26:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IlBpSMOCdMv60tWoZPLMEVIi3E3N3hENQhTo3Y43q1r7zBSynH6a/nO/C78UlP8VQPVedwPR5+wUVEJKl+h4ezEDxkvl+2xOhCWLcJL1Ldgb4HGQVvGuEJL2DnrLvbPVhf/7LKIVxHmDUh0nnxbkkM0QUdOpi7QlzlX9yb6vR/U=
Message-ID: <86802c440603271826s684cf1dcj24acce894bdd0260@mail.gmail.com>
Date: Mon, 27 Mar 2006 18:26:32 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: migrate_pages_to not defined ...
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please check the migrate)pages_to in migrate.h...
otherwise  I can not compile the kernel if i disable the swap in config.

YH


diff --git a/include/linux/migrate.h b/include/linux/migrate.h
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -12,7 +12,7 @@ extern void migrate_page_copy(struct pag
 extern int migrate_page_remove_references(struct page *, struct page *, int);
 extern int migrate_pages(struct list_head *l, struct list_head *t,
                struct list_head *moved, struct list_head *failed);
-int migrate_pages_to(struct list_head *pagelist,
+extern int migrate_pages_to(struct list_head *pagelist,
                        struct vm_area_struct *vma, int dest);
 extern int fail_migrate_page(struct page *, struct page *);

@@ -26,6 +26,8 @@ static inline int putback_lru_pages(stru
 static inline int migrate_pages(struct list_head *l, struct list_head *t,
        struct list_head *moved, struct list_head *failed) { return -ENOSYS; }

+static inline int migrate_pages_to(struct list_head *pagelist,
+                        struct vm_area_struct *vma, int dest) {
return -ENOSYS; }
 static inline int migrate_prep(void) { return -ENOSYS; }

 /* Possible settings for the migrate_page() method in address_operations */
diff --git a/mm/migrate.c b/mm/migrate.c
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -653,3 +653,4 @@ out:
                nr_pages++;
        return nr_pages;
 }
+EXPORT_SYMBOL(migrate_pages_to);
