Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUCTTRE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbUCTTRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:17:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2512 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263513AbUCTTQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:16:49 -0500
Date: Sat, 20 Mar 2004 20:16:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA pdaudiocf: fix three compile warnings
Message-ID: <20040320191642.GN19464@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warnings in 2.6.5-rc:

<--  snip  -->

...
  CC      sound/pcmcia/pdaudiocf/pdaudiocf.o
include/sound/initval.h:141: warning: `get_id' defined but not used
  CC      sound/pcmcia/pdaudiocf/pdaudiocf_core.o
include/sound/initval.h:141: warning: `get_id' defined but not used
  CC      sound/pcmcia/pdaudiocf/pdaudiocf_irq.o
include/sound/initval.h:141: warning: `get_id' defined but not used
...

<--  snip  -->

Below is a patch that fixes these warnings (SNDRV_GET_ID is not required 
since these files don't use get_id).

I've tested both the modular and the non-modular compilation.

cu
Adrian

--- linux-2.6.5-rc1-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf.c.old	2004-03-20 19:38:48.000000000 +0100
+++ linux-2.6.5-rc1-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf.c	2004-03-20 19:39:30.000000000 +0100
@@ -25,7 +25,6 @@
 #include <pcmcia/ciscode.h>
 #include <pcmcia/cisreg.h>
 #include "pdaudiocf.h"
-#define SNDRV_GET_ID
 #include <sound/initval.h>
 
 /*
--- linux-2.6.5-rc1-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_core.c.old	2004-03-20 19:39:30.000000000 +0100
+++ linux-2.6.5-rc1-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2004-03-20 19:39:34.000000000 +0100
@@ -23,7 +23,6 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include "pdaudiocf.h"
-#define SNDRV_GET_ID
 #include <sound/initval.h>
 
 /*
--- linux-2.6.5-rc1-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c.old	2004-03-20 19:39:35.000000000 +0100
+++ linux-2.6.5-rc1-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c	2004-03-20 19:39:39.000000000 +0100
@@ -21,7 +21,6 @@
 #include <sound/driver.h>
 #include <sound/core.h>
 #include "pdaudiocf.h"
-#define SNDRV_GET_ID
 #include <sound/initval.h>
 
 /*
