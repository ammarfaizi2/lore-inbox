Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSJQVYW>; Thu, 17 Oct 2002 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbSJQVYM>; Thu, 17 Oct 2002 17:24:12 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50446 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262156AbSJQVXp>;
	Thu, 17 Oct 2002 17:23:45 -0400
Date: Thu, 17 Oct 2002 14:29:24 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.43
Message-ID: <20021017212924.GD1125@kroah.com>
References: <20021017212620.GA1125@kroah.com> <20021017212809.GB1125@kroah.com> <20021017212839.GC1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017212839.GC1125@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.800, 2002/10/17 14:04:04-07:00, greg@kroah.com

LSM: change all usages of security_ops->ptrace() to security_ptrace()


diff -Nru a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
--- a/arch/arm/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/arm/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -719,8 +719,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/i386/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -160,8 +160,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
--- a/arch/ia64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/ia64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -1101,8 +1101,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		current->ptrace |= PT_PTRACED;
 		ret = 0;
diff -Nru a/arch/ppc/kernel/ptrace.c b/arch/ppc/kernel/ptrace.c
--- a/arch/ppc/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/ppc/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -166,8 +166,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ppc64/kernel/ptrace.c b/arch/ppc64/kernel/ptrace.c
--- a/arch/ppc64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/ppc64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -59,8 +59,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/ppc64/kernel/ptrace32.c b/arch/ppc64/kernel/ptrace32.c
--- a/arch/ppc64/kernel/ptrace32.c	Thu Oct 17 14:19:12 2002
+++ b/arch/ppc64/kernel/ptrace32.c	Thu Oct 17 14:19:12 2002
@@ -48,8 +48,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
--- a/arch/s390/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/s390/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -330,8 +330,7 @@
 		ret = -EPERM;
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/s390x/kernel/ptrace.c b/arch/s390x/kernel/ptrace.c
--- a/arch/s390x/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/s390x/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -569,8 +569,7 @@
 		ret = -EPERM;
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
--- a/arch/sparc/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/sparc/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -291,8 +291,7 @@
 			pt_error_return(regs, EPERM);
 			goto out;
 		}
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret) {
+		if ((ret = security_ptrace(current->parent, current))) {
 			pt_error_return(regs, -ret);
 			goto out;
 		}
diff -Nru a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
--- a/arch/sparc64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/sparc64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -140,8 +140,7 @@
 			pt_error_return(regs, EPERM);
 			goto out;
 		}
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret) {
+		if ((ret = security_ptrace(current->parent, current))) {
 			pt_error_return(regs, -ret);
 			goto out;
 		}
diff -Nru a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
--- a/arch/um/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/um/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -33,8 +33,7 @@
 		if (current->ptrace & PT_PTRACED)
 			goto out;
 
-		ret = security_ops->ptrace(current->parent, current);
-		if(ret)
+		if ((ret = security_ptrace(current->parent, current)))
  			goto out;
 
 		/* set the ptrace bit in the process flags. */
diff -Nru a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
--- a/arch/x86_64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/arch/x86_64/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -178,8 +178,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
+++ b/kernel/ptrace.c	Thu Oct 17 14:19:12 2002
@@ -101,8 +101,7 @@
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
 		goto bad;
-	retval = security_ops->ptrace(current, task);
-	if (retval)
+	if ((retval = security_ptrace(current, task)))
 		goto bad;
 
 	/* Go */
