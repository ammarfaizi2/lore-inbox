Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUDXAES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUDXAES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDXAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 20:04:18 -0400
Received: from [193.138.115.101] ([193.138.115.101]:16771 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261793AbUDXAEP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 20:04:15 -0400
Date: Sat, 24 Apr 2004 01:59:32 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [VERY TRIVIAL] patch for 2.6.5 to cleanup missing newlines at end
 of files
Message-ID: <Pine.LNX.4.56.0404240149080.17119@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As we all know, source files should end in newlines, and indeed almost all
files in the 2.6.5 source do, but I found one that does not
(linux-2.6.5/drivers/tc/lk201.h), so here's a patch to fix that.
While I was at it I checked all the files, and a few documentation files
also did not end in newline, so I desided to add one to those as well.

Why bother? Well, gcc will complain with "warning: no newline at end of
file" for the source files, and there's really no need to get that
warning. For the documentation files it is nice to have the file end on a
newline when you cat it or otherwise pass it through some tool that works
on a line by line basis.
Very trivial stuff indeed...

Here's the patch - generated with  diff -ur  against 2.6.5
As it makes no functional changes at all, kills a warning and makes a few
text file more cat/grep/<whatever> friendly I see no reason not to include
it.


diff -ur linux-2.6.5-orig/Documentation/networking/packet_mmap.txt linux-2.6.5/Documentation/networking/packet_mmap.txt
--- linux-2.6.5-orig/Documentation/networking/packet_mmap.txt	2004-04-04 05:36:15.000000000 +0200
+++ linux-2.6.5/Documentation/networking/packet_mmap.txt	2004-04-24 01:44:02.000000000 +0200
@@ -409,4 +409,4 @@
 -
 To unsubscribe from this list: send the line "unsubscribe linux-net" in
 the body of a message to majordomo@vger.kernel.org
-More majordomo info at  http://vger.kernel.org/majordomo-info.html
\ No newline at end of file
+More majordomo info at  http://vger.kernel.org/majordomo-info.html
diff -ur linux-2.6.5-orig/Documentation/sound/oss/ChangeLog.multisound linux-2.6.5/Documentation/sound/oss/ChangeLog.multisound
--- linux-2.6.5-orig/Documentation/sound/oss/ChangeLog.multisound	2004-04-04 05:36:54.000000000 +0200
+++ linux-2.6.5/Documentation/sound/oss/ChangeLog.multisound	2004-04-24 01:43:51.000000000 +0200
@@ -210,4 +210,4 @@

 	* Add preliminary playback support

-	* Use new Turtle Beach DSP code
\ No newline at end of file
+	* Use new Turtle Beach DSP code
diff -ur linux-2.6.5-orig/arch/i386/pci/changelog linux-2.6.5/arch/i386/pci/changelog
--- linux-2.6.5-orig/arch/i386/pci/changelog	2004-04-04 05:38:00.000000000 +0200
+++ linux-2.6.5/arch/i386/pci/changelog	2004-04-24 01:43:03.000000000 +0200
@@ -59,4 +59,4 @@
  *		  for a lot of patience during testing. [mj]
  *
  * Oct  8, 1999 : Split to pci-i386.c, pci-pc.c and pci-visws.c. [mj]
- */
\ No newline at end of file
+ */
diff -ur linux-2.6.5-orig/drivers/tc/lk201.h linux-2.6.5/drivers/tc/lk201.h
--- linux-2.6.5-orig/drivers/tc/lk201.h	2004-04-04 05:37:06.000000000 +0200
+++ linux-2.6.5/drivers/tc/lk201.h	2004-04-24 01:43:39.000000000 +0200
@@ -50,4 +50,4 @@
 #define LK_KEY_REPEAT 180
 #define LK_KEY_ACK 186

-extern unsigned char scancodeRemap[256];
\ No newline at end of file
+extern unsigned char scancodeRemap[256];
diff -ur linux-2.6.5-orig/sound/drivers/opl4/Makefile linux-2.6.5/sound/drivers/opl4/Makefile
--- linux-2.6.5-orig/sound/drivers/opl4/Makefile	2004-04-04 05:38:12.000000000 +0200
+++ linux-2.6.5/sound/drivers/opl4/Makefile	2004-04-24 01:43:28.000000000 +0200
@@ -15,4 +15,4 @@
 sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 obj-$(CONFIG_SND_OPL4_LIB) += snd-opl4-lib.o
-obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-opl4-synth.o
\ No newline at end of file
+obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-opl4-synth.o



--
Jesper Juhl <juhl@dif.dk>
Sysadmin,  Danmarks Idræts-Forbund / Sports Confederation of Denmark
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
