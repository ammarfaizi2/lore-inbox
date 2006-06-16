Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWFPNVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWFPNVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 09:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFPNVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 09:21:19 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:14901 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S1751385AbWFPNVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 09:21:19 -0400
Message-ID: <4492CC61.1070800@ra.rockwell.com>
Date: Fri, 16 Jun 2006 15:21:05 +0000
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] no_pci_mem
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 06/16/2006 08:21:19 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 06/16/2006 08:22:05 AM,
	Serialize complete at 06/16/2006 08:22:05 AM
Content-Type: multipart/mixed;
 boundary="------------030009020605020302090702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030009020605020302090702
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

This patch disables port subdevice when pci or isa bus is not selected.
Current behaviour is that port is disabled only when there is no isa bus.

Feedback and comments are highly appreciated.

This patch is against 2.6.17-rc5.

Please CC me, I'm not subscribed to the mailing list.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---


--------------030009020605020302090702
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="no_pci_mem.patch"
Content-Disposition: inline;
 filename="no_pci_mem.patch"

diff -uprN -X orig.bak.never.touch/Documentation/dontdiff orig.bak.never.touch/drivers/char/mem.c new_gadget.newest/drivers/char/mem.c
--- orig.bak.never.touch/drivers/char/mem.c	2006-05-30 09:37:37.000000000 +0000
+++ new_gadget.newest/drivers/char/mem.c	2006-06-14 12:14:42.000000000 +0000
@@ -524,7 +524,7 @@ static ssize_t write_kmem(struct file * 
  	return virtr + wrote;
 }
 
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if !defined(__mc68000__) && (defined(CONFIG_PCI) || defined(CONFIG_ISA)) 
 static ssize_t read_port(struct file * file, char __user * buf,
 			 size_t count, loff_t *ppos)
 {
@@ -801,7 +801,7 @@ static struct file_operations null_fops 
 	.splice_write	= splice_write_null,
 };
 
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if !defined(__mc68000__) && (defined(CONFIG_PCI) || defined(CONFIG_ISA)) 
 static struct file_operations port_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_port,
@@ -871,7 +871,7 @@ static int memory_open(struct inode * in
 		case 3:
 			filp->f_op = &null_fops;
 			break;
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if !defined(__mc68000__) && (defined(CONFIG_PCI) || defined(CONFIG_ISA)) 
 		case 4:
 			filp->f_op = &port_fops;
 			break;
@@ -918,7 +918,7 @@ static const struct {
 	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
 	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
 	{3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if !defined(__mc68000__) && (defined(CONFIG_PCI) || defined(CONFIG_ISA)) 
 	{4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},
 #endif
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},


--------------030009020605020302090702--
