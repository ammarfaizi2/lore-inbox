Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282288AbRKWXgZ>; Fri, 23 Nov 2001 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282287AbRKWXgQ>; Fri, 23 Nov 2001 18:36:16 -0500
Received: from ns0.ipal.net ([206.97.148.120]:29614 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S282288AbRKWXgD>;
	Fri, 23 Nov 2001 18:36:03 -0500
Date: Fri, 23 Nov 2001 17:36:02 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15: undefined reference to `show_trace_task'
Message-ID: <20011123173602.A14759@vega.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling 2.4.15 for sparc (32-bit) platform I encounted:

=============================================================================
ld -m elf32_sparc -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/sparc/kernel/kernel.o arch/sparc/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/sparc/math-emu/math-emu.o arch/sparc/boot/btfix.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sbus/sbus_all.o drivers/video/video.o \
        net/network.o \
        /home/root/kernel-2.4.15/linux/lib/lib.a /home/root/kernel-2.4.15/linux/lib/lib.a /home/root/kernel-2.4.15/linux/arch/sparc/prom/promlib.a /home/root/kernel-2.4.15/linux/arch/sparc/lib/lib.a \
        --end-group \
        -o vmlinux
kernel/kernel.o: In function `show_task':
kernel/kernel.o(.text+0x16a4): undefined reference to `show_trace_task'
make: *** [vmlinux] Error 1
=============================================================================

I scanned all source files for "show_trace_task" and found:

=============================================================================
arch/alpha/kernel/traps.c:132:void show_trace_task(struct task_struct * tsk)
arch/arm/kernel/traps.c:154:void show_trace_task(struct task_struct *tsk)
arch/i386/kernel/traps.c:156:void show_trace_task(struct task_struct *tsk)
arch/sparc64/kernel/traps.c:1406:void show_trace_task(struct task_struct *tsk)
kernel/sched.c:1160:            extern void show_trace_task(struct task_struct *tsk);
kernel/sched.c:1161:            show_trace_task(p);
=============================================================================

It looks like this didn't get implement across all platforms.

Can the call to show_trace_task() in kernel/sched.c be safely commented
out for now?

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------



-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
