Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSFESj0>; Wed, 5 Jun 2002 14:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSFESjZ>; Wed, 5 Jun 2002 14:39:25 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:35472 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S315893AbSFESjW>; Wed, 5 Jun 2002 14:39:22 -0400
Message-Id: <200206051839.g55IdE703488@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Dave Jones <davej@suse.de>
Subject: 2.5.20-dj3, warnings during compile and some fixes
Date: Wed, 5 Jun 2002 20:41:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

got these warnings during compile of linux-2.5.20-dj3:
since this mail is already quite big i've put my .config at 
http://legolas.dynup.net/gandalf-config-2.5.20-dj3

I followed this procedure:
saved old .config
make mrproper
restored old .config
make oldconfig dep
make bzImage
make modules

a lot of the 'problems' have something to do with {constant,variable}_test_bit
for some i have included (obvious??) patches at the end

-- errors found with make bzImage:
gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=mga_dma  -c -o mga_dma.o mga_dma.c
mga_dma.c: In function `mga_do_dma_wrap_start':
mga_dma.c:244: warning: passing arg 2 of `set_bit' from incompatible pointer 
type
mga_dma.c: In function `mga_do_dma_wrap_end':
mga_dma.c:261: warning: passing arg 2 of `clear_bit' from incompatible 
pointer type
mga_dma.c: In function `mga_dma_flush':
mga_dma.c:710: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_dma.c:710: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_dma.c: In function `mga_dma_buffers':
mga_dma.c:801: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_dma.c:801: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=mga_state  -c -o mga_state.o 
mga_state.c
mga_state.c: In function `mga_dma_dispatch_clear':
mga_state.c:606: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:606: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_dispatch_swap':
mga_state.c:662: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:662: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_dispatch_vertex':
mga_state.c:711: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:711: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_dispatch_indices':
mga_state.c:757: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:757: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_dispatch_iload':
mga_state.c:814: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:814: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_clear':
mga_state.c:901: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:901: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_swap':
mga_state.c:925: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:925: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_vertex':
mga_state.c:971: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:971: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_indices':
mga_state.c:1013: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:1013: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_iload':
mga_state.c:1054: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:1054: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
mga_state.c: In function `mga_dma_blit':
mga_state.c:1086: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
mga_state.c:1086: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=pcm_lib -DEXPORT_SYMTAB -c -o 
pcm_lib.o pcm_lib.c
pcm_lib.c: In function `snd_pcm_hw_param_first':
pcm_lib.c:1141: warning: unused variable `err'
pcm_lib.c: In function `snd_pcm_hw_param_last':
pcm_lib.c:1179: warning: unused variable `err'

-- I cannot see what is wrong here...

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=rawmidi -DEXPORT_SYMTAB -c -o 
rawmidi.o rawmidi.c
rawmidi.c: In function `snd_rawmidi_drain_output':
rawmidi.c:146: warning: long int format, int arg (arg 2)
rawmidi.c:146: warning: long int format, int arg (arg 3)

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=seq_clientmgr  -c -o 
seq_clientmgr.o seq_clientmgr.c
seq_clientmgr.c: In function `get_event_dest_client':
seq_clientmgr.c:472: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
seq_clientmgr.c:472: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=seq_queue  -c -o seq_queue.o 
seq_queue.c
seq_queue.c: In function `snd_seq_queue_use':
seq_queue.c:547: warning: passing arg 2 of `test_and_set_bit' from 
incompatible pointer type
seq_queue.c:550: warning: passing arg 2 of `test_and_clear_bit' from 
incompatible pointer type
seq_queue.c: In function `snd_seq_queue_is_used':
seq_queue.c:578: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
seq_queue.c:578: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
seq_queue.c: In function `snd_seq_queue_client_leave':
seq_queue.c:632: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
seq_queue.c:632: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type
seq_queue.c: In function `snd_seq_queue_remove_cells':
seq_queue.c:669: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
seq_queue.c:669: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=ens1371  -c -o ens1371.o ens1371.c
In file included from ens1371.c:2:
ens1370.c: In function `snd_es1371_codec_write':
ens1370.c:590: warning: unsigned int format, long unsigned int arg (arg 3)
ens1370.c: In function `snd_es1371_codec_read':
ens1370.c:638: warning: unsigned int format, long unsigned int arg (arg 4)
ens1370.c:645: warning: unsigned int format, long unsigned int arg (arg 3)
ld -m elf_i386  -r -o snd-ens1371.o ens1371.o
make[3]: Entering directory `/usr/src/kernel/linux-2.5.20-dj3/sound/pci/ac97'
gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=ac97_codec -DEXPORT_SYMTAB -c -o 
ac97_codec.o ac97_codec.c
ac97_codec.c: In function `snd_ac97_write_cache':
ac97_codec.c:263: warning: passing arg 2 of `set_bit' from incompatible 
pointer type
ac97_codec.c: In function `snd_ac97_resume':
ac97_codec.c:2166: warning: passing arg 2 of `constant_test_bit' from 
incompatible pointer type
ac97_codec.c:2166: warning: passing arg 2 of `variable_test_bit' from 
incompatible pointer type

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=io_apic  -c -o io_apic.o io_apic.c
io_apic.c:223: warning: `move' defined but not used

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=cyrix  -c -o cyrix.o cyrix.c
cyrix.c: In function `init_cyrix':
cyrix.c:202: warning: implicit declaration of function `pci_find_device'

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=proc  -c -o proc.o proc.c
proc.c: In function `show_cpuinfo':
proc.c:99: warning: passing arg 2 of `constant_test_bit' from incompatible 
pointer type
proc.c:99: warning: passing arg 2 of `variable_test_bit' from incompatible 
pointer type

