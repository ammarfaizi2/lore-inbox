Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSGIBxS>; Mon, 8 Jul 2002 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSGIBxR>; Mon, 8 Jul 2002 21:53:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:5036 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316683AbSGIBxR>;
	Mon, 8 Jul 2002 21:53:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15658.16940.915111.778342@argo.ozlabs.ibm.com>
Date: Tue, 9 Jul 2002 11:53:48 +1000 (EST)
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.19-rc1 doesn't link
In-Reply-To: <200207082330.g68NUtH01899@vindaloo.ras.ucalgary.ca>
References: <200207082330.g68NUtH01899@vindaloo.ras.ucalgary.ca>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch writes:

>   Hi, all. Looks like initrd handling has been broken again:
> init/do_mounts.o: In function `rd_load_image':
> init/do_mounts.o(.text.init+0x941): undefined reference to `change_floppy'
> init/do_mounts.o: In function `rd_load_disk':
> init/do_mounts.o(.text.init+0xa9b): undefined reference to `change_floppy'
> make: *** [vmlinux] Error 1
> 
> This is the config option combination that exposed the bug:
> CONFIG_BLK_DEV_RAM=y
> # CONFIG_BLK_DEV_INITRD is not set

This should fix it...

Paul.

diff -urN linux-2.4.19-rc1/init/do_mounts.c pmac/init/do_mounts.c
--- linux-2.4.19-rc1/init/do_mounts.c	Tue Jun 25 01:23:40 2002
+++ pmac/init/do_mounts.c	Mon Jul  8 22:21:04 2002
@@ -378,7 +378,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
-#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;
