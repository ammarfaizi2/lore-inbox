Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVC1WDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVC1WDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVC1WDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:03:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61196 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262092AbVC1WDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:03:10 -0500
Date: Tue, 29 Mar 2005 00:03:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] sound/oss/: cleanups
Message-ID: <20050328220307.GO4285@stusta.de>
References: <20050306220747.GP5070@stusta.de> <40f323d00503281255124bd0c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d00503281255124bd0c8@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 03:55:36PM -0500, Benoit Boissinot wrote:
> On Sun, 6 Mar 2005 23:07:47 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch contains cleanups including the following:
> > - make needlessly global code static
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.11-mm1-full/sound/oss/nm256_audio.c.old   2005-03-06 22:14:42.000000000 +0100
> > +++ linux-2.6.11-mm1-full/sound/oss/nm256_audio.c       2005-03-06 22:22:52.000000000 +0100
> > @@ -31,7 +31,7 @@
> >  #include "nm256.h"
> >  #include "nm256_coeff.h"
> > 
> > -int nm256_debug;
> > +static int nm256_debug;
> >  static int force_load;
> > 
> >  /*
> 
> nm256_debug is used in functions declared in nm256.h (those functions
> are used in nm256_coeff.h and nm256_audio.c).

The usage in nm256_audio.c is clear (the variable is in this file).

In which other .c file did you find any usage of nm256_debug?

> This part of the patch should be dropped (it doesn't build on gcc-4.0).

That's a different problem.
Please apply the patch below on top of my other patch.

> regards,
> 
> Benoit



<--  snip  -->


Rearrange sound/oss/nm256_audio.c and to drop nm256_debug from nm256.h 
since it confuses gcc 4.0 .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm3-full/sound/oss/nm256.h.old	2005-03-28 23:49:39.000000000 +0200
+++ linux-2.6.12-rc1-mm3-full/sound/oss/nm256.h	2005-03-28 23:51:33.000000000 +0200
@@ -128,9 +128,6 @@
     struct nm256_info *next_card;
 };
 
-/* Debug flag--bigger numbers mean more output. */
-extern int nm256_debug;
-
 /* The BIOS signature. */
 #define NM_SIGNATURE 0x4e4d0000
 /* Signature mask. */
--- linux-2.6.12-rc1-mm3-full/sound/oss/nm256_audio.c.old	2005-03-28 23:51:53.000000000 +0200
+++ linux-2.6.12-rc1-mm3-full/sound/oss/nm256_audio.c	2005-03-28 23:52:19.000000000 +0200
@@ -28,12 +28,13 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
-#include "nm256.h"
-#include "nm256_coeff.h"
 
 static int nm256_debug;
 static int force_load;
 
+#include "nm256.h"
+#include "nm256_coeff.h"
+
 /* 
  * The size of the playback reserve.  When the playback buffer has less
  * than NM256_PLAY_WMARK_SIZE bytes to output, we request a new

