Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSIEOTn>; Thu, 5 Sep 2002 10:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSIEOTn>; Thu, 5 Sep 2002 10:19:43 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:29845 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317592AbSIEOTm>; Thu, 5 Sep 2002 10:19:42 -0400
Subject: patch for IA64: fix do_sys32_msgrcv bad address error.
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com>
From: "R Sreelatha" <rsreelat@in.ibm.com>
Date: Thu, 5 Sep 2002 19:46:40 +0530
X-MIMETrack: Serialize by Router on d23m0062/23/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/09/2002 07:46:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sys_ia32.c file, in the do_sys32_msgrcv() function call,  the value of
ipck.msgp is interpreted as a 64 bit address, whereas it is a 32 bit
address.
Hence, do_sys32_msgrcv() finally returns EFAULT(bad address) error.
The patch below takes care of this by type casting ipck.msgp to type u32.
The patch is created for 2.5.32 version of the kernel.

--- arch/ia64/ia32/sys_ia32.c Thu Sep  5 19:13:02 2002
+++ /home/sree/bug1054/sys_ia32.c   Thu Sep  5 19:12:08 2002
@@ -2263,7 +2263,7 @@
            err = -EFAULT;
            if (copy_from_user(&ipck, uipck, sizeof(struct ipc_kludge)))
                  goto out;
-           uptr = (void *)A(ipck.msgp);
+           uptr = (void *)A((u32)ipck.msgp);
            msgtyp = ipck.msgtyp;
      }
      err = -ENOMEM;


I am not subscribed to lkml. Please send your replies to
"rsreelat@in.ibm.com".

regards,
Sreelatha