<-- snip -->

gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=init_task  -c -o init_task.o 
init_task.c
init_task.c:32: warning: missing braces around initializer
init_task.c:32: warning: (near initialization for 
`init_task.thread.io_bitmap') init_task.c:32: warning: braces around scalar 
initializer
init_task.c:32: warning: (near initialization for 
`init_task.thread.io_bitmap[1]')

-- error found with make modules:
gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.5.20-dj3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4  -DMODULE   -DKBUILD_BASENAME=ide_floppy  -c -o 
ide-floppy.o ide-floppy.c
ide-floppy.c: In function `idefloppy_release':
ide-floppy.c:1755: warning: implicit declaration of function `invalidate_bdev'
make[2]: Leaving directory `/usr/src/kernel/linux-2.5.20-dj3/drivers/ide'
make[2]: Entering directory `/usr/src/kernel/linux-2.5.20-dj3/drivers/input'


hope this helps..

	Rudmer

no warnings during compilation, but did not try to boot it (yet).

-- patches
--- linux-2.5.20-dj3/arch/i386/kernel/cpu/cyrix.c.orig	2002-06-05 
20:20:41.000000000 +0200
+++ linux-2.5.20-dj3/arch/i386/kernel/cpu/cyrix.c	2002-06-05 
20:21:21.000000000 +0200
@@ -1,7 +1,7 @@
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/pci_ids.h>
+#include <linux/pci.h>
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/processor.h>
--- linux-2.5.20-dj3/sound/pci/ens1370.c.orig	2002-06-05 20:11:58.000000000 
+0200
+++ linux-2.5.20-dj3/sound/pci/ens1370.c	2002-06-05 20:30:43.000000000 +0200
@@ -587,7 +587,7 @@
 		}
 		spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 	}
-	snd_printk("codec write timeout at 0x%lx [0x%x]\n", ES_REG(ensoniq, 
1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
+	snd_printk("codec write timeout at 0x%lx [0x%lx]\n", ES_REG(ensoniq, 
1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
 }
 
 static unsigned short snd_es1371_codec_read(ac97_t *ac97,
@@ -635,14 +635,14 @@
 			}
 			spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 			if (++fail > 10) {
-				snd_printk("codec read timeout (final) at 0x%lx, reg = 0x%x [0x%x]\n", 
ES_REG(ensoniq, 1371_CODEC), reg, inl(ES_REG(ensoniq, 1371_CODEC)));
+				snd_printk("codec read timeout (final) at 0x%lx, reg = 0x%x [0x%lx]\n", 
ES_REG(ensoniq, 1371_CODEC), reg, inl(ES_REG(ensoniq, 1371_CODEC)));
 				return 0;
 			}
 			goto __again;
 		}
 		spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 	}
-	snd_printk("es1371: codec read timeout at 0x%lx [0x%x]\n", ES_REG(ensoniq, 
1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
+	snd_printk("es1371: codec read timeout at 0x%lx [0x%lx]\n", ES_REG(ensoniq, 
1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
 	return 0;
 }
 
--- linux-2.5.20-dj3/drivers/ide/ide-floppy.c.orig	2002-06-04 
18:40:36.000000000 +0200
+++ linux-2.5.20-dj3/drivers/ide/ide-floppy.c	2002-06-05 20:26:00.000000000 
+0200
@@ -96,6 +96,7 @@
 #include <linux/cdrom.h>
 #include <linux/ide.h>
 #include <linux/atapi.h>
+#include <linux/buffer_head.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
--- linux-2.5.20-dj3/arch/i386/kernel/io_apic.c~	2002-06-05 
19:24:10.000000000 +0200
+++ linux-2.5.20-dj3/arch/i386/kernel/io_apic.c	2002-06-05 20:15:51.000000000 
+0200
@@ -219,6 +219,7 @@
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
 
+#if CONFIG_SMP
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned 
long now, int direction)
 {
 	int search_idle = 1;
@@ -244,6 +245,7 @@
 
 	return cpu;
 }
+#endif
 
 static inline void balance_irq(int irq)
 {
--- linux-2.5.20-dj3/sound/core/rawmidi.c.orig	2002-05-03 02:22:43.000000000 
+0200
+++ linux-2.5.20-dj3/sound/core/rawmidi.c	2002-06-05 20:08:25.000000000 +0200
@@ -143,7 +143,7 @@
 			break;
 		}
 		if (runtime->avail < runtime->buffer_size && !timeout) {
-			snd_printk(KERN_WARNING "rawmidi drain error (avail = %li, buffer_size = 
%li)\n", runtime->avail, runtime->buffer_size);
+			snd_printk(KERN_WARNING "rawmidi drain error (avail = %d, buffer_size = 
%d)\n", runtime->avail, runtime->buffer_size);
 			err = -EIO;
 			break;
 		}
