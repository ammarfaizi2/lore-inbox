Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSFOFd4>; Sat, 15 Jun 2002 01:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSFOFdz>; Sat, 15 Jun 2002 01:33:55 -0400
Received: from [64.76.155.18] ([64.76.155.18]:42401 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S314529AbSFOFdy>;
	Sat, 15 Jun 2002 01:33:54 -0400
Date: Sat, 15 Jun 2002 01:27:31 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: linux-kernel@vger.kernel.org
Subject: [RFC][TRIVIAL] Print a KERN_INFO after a module gets loaded 
Message-ID: <Pine.LNX.4.44.0206150035290.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After some thinking (nothing serious) I came up with the idea of print a 
KERN_INFO after a module got loaded, why? Think about this, some guy 
inserts a LKM rootkit, obviously that module (think adore or knark) 
doesn't say anything when it gets loaded. In this cases is useful to have 
this feature, another example can be simply now the order of a group of 
pre-requisite modules when you load something using modprobe(8).

Before doing this I searched the web, readed some docs and asked on 
#kernelnewbies, it seems there's no standard way to log the insertion of a 
module.

I'm not sure if this is the right way to do this, I'm just adding a printk 
after the module gets initialized, perhaps it must be done somewhere else, 
comments/flames are welcome.

This is pretty useful, at least for me 8) (the printk, not the flames)

Best Regards 

PS: Oops, I forgot, this applies happily against 2.4.18 and 2.5.21

diff -Nrua linux/kernel/module.c linux-info/kernel/module.c
--- linux/kernel/module.c       Sat Jun 15 01:00:24 2002
+++ linux-info/kernel/module.c  Sat Jun 15 01:02:37 2002
@@ -560,6 +560,7 @@
 
        /* And set it running.  */
        mod->flags = (mod->flags | MOD_RUNNING) & ~MOD_INITIALIZING;
+       printk(KERN_INFO "module: %s loaded\n", mod->name);
        error = 0;
        goto err0;

-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

