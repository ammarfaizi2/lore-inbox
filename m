Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSFWU7k>; Sun, 23 Jun 2002 16:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSFWU7j>; Sun, 23 Jun 2002 16:59:39 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:19109 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S317140AbSFWU7j>; Sun, 23 Jun 2002 16:59:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: Re: kbuild fixes and more
Date: Sun, 23 Jun 2002 23:02:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206231527030.6241-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0206231527030.6241-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020623205939Z317140-22020+9329@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 June 2002 22:31, Kai Germaschewski wrote:
> On Sun, 23 Jun 2002, Rudmer van Dijk wrote:
> > patched against 2.5.24-dj1 (one failed hunk) generates errors:
> > # make clean
> > <snip>
> > make -C /aicasm clean
> > make: Entering an unknown directory
> > make: *** /aicasm: No such file or directory.  Stop.
>
> Grr, I just shouldn't do last minute changes without testing. Anyway,
> I just put a fixed version into the same place
> (patch-2.5.24-kg2.{gz,bz2}).
> (It still has some rough edges which need work, but it should at least
> get the job done)

got this error while patching (against 2.5.24 tarball):

can't find file to patch at input line 1696
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|===== BitKeeper/etc/ignore 1.21 vs 1.22 =====
|--- 1.21/BitKeeper/etc/ignore  Mon Jun 17 23:06:10 2002
|+++ 1.22/BitKeeper/etc/ignore  Thu Jun 20 16:11:01 2002
--------------------------

after removing this file from the patch it applies cleanly!
make mrproper works (no more unknown directories)
but I got this error after `make KBUILD_VERBOSE= KBUILD_MODULES=1 bzImage`:
<snip>
  CC     drivers/char/keyboard.o
make[2]: *** No rule to make target `defkeymap.o', needed by `built-in.o'.  
Stop.
make[1]: *** [char] Error 2
make: *** [drivers] Error 2

so now defkeymap.c is not generated (it was removed in 2.5.24)
manually generating it works but then this happened:

<snip>
  CC     arch/i386/boot/compressed/misc.o
make[2]: *** No rule to make target `vmlinux.scr', needed by `piggy.o'.  Stop.
make[1]: *** [compressed/vmlinux] Error 2
make: *** [bzImage] Error 2


>
> However, I don't see why you get a failed hunk it applies cleanly against
> a bitkeeper v2.5.24 tree here. (Could you mail me the .rej file,
> privately).

I'm not using a bitkeeper tree, but the bitkeeper tree and the tarball should 
be the same...

	Rudmer	
