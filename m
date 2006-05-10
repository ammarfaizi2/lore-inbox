Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWEJC6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWEJC6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWEJC53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:29 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:6206 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932442AbWEJC4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:50 -0400
Date: Tue, 9 May 2006 19:56:02 -0700
Message-Id: <200605100256.k4A2u2aa031719@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] kexec gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

kernel/kexec.c: In function 'sys_kexec_load':
kernel/kexec.c:998: warning: value computed is not used
kernel/kexec.c: In function 'crash_kexec':
kernel/kexec.c:1066: warning: value computed is not used


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/kernel/kexec.c
===================================================================
--- linux-2.6.16.orig/kernel/kexec.c
+++ linux-2.6.16/kernel/kexec.c
@@ -995,7 +995,7 @@ asmlinkage long sys_kexec_load(unsigned 
 	image = xchg(dest_image, image);
 
 out:
-	xchg(&kexec_lock, 0); /* Release the mutex */
+	locked = xchg(&kexec_lock, 0); /* Release the mutex */
 	kimage_free(image);
 
 	return result;
@@ -1063,7 +1063,7 @@ void crash_kexec(struct pt_regs *regs)
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(image);
 		}
-		xchg(&kexec_lock, 0);
+		locked = xchg(&kexec_lock, 0);
 	}
 }
 
