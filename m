Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWJJSVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWJJSVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWJJSVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:21:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:4261 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965010AbWJJSVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:21:05 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, Joel.Becker@oracle.com
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Date: Tue, 10 Oct 2006 11:21:01 -0700
Message-Id: <20061010182101.20990.15014.sendpatchset@localhost.localdomain>
In-Reply-To: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/5] Change configfs_example.c to use the new interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the example to suit the modified interface to use seq_file.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
--

 Documentation/filesystems/configfs/configfs_example.c |   30 +++++++++---------
 1 files changed, 15 insertions(+), 15 deletions(-)

Index: linux-2.6.18/Documentation/filesystems/configfs/configfs_example.c
===================================================================
--- linux-2.6.18.orig/Documentation/filesystems/configfs/configfs_example.c
+++ linux-2.6.18/Documentation/filesystems/configfs/configfs_example.c
@@ -53,7 +53,7 @@ struct childless {
 
 struct childless_attribute {
 	struct configfs_attribute attr;
-	ssize_t (*show)(struct childless *, char *);
+	ssize_t (*show)(struct childless *, struct seq_file *);
 	ssize_t (*store)(struct childless *, const char *, size_t);
 };
 
@@ -63,20 +63,20 @@ static inline struct childless *to_child
 }
 
 static ssize_t childless_showme_read(struct childless *childless,
-				     char *page)
+				     struct seq_file *s)
 {
 	ssize_t pos;
 
-	pos = sprintf(page, "%d\n", childless->showme);
+	pos = seq_printf(s, "%d\n", childless->showme);
 	childless->showme++;
 
 	return pos;
 }
 
 static ssize_t childless_storeme_read(struct childless *childless,
-				      char *page)
+				      struct seq_file *s)
 {
-	return sprintf(page, "%d\n", childless->storeme);
+	return seq_printf(s, "%d\n", childless->storeme);
 }
 
 static ssize_t childless_storeme_write(struct childless *childless,
@@ -99,9 +99,9 @@ static ssize_t childless_storeme_write(s
 }
 
 static ssize_t childless_description_read(struct childless *childless,
-					  char *page)
+					  struct seq_file *s)
 {
-	return sprintf(page,
+	return seq_printf(s,
 "[01-childless]\n"
 "\n"
 "The childless subsystem is the simplest possible subsystem in\n"
@@ -133,7 +133,7 @@ static struct configfs_attribute *childl
 
 static ssize_t childless_attr_show(struct config_item *item,
 				   struct configfs_attribute *attr,
-				   char *page)
+				   struct seq_file *s)
 {
 	struct childless *childless = to_childless(item);
 	struct childless_attribute *childless_attr =
@@ -141,7 +141,7 @@ static ssize_t childless_attr_show(struc
 	ssize_t ret = 0;
 
 	if (childless_attr->show)
-		ret = childless_attr->show(childless, page);
+		ret = childless_attr->show(childless, s);
 	return ret;
 }
 
@@ -216,12 +216,12 @@ static struct configfs_attribute *simple
 
 static ssize_t simple_child_attr_show(struct config_item *item,
 				      struct configfs_attribute *attr,
-				      char *page)
+				      struct seq_file *s)
 {
 	ssize_t count;
 	struct simple_child *simple_child = to_simple_child(item);
 
-	count = sprintf(page, "%d\n", simple_child->storeme);
+	count = seq_printf(s, "%d\n", simple_child->storeme);
 
 	return count;
 }
@@ -304,9 +304,9 @@ static struct configfs_attribute *simple
 
 static ssize_t simple_children_attr_show(struct config_item *item,
 			   		 struct configfs_attribute *attr,
-			   		 char *page)
+			   		 struct seq_file *s)
 {
-	return sprintf(page,
+	return seq_printf(s,
 "[02-simple-children]\n"
 "\n"
 "This subsystem allows the creation of child config_items.  These\n"
@@ -390,9 +390,9 @@ static struct configfs_attribute *group_
 
 static ssize_t group_children_attr_show(struct config_item *item,
 			   		struct configfs_attribute *attr,
-			   		char *page)
+			   		struct seq_file *s)
 {
-	return sprintf(page,
+	return seq_printf(s,
 "[03-group-children]\n"
 "\n"
 "This subsystem allows the creation of child config_groups.  These\n"

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
