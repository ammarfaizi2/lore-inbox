Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965515AbWJ3Kqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965515AbWJ3Kqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965514AbWJ3Kqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:46:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38375 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965508AbWJ3Kqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:46:34 -0500
To: linux-arch@vger.kernel.org
Subject: [PATCH 7/7] severing poll.h -> mm.h
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUf3-0002pq-8q@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:46:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/hpet.c                     |    1 +
 drivers/media/dvb/cinergyT2/cinergyT2.c |    1 +
 include/linux/poll.h                    |    3 ++-
 include/sound/pcm.h                     |    1 +
 sound/oss/cs46xx.c                      |    1 +
 sound/oss/dmabuf.c                      |    1 +
 sound/oss/emu10k1/audio.c               |    1 +
 sound/oss/es1371.c                      |    1 +
 sound/oss/i810_audio.c                  |    1 +
 sound/oss/soundcard.c                   |    1 +
 sound/oss/sscape.c                      |    1 +
 sound/oss/trident.c                     |    1 +
 12 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 091a11c..20dc3be 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -21,6 +21,7 @@ #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/poll.h>
+#include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/sysctl.h>
diff --git a/drivers/media/dvb/cinergyT2/cinergyT2.c b/drivers/media/dvb/cinergyT2/cinergyT2.c
index ff7d4f5..087723f 100644
--- a/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ b/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -30,6 +30,7 @@ #include <linux/pci.h>
 #include <linux/input.h>
 #include <linux/dvb/frontend.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include "dmxdev.h"
 #include "dvb_demux.h"
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 51e1b56..2769079 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -8,7 +8,8 @@ #ifdef __KERNEL__
 #include <linux/compiler.h>
 #include <linux/wait.h>
 #include <linux/string.h>
-#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index afaf3e8..2f645df 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -26,6 +26,7 @@ #define __SOUND_PCM_H
 #include <sound/asound.h>
 #include <sound/memalloc.h>
 #include <linux/poll.h>
+#include <linux/mm.h>
 #include <linux/bitops.h>
 
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
index 6e3c41f..14f3451 100644
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -91,6 +91,7 @@ #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/ac97_codec.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
diff --git a/sound/oss/dmabuf.c b/sound/oss/dmabuf.c
index b256c04..eaf6997 100644
--- a/sound/oss/dmabuf.c
+++ b/sound/oss/dmabuf.c
@@ -25,6 +25,7 @@
 #define BE_CONSERVATIVE
 #define SAMPLE_ROUNDUP 0
 
+#include <linux/mm.h>
 #include "sound_config.h"
 
 #define DMAP_FREE_ON_CLOSE      0
diff --git a/sound/oss/emu10k1/audio.c b/sound/oss/emu10k1/audio.c
index cde4d59..86dd239 100644
--- a/sound/oss/emu10k1/audio.c
+++ b/sound/oss/emu10k1/audio.c
@@ -36,6 +36,7 @@ #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/smp_lock.h>
 
 #include "hwaccess.h"
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index ddf6b0a..cc282a0 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -130,6 +130,7 @@ #include <linux/gameport.h>
 #include <linux/wait.h>
 #include <linux/dma-mapping.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include <asm/io.h>
 #include <asm/page.h>
diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
index 240cc79..c3c8a72 100644
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -101,6 +101,7 @@ #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include <asm/uaccess.h>
 
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
index 2344d09..76ace33 100644
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -42,6 +42,7 @@ #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 
 /*
  * This ought to be moved into include/asm/dma.h
diff --git a/sound/oss/sscape.c b/sound/oss/sscape.c
index 51f2fa6..30c36d1 100644
--- a/sound/oss/sscape.c
+++ b/sound/oss/sscape.c
@@ -39,6 +39,7 @@ #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/mm.h>
 #include <linux/spinlock.h>
 
 #include "coproc.h"
diff --git a/sound/oss/trident.c b/sound/oss/trident.c
index 7a363a1..6b1f8c9 100644
--- a/sound/oss/trident.c
+++ b/sound/oss/trident.c
@@ -216,6 +216,7 @@ #include <linux/pm.h>
 #include <linux/gameport.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
-- 
1.4.2.GIT

