Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSGAPSn>; Mon, 1 Jul 2002 11:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSGAPSn>; Mon, 1 Jul 2002 11:18:43 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:53952 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S315607AbSGAPSl>;
	Mon, 1 Jul 2002 11:18:41 -0400
Date: Mon, 1 Jul 2002 17:20:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Rusty Russell <rusty@rustcorp.com.au>
cc: kuebelr@email.uc.edu,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [TRIVIAL] namespace.c - compiler warning 
In-Reply-To: <E17IN5r-0004a8-00@wagner.rustcorp.com.au>
Message-ID: <Pine.GSO.4.21.0206281724240.14426-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, Rusty Russell wrote:
> In message <20020613035339.GA3950@cartman> you write:
> > init_rootfs() (from ramfs) doesn't appear in any header file.  I didn't
> > see any that looked like a good home, so lets put a prototype at the top
> > of fs/namespace.c.  This only use of this function is in namespace.c.
> > 
> > Patch is agains 2.4.19-pre10.
> 
> Please simply backport the declaration from 2.5: it gets the function
> type correct.

So that becomes:

--- linux-2.4.19-rc1/fs/namespace.c	Fri Apr  5 12:08:18 2002
+++ linux-geert-2.4.19-rc1/fs/namespace.c	Fri Jun 28 17:21:23 2002
@@ -24,6 +24,7 @@
 struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
 int do_remount_sb(struct super_block *sb, int flags, void * data);
 void kill_super(struct super_block *sb);
+extern int __init init_rootfs(void);
 
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

