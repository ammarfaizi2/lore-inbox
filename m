Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSBGS4S>; Thu, 7 Feb 2002 13:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289118AbSBGS4I>; Thu, 7 Feb 2002 13:56:08 -0500
Received: from gate.perex.cz ([194.212.165.105]:18450 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S288987AbSBGSzv> convert rfc822-to-8bit;
	Thu, 7 Feb 2002 13:55:51 -0500
Date: Thu, 7 Feb 2002 19:54:50 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: =?X-UNKNOWN?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.4pre2] ALSA
In-Reply-To: <20020207192709.00336f41.sebastian.droege@gmx.de>
Message-ID: <Pine.LNX.4.31.0202071953230.538-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Sebastian Dröge wrote:

> Hi,
> I get following compile error when compiling with attached .config:
>
> make[2]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux/arch/i386/lib«make[1]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux/arch/i386/lib«ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
> 	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.o /usr/src/linux/arch/i386/lib/lib.a \
> 	 drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
> 	net/network.o \
> 	--end-group \
> 	-o vmlinux
> sound/sound.o: In function `snd_mpu401_uart_output_write':
> sound/sound.o(.text+0x1b551): undefined reference to `snd_rawmidi_transmit_peek'sound/sound.o(.text+0x1b583): undefined reference to `snd_rawmidi_transmit_ack'
> sound/sound.o: In function `snd_mpu401_uart_new':
> sound/sound.o(.text+0x1b60d): undefined reference to `snd_rawmidi_new'
> sound/sound.o(.text+0x1b71b): undefined reference to `snd_rawmidi_set_ops'
> sound/sound.o(.text+0x1b72c): undefined reference to `snd_rawmidi_set_ops'
> sound/sound.o: In function `snd_mpu401_uart_input_read':
> sound/sound.o(.text+0x1b7eb): undefined reference to `snd_rawmidi_receive'
> make: *** [vmlinux] Fehler 1

Thanks, please, use this patch to change your linux/sound/core/Makefile:

Index: Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- Makefile    11 Jan 2002 10:41:41 -0000      1.3
+++ Makefile    7 Feb 2002 18:53:32 -0000
@@ -79,7 +79,7 @@
 obj-$(CONFIG_SND_CS4281) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
snd-hwdep.o
 obj-$(CONFIG_SND_ENS1370) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
 obj-$(CONFIG_SND_ENS1371) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_ES1938) += snd-pcm.o snd-timer.o snd.o snd-hwdep.o
+obj-$(CONFIG_SND_ES1938) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_ES1968) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
 obj-$(CONFIG_SND_FM801) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_ICE1712) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org

