Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSFXRzt>; Mon, 24 Jun 2002 13:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSFXRzt>; Mon, 24 Jun 2002 13:55:49 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:36837 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S314596AbSFXRzr>; Mon, 24 Jun 2002 13:55:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: Re: kbuild fixes and more
Date: Mon, 24 Jun 2002 19:59:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206231913170.24916-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0206231913170.24916-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020624175547Z314596-22020+10086@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 June 2002 02:15, Kai Germaschewski wrote:
> On Sun, 23 Jun 2002, Rudmer van Dijk wrote:
> > got this error while patching (against 2.5.24 tarball):
>
> Hmmh, it seems all three errors you get are related to the same problem: I
> don't know the proper command how to create a gnu patch from my bk tree.
>
> Anyway, so now there's a version 3 which I diffed manually. Still has the
> warning for "make clean", but should work.

Did not see this warning, it applies cleanly 8-)

>
> (I couldn't help but wonder: Is three tries enough to get it right?)

It looks like it, it compiles in one go! (did not run it (yet))

I was only wondering about this:

# make KBUILD_VERBOSE= KBUILD_MODULES=1 bzImage
<snip>
  CP     drivers/char/defkeymap.c
<snip>
  LD     drivers/char/built-in.o
rm defkeymap.c
^^^^^^^^^
<snip>

why is it first copied to this dir and later on, after linking all char 
drivers together, it is removed again... isn't it simpler to just leave the 
file in place??

I also like the complete silence of the final linking:
  BUILD  arch/i386/boot/bzImage
Root device is (3, 2)
Boot sector 512 bytes.
Setup is 2636 bytes.
System is 847 kB

This is very nice!

I have a minor 'fix' included

	Rudmer

--- linux-2.5.24-kg3/Makefile.orig	2002-06-24 19:48:48.000000000 +0200
+++ linux-2.5.24-kg3/Makefile	2002-06-24 19:49:01.000000000 +0200
@@ -5,7 +5,7 @@
 
 # *DOCUMENTATION*
 # Too see a list of typical targets execute "make help"
-# More info can be located in ./Documentation/kbuild
+# More info can be found in ./Documentation/kbuild
 # Comments in this file is targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
-or-

--- linux-2.5.24-kg3/Makefile.orig	2002-06-24 19:48:48.000000000 +0200
+++ linux-2.5.24-kg3/Makefile	2002-06-24 19:49:01.000000000 +0200
@@ -5,7 +5,7 @@
 
 # *DOCUMENTATION*
 # Too see a list of typical targets execute "make help"
-# More info can be located in ./Documentation/kbuild
+# More info is located in ./Documentation/kbuild
 # Comments in this file is targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 

