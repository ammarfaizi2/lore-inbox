Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSFYFGS>; Tue, 25 Jun 2002 01:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSFYFGR>; Tue, 25 Jun 2002 01:06:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:42450 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315207AbSFYFGQ>; Tue, 25 Jun 2002 01:06:16 -0400
Date: Tue, 25 Jun 2002 07:06:15 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Chris Rode <electro@mrduck.net>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1: undefined reference to `change_floppy'
In-Reply-To: <Pine.LNX.4.44.0206242037320.5740-100000@lithium.mrduck.net>
Message-ID: <Pine.NEB.4.44.0206250705410.21028-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Chris Rode wrote:

> On a system with CONFIG_BLK_DEV_FD not defined, I get on the final link:
>
> init/do_mounts.o: In function `rd_load_image':
> init/do_mounts.o(.text.init+0x91b): undefined reference to `change_floppy'
> init/do_mounts.o: In function `rd_load_disk':
> init/do_mounts.o(.text.init+0xa45): undefined reference to `change_floppy'
> make: *** [vmlinux] Error 1
>...

This is a known bug. The following patch fixes it:

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

> Thanks,
> --Chris.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

