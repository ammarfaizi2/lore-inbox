Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSGKUFN>; Thu, 11 Jul 2002 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSGKUFM>; Thu, 11 Jul 2002 16:05:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:16845 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317888AbSGKUFK> convert rfc822-to-8bit; Thu, 11 Jul 2002 16:05:10 -0400
Date: Thu, 11 Jul 2002 22:07:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: =?iso-8859-1?Q?Micha=B3_Adamczak?= <pokryfka@druid.if.uj.edu.pl>
cc: linux-kernel@vger.kernel.org, Thunder from the hill <thunder@ngforever.de>
Subject: Re: compilation of floppy as module failure
In-Reply-To: <20020711192357.GA3722@localhost>
Message-ID: <Pine.NEB.4.44.0207112206280.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Micha³ Adamczak wrote:

> just wanted to report that in 2.4.19-rc1
> the kernel image does not compile if floppy (CONFIG_BLK_DEV_FD) is
> to be compiled as a module.
>
> the problem does not exist when the floppy is built in.
>...

This is a known problem. The following patch that is already in Marcelos'
BK repository fixes it:


diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Mon Jun 24 14:08:10 2002
+++ b/init/do_mounts.c	Mon Jun 24 14:08:10 2002
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

