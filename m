Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293008AbSB0W2Z>; Wed, 27 Feb 2002 17:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293011AbSB0W1w>; Wed, 27 Feb 2002 17:27:52 -0500
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:55057 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S293008AbSB0W1T>; Wed, 27 Feb 2002 17:27:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Swalens <eric.swalens@easynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] execve("/bin/sh"...) in init/main.c
Date: Wed, 27 Feb 2002 23:27:34 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16gAZm-0000W3-00@bigglesworth.mail.be.easynet.net>
In-Reply-To: <E16gAZm-0000W3-00@bigglesworth.mail.be.easynet.net>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16gCXd-0000EQ-00@bigglesworth.mail.be.easynet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself. Same patch with a local variable for argv_sh. It should 
apply to both 2.4 and 2.5.

> If init cannot be executed, the init(.) function in init/main.c falls back
> to sh and calls execve("/bin/sh", argv_init, envp_init).
>
> But if there is no "init=" in the command line, argv_init can contain
> something (most likely the "auto" preprended by lilo) and the shell will
> terminate immediately. (parse_options(.) does not handle this case since it
> does not find "init=").

--- linux-2.4.18/init/main.c    Mon Feb 25 20:38:13 2002
+++ linux/init/main.c   Wed Feb 27 23:12:40 2002
@@ -804,6 +804,8 @@

 static int init(void * unused)
 {
+       static char * argv_sh[] = { "sh", NULL, };
+
        lock_kernel();
        do_basic_setup();

@@ -835,6 +837,6 @@
        execve("/sbin/init",argv_init,envp_init);
        execve("/etc/init",argv_init,envp_init);
        execve("/bin/init",argv_init,envp_init);
-       execve("/bin/sh",argv_init,envp_init);
+       execve("/bin/sh",argv_sh,envp_init);
        panic("No init found.  Try passing init= option to kernel.");
 }
