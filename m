Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282848AbRLBLzG>; Sun, 2 Dec 2001 06:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRLBLy4>; Sun, 2 Dec 2001 06:54:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:3085 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282848AbRLBLyq>;
	Sun, 2 Dec 2001 06:54:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller 
In-Reply-To: Your message of "Sun, 02 Dec 2001 06:31:17 CDT."
             <3C0A1105.18B76D64@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Dec 2001 22:54:34 +1100
Message-ID: <25560.1007294074@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2001 06:31:17 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Simply, all ext2 files are #include'd into a single file, ext2_all.c,
>and all functions and data structures are declared static.

I like it.  With kbuild 2.5 the generation of ext2_all.c (I prefer
ext2_static.c) can be automated.

objlink(ext2.o balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o ioctl.o
        namei.o super.o symlink.o)
select(CONFIG_EXT2_FS ext2.o)
make_static(ext2)

make_static(xxxx), which does not exist yet -

* Checks if CONFIG_MAKE_STATIC is set.
* Takes the objlink information from the kbuild 2.5 database.
* Automatically creates xxxx_static.c as a series of #include
  statements for the source files derived from objlink.
* Replaces the objlink data with objlink(xxxx.o xxxx_static.o).
* Compiles xxxx_static.c with -DXXXX_STATIC=static.

The code that is normally linked into xxxx.o has to be manually changed
to add XXXX_STATIC before a make_static(xxxx) command can be added.

