Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUJKUQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUJKUQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbUJKUQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:16:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50191 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269221AbUJKUQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:16:08 -0400
Date: Mon, 11 Oct 2004 22:15:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [patch] 2.6.9-rc4-mm1: ALSA compile error with KMOD=n
Message-ID: <20041011201533.GB1892@stusta.de>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc3-mm3:
>...
>  bk-alsa.patch
>...


This causes the following compile error with CONFIG_KMOD=n:


<--  snip  -->

...
  CC      sound/core/seq/seq_device.o
sound/core/seq/seq_device.c: In function `snd_seq_device_register_driver':
sound/core/seq/seq_device.c:332: warning: implicit declaration of function `snd_seq_autoload_lock'
sound/core/seq/seq_device.c:335: warning: implicit declaration of function `snd_seq_autoload_unlock'
...
  LD      .tmp_vmlinux1
sound/built-in.o(.text+0xc9ae1): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_lock'
sound/built-in.o(.text+0xc9af7): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_unlock'
sound/built-in.o(.text+0xc9b27): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_unlock'
sound/built-in.o(.text+0xc9b9e): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_unlock'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The fix is simple:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc4-mm1-full/sound/core/seq/seq_device.c.old	2004-10-11 21:40:10.000000000 +0200
+++ linux-2.6.9-rc4-mm1-full/sound/core/seq/seq_device.c	2004-10-11 21:40:38.000000000 +0200
@@ -41,6 +41,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/seq_device.h>
+#include <sound/seq_kernel.h>
 #include <sound/initval.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>

