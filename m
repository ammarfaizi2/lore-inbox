Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRHLCLn>; Sat, 11 Aug 2001 22:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbRHLCLd>; Sat, 11 Aug 2001 22:11:33 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:28687 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268917AbRHLCLW>;
	Sat, 11 Aug 2001 22:11:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: Tom Rini <trini@kernel.crashing.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sat, 11 Aug 2001 21:20:52 +0200."
             <20010811212051.A819@jaquet.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 12:11:27 +1000
Message-ID: <6820.997582287@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001 21:20:52 +0200, 
Rasmus Andersen <rasmus@jaquet.dk> wrote:
>pp_makefile2: drivers/char/defkeymap.o is selected but is not part of vmlinux, missing link_subdirs?

Against 2.4.8 + kbuild-2.5-2.4.8-1.  I will put up a -2 later today
containing this fix and a few others.

Index: 8.7/scripts/pp_makefile2.c
--- 8.7/scripts/pp_makefile2.c Sat, 11 Aug 2001 22:45:22 +1000 kaos (linux-2.4/I/d/36_pp_makefil 1.24 644)
+++ 8.7(w)/scripts/pp_makefile2.c Sun, 12 Aug 2001 11:43:58 +1000 kaos (linux-2.4/I/d/36_pp_makefil 1.24 644)
@@ -754,7 +754,10 @@ int special_oais(PP_DIRENT *dirent, PP_D
   }
   if (dirent->value.db) {
     DB *db = db_list[dirent->value.db];
-    if (!dirent->istarget) {
+    /* FIXME: when the go faster stripes are added, make sure that
+     * dirent->istarget and db->istarget are synced earlier.
+     */
+    if (!db->istarget && !dirent->istarget) {
       return(0);
     }
     switch (type) {

>pp_makefile2: Cannot find source for target drivers/sound/emu10k1/efxmgr.o
>pp_makefile2: Cannot find source for target drivers/sound/emu10k1/joystick.o
>pp_makefile2: Cannot find source for target drivers/sound/emu10k1/passthrough.o

You put kbuild-2.5-2.4.8-1 on an 2.4.8-pre kernel.  Linus moved emu10k1
to its own directory in 2.4.8.  You have match kbuild with the correct
kernel.

