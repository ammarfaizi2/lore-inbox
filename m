Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUF0ORf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUF0ORf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 10:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUF0ORf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 10:17:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24524 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262756AbUF0ORa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 10:17:30 -0400
Date: Sun, 27 Jun 2004 16:17:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [patch] 2.6.7-mm3 ALSA gus compile error
Message-ID: <20040627141723.GT18303@fs.tum.de>
References: <20040626233105.0c1375b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626233105.0c1375b2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 11:31:05PM -0700, Andrew Morton wrote:
>...
> All 198 patches
>...
> bk-alsa.patch
>...

This causes the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
sound/built-in.o(.text+0xfb4ae): In function `snd_gus_synth_new_device':
: undefined reference to `snd_seq_iwffff_init'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


It seems the following is required:

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm3-full/sound/core/seq/instr/Makefile.old	2004-06-27 14:42:55.000000000 +0200
+++ linux-2.6.7-mm3-full/sound/core/seq/instr/Makefile	2004-06-27 14:43:19.000000000 +0200
@@ -19,5 +19,5 @@
 # Toplevel Module Dependency
 obj-$(call sequencer,$(CONFIG_SND_OPL3_LIB)) += snd-ainstr-fm.o
 obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-ainstr-fm.o
-obj-$(call sequencer,$(CONFIG_SND_GUS_SYNTH)) += snd-ainstr-gf1.o snd-ainstr-simple.o
+obj-$(call sequencer,$(CONFIG_SND_GUS_SYNTH)) += snd-ainstr-gf1.o snd-ainstr-simple.o snd-ainstr-iw.o
 obj-$(call sequencer,$(CONFIG_SND_TRIDENT)) += snd-ainstr-simple.o



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

