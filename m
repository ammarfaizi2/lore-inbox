Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317376AbSFRKZP>; Tue, 18 Jun 2002 06:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSFRKZO>; Tue, 18 Jun 2002 06:25:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:47869 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317376AbSFRKZN>; Tue, 18 Jun 2002 06:25:13 -0400
Date: Tue, 18 Jun 2002 12:25:11 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Gerd Knorr <kraxel@bytesex.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Peter Chubb <peter@chubb.wattle.id.au>, <rusty@rustcorp.com.au>
cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre build failure
In-Reply-To: <20020618111041.A3317@bytesex.org>
Message-ID: <Pine.NEB.4.44.0206181221230.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Gerd Knorr wrote:

>   Hi,

Hi Gerd,

> Current 2.4 BK tree failes to link the vmlinux image:
>
> [ ... ]
>         -o vmlinux
> init/do_mounts.o: In function `rd_load_image':
> init/do_mounts.o(.text.init+0xa20): undefined reference to `change_floppy'
> init/do_mounts.o: In function `rd_load_disk':
> init/do_mounts.o(.text.init+0xb08): undefined reference to `change_floppy'
> make: *** [vmlinux] Error 1
>...

this seems to be caused by a typo in ChangeSet 1.537.1.13 .

Does the following fix it for you?

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

>   Gerd

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


