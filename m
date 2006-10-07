Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWJGJAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWJGJAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 05:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWJGJAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 05:00:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31061 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750710AbWJGJAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 05:00:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bPxsaFzb0W4QZ8WD/4Sx6XzhvvtmVX5mvQRPztENYbKhyPnPLO5PBq2ua5V50+jQa88MFACSy7vdzCw7ZYzFUDgb+nVTCOfgAFta1byxINX0ZxkFjj7pvL6vXpbBnQxTY/z2KbVm/wB3Awgjn7nZkDGAihnuSTBRZByJo4ep+Aw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 25 random kernel configs, 24 build failures - 2.6.19-rc1-git2
Date: Sat, 7 Oct 2006 11:02:04 +0200
User-Agent: KMail/1.9.4
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       James Bottomley <James.Bottomley@hansenpartnership.com>,
       Andrey Panin <pazke@donpac.ru>, Krzysztof Halasa <khc@pm.waw.pl>,
       Ingo Molnar <mingo@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610071102.05384.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Apologies for the long Cc: list, but I wanted to try and include all relevant people)


It seems we have a lot of build issues in the pile of patches that is 2.6.19-rc1-git2 .

I build 25 "make randconfig" kernel configs, ensured none of them had 
CONFIG_EXPERIMENTAL set, tried to build the kernels, and saw warnings galore
and only a single kernel actually build.  :-(

In addition to the samples below (which I believe is one copy of each unique 
failure), I've put the configs I generated along with logs of each build up at : 
 ftp://ftp.kernel.org/pub/linux/kernel/people/juhl/2.6.19-rc1-git2_build-logs/
Have fun!

Here's what I used to build with : 


$ uname -a
Linux dragon 2.6.19-rc1-git2 #1 SMP PREEMPT Sat Oct 7 00:30:45 CEST 2006 i686 athlon-4 i386 GNU/Linux

$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.19-rc1-git2 #1 SMP PREEMPT Sat Oct 7 00:30:45 CEST 2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
quota-tools            3.13.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss agpgart evdev snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd


And here are the errors :


arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types for 'voyager_timer_interrupt'
include/asm/voyager.h:508: error: previous declaration of 'voyager_timer_interrupt' was here
arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types for 'voyager_timer_interrupt'
include/asm/voyager.h:508: error: previous declaration of 'voyager_timer_interrupt' was here
make[1]: *** [arch/i386/mach-voyager/voyager_basic.o] Error 1
make: *** [arch/i386/mach-voyager] Error 2
make: *** Waiting for unfinished jobs....
  CC      arch/i386/kernel/time.o
In file included from arch/i386/kernel/time.c:74:
include/asm-i386/mach-voyager/do_timer.h: In function `do_timer_interrupt_hook':
include/asm-i386/mach-voyager/do_timer.h:8: error: `irq_regs' undeclared (first use in this function)
include/asm-i386/mach-voyager/do_timer.h:8: error: (Each undeclared identifier is reported only once
include/asm-i386/mach-voyager/do_timer.h:8: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/time.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  CC      arch/i386/mm/ioremap.o
make: *** [arch/i386/kernel] Error 2

====================

arch/i386/kernel/built-in.o(.text+0xd2c3): In function `map_cpu_to_logical_apicid':
: undefined reference to `apicid_to_node'
arch/i386/mach-visws/built-in.o(.data+0xe4): undefined reference to `startup_8259A_irq'
drivers/built-in.o(.text+0x3070c): In function `hdlcdev_open':
: undefined reference to `hdlc_open'
drivers/built-in.o(.text+0x30736): In function `hdlcdev_open':
: undefined reference to `hdlc_open'
drivers/built-in.o(.text+0x30865): In function `hdlcdev_close':
: undefined reference to `hdlc_close'
drivers/built-in.o(.text+0x308f0): In function `hdlcdev_ioctl':
: undefined reference to `hdlc_ioctl'
drivers/built-in.o(.text+0x30d1b): In function `hdlcdev_init':
: undefined reference to `alloc_hdlcdev'
drivers/built-in.o(.text+0x30dff): In function `hdlcdev_exit':
: undefined reference to `unregister_hdlc_device'
drivers/built-in.o(.text+0x32a6c): In function `hdlcdev_open':
: undefined reference to `hdlc_open'
drivers/built-in.o(.text+0x32a96): In function `hdlcdev_open':
: undefined reference to `hdlc_open'
drivers/built-in.o(.text+0x32bc5): In function `hdlcdev_close':
: undefined reference to `hdlc_close'
drivers/built-in.o(.text+0x32c50): In function `hdlcdev_ioctl':
: undefined reference to `hdlc_ioctl'
drivers/built-in.o(.text+0x3307b): In function `hdlcdev_init':
: undefined reference to `alloc_hdlcdev'
drivers/built-in.o(.text+0x3315f): In function `hdlcdev_exit':
: undefined reference to `unregister_hdlc_device'
drivers/built-in.o(.text+0x3ad2c): In function `hdlcdev_open':
: undefined reference to `hdlc_open'
drivers/built-in.o(.text+0x3ad50): In function `hdlcdev_open':
: undefined reference to `hdlc_open'
drivers/built-in.o(.text+0x3ae85): In function `hdlcdev_close':
: undefined reference to `hdlc_close'
drivers/built-in.o(.text+0x3af10): In function `hdlcdev_ioctl':
: undefined reference to `hdlc_ioctl'
drivers/built-in.o(.text+0x3b34b): In function `hdlcdev_init':
: undefined reference to `alloc_hdlcdev'
drivers/built-in.o(.text+0x3b42f): In function `hdlcdev_exit':
: undefined reference to `unregister_hdlc_device'
make: *** [.tmp_vmlinux1] Error 1

====================

In file included from arch/i386/kernel/time.c:74:
include/asm-i386/mach-visws/do_timer.h: In function `do_timer_interrupt_hook':
include/asm-i386/mach-visws/do_timer.h:14: error: `irq_regs' undeclared (first use in this function)
include/asm-i386/mach-visws/do_timer.h:14: error: (Each undeclared identifier is reported only once
include/asm-i386/mach-visws/do_timer.h:14: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/time.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  CC      arch/i386/mm/pageattr.o
  CC      arch/i386/mm/mmap.o
make: *** [arch/i386/kernel] Error 2

====================

kernel/sched.c: In function `domain_distance':
kernel/sched.c:5673: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2

====================

arch/i386/kernel/built-in.o(.text+0xdd0d): In function `target_ht_irq':
: undefined reference to `read_ht_irq_low'
arch/i386/kernel/built-in.o(.text+0xdd15): In function `target_ht_irq':
: undefined reference to `read_ht_irq_high'
arch/i386/kernel/built-in.o(.text+0xdd35): In function `target_ht_irq':
: undefined reference to `write_ht_irq_low'
arch/i386/kernel/built-in.o(.text+0xde1e): In function `arch_setup_ht_irq':
: undefined reference to `write_ht_irq_low'
arch/i386/kernel/built-in.o(.text+0xde25): In function `arch_setup_ht_irq':
: undefined reference to `write_ht_irq_high'
arch/i386/kernel/built-in.o(.text+0xdd48): In function `target_ht_irq':
: undefined reference to `write_ht_irq_high'
arch/i386/kernel/built-in.o(.data+0x1798): In function `trampoline_end':
: undefined reference to `mask_ht_irq'
arch/i386/kernel/built-in.o(.data+0x17a0): In function `trampoline_end':
: undefined reference to `unmask_ht_irq'
make: *** [.tmp_vmlinux1] Error 1

====================

drivers/ata/libata-scsi.c: In function `ata_scsi_dev_config':
drivers/ata/libata-scsi.c:791: warning: implicit declaration of function `blk_queue_max_sect
ors'
drivers/ata/libata-scsi.c:799: error: `request_queue_t' undeclared (first use in this functi
on)
drivers/ata/libata-scsi.c:799: error: (Each undeclared identifier is reported only once
drivers/ata/libata-scsi.c:799: error: for each function it appears in.)
drivers/ata/libata-scsi.c:799: error: `q' undeclared (first use in this function)
drivers/ata/libata-scsi.c:800: warning: implicit declaration of function `blk_queue_max_hw_segments'
drivers/ata/libata-scsi.c: In function `ata_scsi_slave_config':
  CC [M]  crypto/blkcipher.o
: warning: implicit declaration of function `blk_queue_max_phys_segments'
make[2]: *** [drivers/ata/libata-scsi.o] Error 1
make[1]: *** [drivers/ata] Error 2
make: *** [drivers] Error 2

====================

drivers/mtd/mtd_blkdevs.c:40: warning: "struct request" declared inside parameter list
drivers/mtd/mtd_blkdevs.c:40: warning: its scope is only this definition or declaration, whi
ch is probably not what you want
drivers/mtd/mtd_blkdevs.c: In function `do_blktrans_request':
drivers/mtd/mtd_blkdevs.c:45: error: dereferencing pointer to incomplete type
  CC      drivers/parport/ieee1284_ops.o
ferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:47: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:49: warning: implicit declaration of function `blk_fs_request'
drivers/mtd/mtd_blkdevs.c:52: warning: implicit declaration of function `get_capacity'
drivers/mtd/mtd_blkdevs.c:52: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:55: warning: implicit declaration of function `rq_data_dir'
drivers/mtd/mtd_blkdevs.c: In function `mtd_blktrans_thread':
drivers/mtd/mtd_blkdevs.c:96: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:104: warning: implicit declaration of function `elv_next_request'
drivers/mtd/mtd_blkdevs.c:104: warning: assignment makes pointer from integer without a cast
drivers/mtd/mtd_blkdevs.c:110: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:115: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:120: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:123: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:126: warning: passing arg 3 of `do_blktrans_request' from incompatible pointer type
drivers/mtd/mtd_blkdevs.c:129: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:131: warning: implicit declaration of function `end_request'
drivers/mtd/mtd_blkdevs.c:133: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c: In function `mtd_blktrans_request':
drivers/mtd/mtd_blkdevs.c:140: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c: In function `blktrans_open':
drivers/mtd/mtd_blkdevs.c:151: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c: In function `blktrans_release':
drivers/mtd/mtd_blkdevs.c:182: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c: In function `blktrans_getgeo':
drivers/mtd/mtd_blkdevs.c:199: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c: In function `blktrans_ioctl':
drivers/mtd/mtd_blkdevs.c:209: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c: In function `add_mtd_blktrans_dev':
drivers/mtd/mtd_blkdevs.c:276: warning: implicit declaration of function `alloc_disk'
drivers/mtd/mtd_blkdevs.c:276: warning: assignment makes pointer from integer without a cast
drivers/mtd/mtd_blkdevs.c:281: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:282: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:283: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:287: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:287: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:290: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:290: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:295: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:295: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:300: warning: implicit declaration of function `set_capacity'
drivers/mtd/mtd_blkdevs.c:302: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:304: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:307: warning: implicit declaration of function `set_disk_ro'
drivers/mtd/mtd_blkdevs.c:309: warning: implicit declaration of function `add_disk'
drivers/mtd/mtd_blkdevs.c: In function `del_mtd_blktrans_dev':
drivers/mtd/mtd_blkdevs.c:323: warning: implicit declaration of function `del_gendisk'
drivers/mtd/mtd_blkdevs.c:324: warning: implicit declaration of function `put_disk'
drivers/mtd/mtd_blkdevs.c: In function `register_mtd_blktrans':
drivers/mtd/mtd_blkdevs.c:383: warning: implicit declaration of function `register_blkdev'
drivers/mtd/mtd_blkdevs.c:395: warning: implicit declaration of function `blk_init_queue'
drivers/mtd/mtd_blkdevs.c:395: warning: assignment makes pointer from integer without a cast
drivers/mtd/mtd_blkdevs.c:397: warning: implicit declaration of function `unregister_blkdev'
drivers/mtd/mtd_blkdevs.c:403: error: dereferencing pointer to incomplete type
drivers/mtd/mtd_blkdevs.c:407: warning: implicit declaration of function `blk_cleanup_queue'
  CC      lib/hweight.o
make[2]: *** [drivers/mtd/mtd_blkdevs.o] Error 1
make[1]: *** [drivers/mtd] Error 2
make[1]: *** Waiting for unfinished jobs....
  CC      drivers/parport/procfs.o
  CC      lib/idr.o
  CC      lib/int_sqrt.o
  LD      drivers/parport/parport.o
  LD      drivers/parport/built-in.o
make: *** [drivers] Error 2

====================

arch/i386/mach-voyager/voyager_basic.c:54: warning: initialization from incompatible pointer type
arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types for 'voyager_timer_interrupt'
include/asm/voyager.h:508: error: previous declaration of 'voyager_timer_interrupt' was here
arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types for 'voyager_timer_interrupt'
include/asm/voyager.h:508: error: previous declaration of 'voyager_timer_interrupt' was here
make[1]: *** [arch/i386/mach-voyager/voyager_basic.o] Error 1
make: *** [arch/i386/mach-voyager] Error 2

====================

aicasm_gram.y:1948: error: conflicting types for 'yyerror'
aicasm_gram.tab.c:3161: error: previous implicit declaration of 'yyerror' was here
aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
  CC      lib/ctype.o
  CC      drivers/video/fbmon.o
  CC      lib/dec_and_lock.o
make[4]: *** [aicasm] Error 1
make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2

====================

arch/i386/mach-generic/built-in.o(.text+0x333): In function `apicid_to_node':
: undefined reference to `apicid_2_node'
arch/i386/kernel/built-in.o(.text+0xd0b8): In function `arch_setup_ht_irq':
: undefined reference to `write_ht_irq_low'
arch/i386/kernel/built-in.o(.text+0xd0c1): In function `arch_setup_ht_irq':
: undefined reference to `write_ht_irq_high'
arch/i386/kernel/built-in.o(.data+0x13d8): In function `k7nops':
: undefined reference to `mask_ht_irq'
arch/i386/kernel/built-in.o(.data+0x13e0): In function `k7nops':
: undefined reference to `unmask_ht_irq'
make: *** [vmlinux] Error 1



Kind regards,

  Jesper Juhl <jesper.juhl@gmail.com>


