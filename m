Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSGJLYd>; Wed, 10 Jul 2002 07:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSGJLYd>; Wed, 10 Jul 2002 07:24:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:8173 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315627AbSGJLYb>; Wed, 10 Jul 2002 07:24:31 -0400
Date: Wed, 10 Jul 2002 13:27:10 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1 does not compile without CONFIG_BLK_DEV_FD=y
In-Reply-To: <200207101047.12241.roy@karlsbakk.net>
Message-ID: <Pine.NEB.4.44.0207101326200.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Roy Sigurd Karlsbakk wrote:

> hi all
>
> trying to compile 2.4.19-rc1 without floppy support, I get the below link
> error. .config is attached as config.gz


This is a known bug. The following patch (already in Marcelos's BK tree)
fixes it:


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

> thanks
>
> roy

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

