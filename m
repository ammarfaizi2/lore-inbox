Return-Path: <linux-kernel-owner+w=401wt.eu-S1161022AbXALHrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbXALHrn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXALHrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:47:42 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:54674 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161022AbXALHrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:47:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=K8/boOayUS6BrYqXb8EJr0sC0airEcYv+Wf1Fpd+bLH8bJPUTWwxbrPVbkSLSFf9zwr6X9eSfOucmOrPC7eGC8rA+Rl36tFHisvuifMkuI/FiLacUxdWEeM428r7upr8OlCt+yiV/WTVKDD1ih7Ay5QzINiFhQxe6KSyVHhLU5s=
Date: Fri, 12 Jan 2007 15:47:32 +0800
From: "congwen" <congwen@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: How can I create or read/write a file in linux device driver?
Message-ID: <200701121547221465420@gmail.com>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone, I want to create and read/write a file in Linux kernel or device driver, I have write some code, the file could be created successfully, but it can not be wrote in anything, the function "write" always return a negative number, the content of the file is still empty. The following code is what I wrote in my device driver, the code reference the function sys_open() in open.c and sys_write() in read_write.c, please give me a help, thanks!

struct file *filp;
char testbuf[100] = {0};
char *ptestbuf = NULL;
ssize_t count = 0;
ssize_t ret = 0;
int ii = 0;
   
filp = filp_open("/logfile", O_CREAT | O_WRONLY | O_TRUNC, 0666);
if (IS_ERR(filp))
   printk("<0>Create record file error!\n\r");
for(ii = 0; ii < 100; ii++)
   testbuf[ii] = 1;
ptestbuf = testbuf;

if (filp->f_mode & FMODE_WRITE) 
{
   struct inode *inode = filp->f_dentry->d_inode;
   ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, filp, filp->f_pos, count);
   if (!ret) 
   {
      ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
      if (filp->f_op && (filp->f_op->write) != NULL) 
      {
         write = filp->f_op->write;
         count = 99;
         ret = write(filp, (const char *)ptestbuf, count, &filp->f_pos);
         printk("<0>After write, ret = %d   \n\r");
      }
   }
}

