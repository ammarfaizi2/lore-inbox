Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSK1Aaa>; Wed, 27 Nov 2002 19:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSK1Aaa>; Wed, 27 Nov 2002 19:30:30 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12293 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265002AbSK1A3k>;
	Wed, 27 Nov 2002 19:29:40 -0500
Date: Wed, 27 Nov 2002 16:28:55 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] More LSM changes for 2.5.49
Message-ID: <20021128002855.GH7187@kroah.com>
References: <20021127230626.GB7187@kroah.com> <20021128002638.GD7187@kroah.com> <20021128002730.GE7187@kroah.com> <20021128002805.GF7187@kroah.com> <20021128002833.GG7187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128002833.GG7187@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.929, 2002/11/27 15:14:22-08:00, greg@kroah.com

LSM: change if statements into something more readable for the arch/* files.


diff -Nru a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
--- a/arch/arm/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/arm/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -711,7 +711,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/i386/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -160,7 +160,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
--- a/arch/ia64/kernel/ptrace.c	Wed Nov 27 15:17:53 2002
+++ b/arch/ia64/kernel/ptrace.c	Wed Nov 27 15:17:53 2002
@@ -1101,7 +1101,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		current->ptrace |= PT_PTRACED;
 		ret = 0;
diff -Nru a/arch/ppc/kernel/ptrace.c b/arch/ppc/kernel/ptrace.c
--- a/arch/ppc/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/ppc/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -166,7 +166,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ppc64/kernel/ptrace.c b/arch/ppc64/kernel/ptrace.c
--- a/arch/ppc64/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/ppc64/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -59,7 +59,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ppc64/kernel/ptrace32.c b/arch/ppc64/kernel/ptrace32.c
--- a/arch/ppc64/kernel/ptrace32.c	Wed Nov 27 15:17:52 2002
+++ b/arch/ppc64/kernel/ptrace32.c	Wed Nov 27 15:17:52 2002
@@ -48,7 +48,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ppc64/kernel/sys_ppc32.c b/arch/ppc64/kernel/sys_ppc32.c
--- a/arch/ppc64/kernel/sys_ppc32.c	Wed Nov 27 15:17:52 2002
+++ b/arch/ppc64/kernel/sys_ppc32.c	Wed Nov 27 15:17:52 2002
@@ -3521,7 +3521,8 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	if ((retval = security_bprm_alloc(&bprm)))
+	retval = security_bprm_alloc(&bprm);
+	if (retval)
 		goto out;
 
 	retval = prepare_binprm(&bprm);
diff -Nru a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
--- a/arch/s390/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/s390/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -323,7 +323,8 @@
 		ret = -EPERM;
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/s390x/kernel/ptrace.c b/arch/s390x/kernel/ptrace.c
--- a/arch/s390x/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/s390x/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -563,7 +563,8 @@
 		ret = -EPERM;
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
--- a/arch/sparc/kernel/ptrace.c	Wed Nov 27 15:17:53 2002
+++ b/arch/sparc/kernel/ptrace.c	Wed Nov 27 15:17:53 2002
@@ -291,7 +291,8 @@
 			pt_error_return(regs, EPERM);
 			goto out;
 		}
-		if ((ret = security_ptrace(current->parent, current))) {
+		ret = security_ptrace(current->parent, current);
+		if (ret) {
 			pt_error_return(regs, -ret);
 			goto out;
 		}
diff -Nru a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
--- a/arch/sparc64/kernel/ptrace.c	Wed Nov 27 15:17:53 2002
+++ b/arch/sparc64/kernel/ptrace.c	Wed Nov 27 15:17:53 2002
@@ -140,7 +140,8 @@
 			pt_error_return(regs, EPERM);
 			goto out;
 		}
-		if ((ret = security_ptrace(current->parent, current))) {
+		ret = security_ptrace(current->parent, current);
+		if (ret) {
 			pt_error_return(regs, -ret);
 			goto out;
 		}
diff -Nru a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
--- a/arch/sparc64/kernel/sys_sparc32.c	Wed Nov 27 15:17:52 2002
+++ b/arch/sparc64/kernel/sys_sparc32.c	Wed Nov 27 15:17:52 2002
@@ -3026,7 +3026,8 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	if ((retval = security_bprm_alloc(&bprm)))
+	retval = security_bprm_alloc(&bprm);
+	if (retval)
 		goto out;
 
 	retval = prepare_binprm(&bprm);
diff -Nru a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
--- a/arch/um/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/um/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -33,7 +33,8 @@
 		if (current->ptrace & PT_PTRACED)
 			goto out;
 
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
  			goto out;
 
 		/* set the ptrace bit in the process flags. */
diff -Nru a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
--- a/arch/x86_64/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
+++ b/arch/x86_64/kernel/ptrace.c	Wed Nov 27 15:17:52 2002
@@ -178,7 +178,8 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
+		ret = security_ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
