Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162934AbWLBLIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162934AbWLBLIb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422875AbWLBLI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:08:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162349AbWLBK70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ozx0F+upPc4EEPIdLsW7HuOLnOi+wpS5FAYMAly8HolL+1iuayGCKdsniCLbnDyZ7ME+uAiYDQEPD9UloI+EpTHPvRPi7VkVhS7U3oGY+X0uX1A6pl5z+8Y9bvcJCzOueTF5sdXmNKm09aJLKFpR8Nd4zNm+aLuPQwnoiBN5jog=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/26] Dynamic kernel command-line - h8300
Date: Sat, 2 Dec 2006 12:50:55 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021250.56334.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/h8300/kernel/setup.c linux-2.6.19/arch/h8300/kernel/setup.c
--- linux-2.6.19.org/arch/h8300/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/h8300/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -54,7 +54,7 @@ unsigned long rom_length;
 unsigned long memory_start;
 unsigned long memory_end;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 extern int _stext, _etext, _sdata, _edata, _sbss, _ebss, _end;
 extern int _ramstart, _ramend;
@@ -154,8 +154,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 
