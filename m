Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUBEO0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUBEO0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:26:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10472 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265217AbUBEO0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:26:13 -0500
Date: Thu, 5 Feb 2004 15:26:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: benny@hostmobility.com, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix two snd_printdd in sound/pci/cs46xx/dsp_spos_scb_lib.c
Message-ID: <20040205142606.GV26093@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warnings in 2.6.2-mm1:

<--  snip  -->

...
  CC      sound/pci/cs46xx/dsp_spos_scb_lib.o
sound/pci/cs46xx/dsp_spos_scb_lib.c: In function 
`cs46xx_dsp_pcm_channel_set_period':
sound/pci/cs46xx/dsp_spos_scb_lib.c:1394: warning: too few arguments for format
sound/pci/cs46xx/dsp_spos_scb_lib.c: In function 
`cs46xx_dsp_pcm_ostream_set_period':
sound/pci/cs46xx/dsp_spos_scb_lib.c:1432: warning: too few arguments for format
...

<--  snip  -->

The trivial fix is below.

Please apply
Adrian

--- linux-2.6.2-mm1/sound/pci/cs46xx/dsp_spos_scb_lib.c.old	2004-02-05 15:14:57.000000000 +0100
+++ linux-2.6.2-mm1/sound/pci/cs46xx/dsp_spos_scb_lib.c	2004-02-05 15:15:28.000000000 +0100
@@ -1391,7 +1391,7 @@
 		temp |= DMA_RQ_C1_SOURCE_MOD16;
 		break; 
 	default:
-		snd_printdd ("period size (%d) not supported by HW\n");
+		snd_printdd ("period size (%d) not supported by HW\n", period_size);
 		return -EINVAL;
 	}
 
@@ -1429,7 +1429,7 @@
 		temp |= DMA_RQ_C1_DEST_MOD16;
 		break; 
 	default:
-		snd_printdd ("period size (%d) not supported by HW\n");
+		snd_printdd ("period size (%d) not supported by HW\n", period_size);
 		return -EINVAL;
 	}
 
