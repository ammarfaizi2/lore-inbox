Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTFJX5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTFJX4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:56:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62711 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262256AbTFJXz5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:55:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055290316718@kroah.com>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
In-Reply-To: <10552903163198@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 17:11:56 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1398, 2003/06/10 16:33:42-07:00, greg@kroah.com

[PATCH] PCI: sparse fixups for drivers/pci/proc.c


 drivers/pci/proc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Tue Jun 10 17:03:59 2003
+++ b/drivers/pci/proc.c	Tue Jun 10 17:03:59 2003
@@ -44,7 +44,7 @@
 }
 
 static ssize_t
-proc_bus_pci_read(struct file *file, char *buf, size_t nbytes, loff_t *ppos)
+proc_bus_pci_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	const struct inode *ino = file->f_dentry->d_inode;
 	const struct proc_dir_entry *dp = PDE(ino);
@@ -126,7 +126,7 @@
 }
 
 static ssize_t
-proc_bus_pci_write(struct file *file, const char *buf, size_t nbytes, loff_t *ppos)
+proc_bus_pci_write(struct file *file, const char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	const struct inode *ino = file->f_dentry->d_inode;
 	const struct proc_dir_entry *dp = PDE(ino);
@@ -323,7 +323,7 @@
 {
 	struct list_head *p = v;
 	(*pos)++;
-	return p->next != &pci_devices ? p->next : NULL;
+	return p->next != &pci_devices ? (void *)p->next : NULL;
 }
 static void pci_seq_stop(struct seq_file *m, void *v)
 {

