Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUHQTvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUHQTvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUHQTvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:51:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41983 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266648AbUHQTvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:51:15 -0400
Date: Tue, 17 Aug 2004 14:49:50 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, manuel.lauss@fh-hagenberg.at
Subject: Re: Fw: 2.6.8.1-mm1: oops with firmware loading
Message-ID: <20040817194950.GA1536@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040817110533.036abf8f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817110533.036abf8f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 11:05:33AM -0700, Andrew Morton wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Tue, 17 Aug 2004 15:28:18 +0200
> From: Manuel Lauss <manuel.lauss@fh-hagenberg.at>
> To: akpm@osdl.org, linux-kernel@vger.kernel.org
> Cc: manuel.lauss@fh-hagenberg.at
> Subject: 2.6.8.1-mm1: oops with firmware loading
> 
> 
> Hi,
> 
> The new sysfs-backingstore patches cause an oops when I ifup a
> prism54 based device, heres the dmesg section:
> 

My fault, a bad typo in fs/sysfs/bin.c.

Manuel, can you try this change in fs/sysfs/bin.c

--- bin.c.orig	2004-08-18 05:34:40.883964168 +0530
+++ bin.c	2004-08-18 05:36:40.316807616 +0530
@@ -60,8 +60,8 @@
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = to_bin_attr(dentry->d_parent);
-	struct kobject *kobj = to_kobj(dentry);
+	struct bin_attribute *attr = to_bin_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
 
 	return attr->write(kobj, buffer, offset, count);
 }


Andrew, How do I send the patch? I think hand editting will also work.

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
