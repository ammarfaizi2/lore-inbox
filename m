Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292276AbSBOXdf>; Fri, 15 Feb 2002 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292277AbSBOXdQ>; Fri, 15 Feb 2002 18:33:16 -0500
Received: from smtp02.web.de ([217.72.192.151]:43784 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S292276AbSBOXdI>;
	Fri, 15 Feb 2002 18:33:08 -0500
Date: Sat, 16 Feb 2002 00:43:39 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Robert Love <rml@tech9.net>
Cc: davej@suse.de, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@suse.cz>,
        Alessandro Suardi <alessandro.suardi@oracle.com>
Subject: Re: [PATCH] fix xconfig in 2.5.4-dj2
Message-Id: <20020216004339.77caa8a6.l.s.r@web.de>
In-Reply-To: <1013810576.803.1048.camel@phantasy>
In-Reply-To: <20020215230739.33e22865.l.s.r@web.de>
	<1013810576.803.1048.camel@phantasy>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Feb 2002 17:02:55 -0500
Robert Love <rml@tech9.net> wrote:

> On Fri, 2002-02-15 at 17:07, René Scharfe wrote:
> 
> > patch below allows 'make xconfig' to run successfully.
> 
> I believe this is a bug in 2.5.5-pre1, so Dave just picked it
> up from there. 

You are right. *sigh* Should have checked before.

> I recall seeing a merge from Linus in his BK
> changelog for a fix in pre2, too.

According to http://linux.bitkeeper.com/ these buglets are still
in Linus' tree. But after a bit of digging I found a post to LKML
from Peter Samuelson with the first part of the fix.

And my patch was incorrect, too. :( Hopefully correct version is
below.

René



diff -ur linux-2.5.4-dj2/sound/Config.in linux/sound/Config.in
--- linux-2.5.4-dj2/sound/Config.in	Fri Feb 15 22:06:30 2002
+++ linux/sound/Config.in	Fri Feb 15 22:45:24 2002
@@ -19,13 +19,13 @@
   source sound/core/Config.in
   source sound/drivers/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" = "y" ]; then
   source sound/isa/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" = "y" ]; then
   source sound/pci/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" = "y" ]; then
   source sound/ppc/Config.in
 fi
 
diff -ur linux-2.5.4-dj2/sound/isa/Config.in linux/sound/isa/Config.in
--- linux-2.5.4-dj2/sound/isa/Config.in	Fri Feb 15 22:06:31 2002
+++ linux/sound/isa/Config.in	Fri Feb 15 22:51:34 2002
@@ -20,7 +20,7 @@
 dep_tristate 'Sound Blaster 16 (PnP)' CONFIG_SND_SB16 $CONFIG_SND
 dep_tristate 'Sound Blaster AWE (32,64) (PnP)' CONFIG_SND_SBAWE $CONFIG_SND
 if [ "$CONFIG_SND_SB16" != "n" -o "$CONFIG_SND_SBAWE" != "n" ]; then
-  dep_bool 'Sound Blaster 16/AWE CSP support' CONFIG_SND_SB16_CSP
+  bool 'Sound Blaster 16/AWE CSP support' CONFIG_SND_SB16_CSP
 fi
 dep_tristate 'Turtle Beach Maui,Tropez,Tropez+ (Wavefront)' CONFIG_SND_WAVEFRONT $CONFIG_SND
 dep_tristate 'Avance Logic ALS100/ALS120' CONFIG_SND_ALS100 $CONFIG_SND
