Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSFFCTD>; Wed, 5 Jun 2002 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSFFCTC>; Wed, 5 Jun 2002 22:19:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27899 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316739AbSFFCTB>; Wed, 5 Jun 2002 22:19:01 -0400
Subject: Re: [PATCH] Fix sys_capset in 2.5.20+patches...
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
        Peter Chubb <peter@chubb.wattle.id.au>
In-Reply-To: <15614.50117.861698.205543@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 19:18:46 -0700
Message-Id: <1023329932.917.421.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 19:07, Peter Chubb wrote:

> 	The current head-of-bk-tree 2.5 kernel breaks capset() (and so
> named, for one, won't run).  SYS_setcap() will *always* return -EINVAL
> with the current tree.

Ugh, do I really need braces there???

(there is another occurrence of this, too... brown paper bag me)

Linus, please apply this patch.  Against 2.5-bk...

	Robert Love

--- linux-2.5.20/kernel/capability.c	Wed Jun  5 19:16:11 2002
+++ linux/kernel/capability.c	Wed Jun  5 19:15:49 2002
@@ -39,13 +39,14 @@
      if (get_user(version, &header->version))
 	     return -EFAULT;
 
-     if (version != _LINUX_CAPABILITY_VERSION)
+     if (version != _LINUX_CAPABILITY_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
 		     return -EFAULT; 
              return -EINVAL;
+     }
 
      if (get_user(pid, &header->pid))
-	     return -EFAULT; 
+	     return -EFAULT;
 
      if (pid < 0) 
              return -EINVAL;
@@ -134,10 +135,11 @@
      if (get_user(version, &header->version))
 	     return -EFAULT; 
 
-     if (version != _LINUX_CAPABILITY_VERSION)
+     if (version != _LINUX_CAPABILITY_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
 		     return -EFAULT; 
              return -EINVAL;
+     }
 
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 

