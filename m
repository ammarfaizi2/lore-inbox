Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTJGUdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTJGUdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:33:23 -0400
Received: from [193.138.115.2] ([193.138.115.2]:56583 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262767AbTJGUdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:33:17 -0400
Date: Tue, 7 Oct 2003 22:31:35 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: jw schultz <jw@pegasys.ws>
cc: Matthias Andree <matthias.andree@gmx.de>,
       Mike Fedyk <mfedyk@matchmail.com>, jdow <jdow@earthlink.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
In-Reply-To: <20031006233758.GF22023@pegasys.ws>
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC0649321E@difpst1a.dif.dk>
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com>
 <20031006083803.GB1135@matchmail.com> <20031006102415.GB7598@merlin.emma.line.org>
 <Pine.LNX.4.56.0310061655070.26687@jju_lnx.backbone.dif.dk>
 <00b401c38c31$d1360390$2eedfea9@kittycat> <20031006233758.GF22023@pegasys.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Oct 2003, jw schultz wrote:

> On Mon, Oct 06, 2003 at 10:46:48AM -0700, jdow wrote:
> > From: "Jesper Juhl" <jju@dif.dk>
> > > On Mon, 6 Oct 2003, Matthias Andree wrote:
> > >
> > > > On Mon, 06 Oct 2003, Mike Fedyk wrote:
> > > >
> > > > > config DEBUG_INFO
> > > > > bool "Compile the kernel with debug info"
> > > > > depends on DEBUG_KERNEL
> > > > > help
> > > > >           If you say Y here the resulting kernel image will include
> > > > >   debugging info resulting in a larger kernel image.
> > > > >   Say Y here only if you plan to use gdb to debug the kernel.
> > > > >   If you don't debug the kernel, you can say N.
> > > > >
> > > > > "Larger kernel image" yeah, NO SHIT! ;)
> > > > >
> > > > > Maybe something that says it may enlarge your kernel by 5-10 times
> > would be
> > > > > nice...
> > > >
> > > > Send a patch...
> > > >
> > >
> > > How about this one?  :
> > >
> > >
> > > diff -ur linux-2.6.0-test6-orig/arch/alpha/Kconfig
> > linux-2.6.0-test6/arch/alpha/Kconfig
> > > --- linux-2.6.0-test6-orig/arch/alpha/Kconfig 2003-09-28
> > 02:50:39.000000000 +0200
> > > +++ linux-2.6.0-test6/arch/alpha/Kconfig 2003-10-06 17:10:32.000000000
> > +0200
> > > @@ -769,6 +769,8 @@
> > >   help
> > >            If you say Y here the resulting kernel image will include
> > >     debugging info resulting in a larger kernel image.
> > > +   This will substantially increase the size of the kernel image.
> > > +   Size increases of 5 to 10 times normal size is to be expected.
> >
> > --------------------------------------------------^^ "are"
>
> It isn't multiple increases but one of variable size.
>
> 	"A size of 5 to 10 times normal is to be expected."
>
> Gets the conjugation correct and eliminates the implied
> 	size += 6..10 * normal
>

Here's a corrected patch...
Is there an official maintainer for documentation that this should be send
to? Or should we just cross our fingers and hope someone "higher up" will
pick it up from linux-kernel and merge it?
I see noone listed as maintaining docs in general or Kconfig in
particular in the MAINTAINERS file.


diff -ur linux-2.6.0-test6-orig/arch/alpha/Kconfig linux-2.6.0-test6/arch/alpha/Kconfig
--- linux-2.6.0-test6-orig/arch/alpha/Kconfig	2003-09-28 02:50:39.000000000 +0200
+++ linux-2.6.0-test6/arch/alpha/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -769,6 +769,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/arm26/Kconfig linux-2.6.0-test6/arch/arm26/Kconfig
--- linux-2.6.0-test6-orig/arch/arm26/Kconfig	2003-09-28 02:50:29.000000000 +0200
+++ linux-2.6.0-test6/arch/arm26/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -336,6 +336,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/i386/Kconfig linux-2.6.0-test6/arch/i386/Kconfig
--- linux-2.6.0-test6-orig/arch/i386/Kconfig	2003-09-28 02:50:10.000000000 +0200
+++ linux-2.6.0-test6/arch/i386/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -1244,6 +1244,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/ia64/Kconfig linux-2.6.0-test6/arch/ia64/Kconfig
--- linux-2.6.0-test6-orig/arch/ia64/Kconfig	2003-09-28 02:51:04.000000000 +0200
+++ linux-2.6.0-test6/arch/ia64/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -683,6 +683,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/m68k/Kconfig linux-2.6.0-test6/arch/m68k/Kconfig
--- linux-2.6.0-test6-orig/arch/m68k/Kconfig	2003-09-28 02:50:29.000000000 +0200
+++ linux-2.6.0-test6/arch/m68k/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -1166,6 +1166,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/parisc/Kconfig linux-2.6.0-test6/arch/parisc/Kconfig
--- linux-2.6.0-test6-orig/arch/parisc/Kconfig	2003-09-28 02:50:29.000000000 +0200
+++ linux-2.6.0-test6/arch/parisc/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -257,6 +257,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/ppc/Kconfig linux-2.6.0-test6/arch/ppc/Kconfig
--- linux-2.6.0-test6-orig/arch/ppc/Kconfig	2003-09-28 02:51:12.000000000 +0200
+++ linux-2.6.0-test6/arch/ppc/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -1390,6 +1390,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use some sort of debugger to
 	  debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/ppc64/Kconfig linux-2.6.0-test6/arch/ppc64/Kconfig
--- linux-2.6.0-test6-orig/arch/ppc64/Kconfig	2003-09-28 02:50:25.000000000 +0200
+++ linux-2.6.0-test6/arch/ppc64/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -374,6 +374,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/s390/Kconfig linux-2.6.0-test6/arch/s390/Kconfig
--- linux-2.6.0-test6-orig/arch/s390/Kconfig	2003-09-28 02:50:16.000000000 +0200
+++ linux-2.6.0-test6/arch/s390/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -309,6 +309,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/sparc64/Kconfig linux-2.6.0-test6/arch/sparc64/Kconfig
--- linux-2.6.0-test6-orig/arch/sparc64/Kconfig	2003-09-28 02:50:53.000000000 +0200
+++ linux-2.6.0-test6/arch/sparc64/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -819,6 +819,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.

diff -ur linux-2.6.0-test6-orig/arch/x86_64/Kconfig linux-2.6.0-test6/arch/x86_64/Kconfig
--- linux-2.6.0-test6-orig/arch/x86_64/Kconfig	2003-09-28 02:50:40.000000000 +0200
+++ linux-2.6.0-test6/arch/x86_64/Kconfig	2003-10-07 21:50:38.000000000 +0200
@@ -495,6 +495,8 @@
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
+	  This will substantially increase the size of the kernel image.
+	  A size of 5 to 10 times normal is to be expected.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.


/Jesper Juhl <jju@dif.dk>
