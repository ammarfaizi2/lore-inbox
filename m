Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318982AbSHMTBv>; Tue, 13 Aug 2002 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318983AbSHMTBv>; Tue, 13 Aug 2002 15:01:51 -0400
Received: from mnh-1-03.mv.com ([207.22.10.35]:58885 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318982AbSHMTBu>;
	Tue, 13 Aug 2002 15:01:50 -0400
Message-Id: <200208132008.PAA03902@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - part 2 of 3 
In-Reply-To: Your message of "Tue, 13 Aug 2002 09:13:58 MST."
             <Pine.LNX.4.44.0208130912390.7291-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 15:08:56 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> Please use "root=0xXXYY" instead, or consider figuring out the name
> _automatically_ from the list of genhd's in the system (ie the reverse
> of  blkdev_name() or whatever it is called).

OK, consider that patch withdrawn.  In its place is the one below.  It's in
UML arch code, so it needs to be applied after UML itself.  It disables
'root=/dev/ubdxx' in UML for the time being.

The root_dev_names array looks like it can be eliminated entirely, as long
as the gendisk list is populated before checksetup.  This means either there
needs to be a before_setup_initcall or the calculation of the rootdev kdev_t
needs to be split out from the argument parsing and put in a late initcall.
I don't know if that breaks anything.

If that is reasonable, I can start laying the groundwork.

				Jeff

--- linus/arch/um/kernel/um_arch.c~     Fri Aug  2 22:06:03 2002
+++ linus/arch/um/kernel/um_arch.c      Tue Aug 13 14:32:39 2002
@@ -38,7 +38,7 @@
 int fg_console;
 struct kbd_struct kbd_table[MAX_NR_CONSOLES];
 
-#define DEFAULT_COMMAND_LINE "root=/dev/ubd0"
+#define DEFAULT_COMMAND_LINE "root=6200"
 
 unsigned long thread_saved_pc(struct task_struct *task)
 {

