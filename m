Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSFXVDu>; Mon, 24 Jun 2002 17:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSFXVDt>; Mon, 24 Jun 2002 17:03:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:24791 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315278AbSFXVDr>; Mon, 24 Jun 2002 17:03:47 -0400
Date: Mon, 24 Jun 2002 23:03:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Torrey Hoffman <thoffman@arnor.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1: compile error: undefined reference to `change_floppy'
In-Reply-To: <1024951621.2225.136.camel@shire.arnor.net>
Message-ID: <Pine.NEB.4.44.0206242302370.21028-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2002, Torrey Hoffman wrote:

>...
> init/do_mounts.o: In function `rd_load_image':
> init/do_mounts.o(.text.init+0x91b): undefined reference to
> `change_floppy'
> init/do_mounts.o: In function `rd_load_disk':
> init/do_mounts.o(.text.init+0xa65): undefined reference to
> `change_floppy'
> make: *** [vmlinux] Error 1
>...

This is a known problem. The fix is simple:

--- init/do_mounts.c.old	Tue Jun 18 12:20:12 2002
+++ init/do_mounts.c	Tue Jun 18 12:20:38 2002
@@ -378,7 +378,7 @@
 	return sys_symlink(path + n + 5, name);
 }

-#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




