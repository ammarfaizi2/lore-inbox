Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSIEQtJ>; Thu, 5 Sep 2002 12:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSIEQtI>; Thu, 5 Sep 2002 12:49:08 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:41664 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317874AbSIEQtF>;
	Thu, 5 Sep 2002 12:49:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15735.35748.328193.108301@napali.hpl.hp.com>
Date: Thu, 5 Sep 2002 09:51:48 -0700
To: "R Sreelatha" <rsreelat@in.ibm.com>
Cc: linux-ia64@linuxia64.org, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: patch for IA64: fix do_sys32_msgrcv bad address error.
In-Reply-To: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com>
References: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 5 Sep 2002 19:46:40 +0530, "R Sreelatha" <rsreelat@in.ibm.com> said:

  R> In sys_ia32.c file, in the do_sys32_msgrcv() function call, the
  R> value of ipck.msgp is interpreted as a 64 bit address, whereas it
  R> is a 32 bit address.  Hence, do_sys32_msgrcv() finally returns
  R> EFAULT(bad address) error.  The patch below takes care of this by
  R> type casting ipck.msgp to type u32.  The patch is created for
  R> 2.5.32 version of the kernel.

Yes, this was obviously broken.  I committed the attached patch to my 2.5
tree.

	--david

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.532   -> 1.533  
#	arch/ia64/ia32/sys_ia32.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/05	davidm@tiger.hpl.hp.com	1.533
# ia64: Fix x86 struct ipc_kludge (reported by R Sreelatha, fix proposed by
# 	Dave Miller).
# --------------------------------------------
#
diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	Thu Sep  5 09:51:05 2002
+++ b/arch/ia64/ia32/sys_ia32.c	Thu Sep  5 09:51:05 2002
@@ -2111,8 +2111,8 @@
 };
 
 struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
+	u32 msgp;
+	s32 msgtyp;
 };
 
 #define SEMOP		 1
