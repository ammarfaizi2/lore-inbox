Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWIUJ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWIUJ76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWIUJ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:59:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23845 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751107AbWIUJ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:59:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1niQkWKN52etWDVVNat+LtdvBhk4/xM2OGxf8npjmfqNXrGqB2oiGA5YzD7GHXzJPRfF2Sliepi4KV/io+MTAogK85LVeuOgur6lEG6vy6d8afC2MmwTF3qO7+EYCuVXcniyUeFq7yGn1k8A2T46UIs7DSfdTcRV1yNny4Ijys=
Message-ID: <489ecd0c0609210259n37a8a800m612b4114bb6a73ef@mail.gmail.com>
Date: Thu, 21 Sep 2006 17:59:56 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
In-Reply-To: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 We know this is a big one and really appreciate anyone who is
interested can review it. For any issues. We'll try to fix them ASAP.
Thank you!

On 9/21/06, Luke Yang <luke.adi@gmail.com> wrote:
> Hi everyone,
>
>   This is the blackfin architecture for 2.6.18, again. As we promised,
> we fixed some issues in our old patches as following.
>
> - use serial core in that driver
>
> - Fix up that ioctl so it a) doesn't sleep in spinlock and b) compiles
>
> - Use generic IRQ framework
>
> - Review all the volatiles, consolidate them in some helper-in-header-file.
>
>   And we also fixed a lot of other issues and ported it to 2.6.18 now.
> As usual, this architecture patch is too big so I just give a link
> here. Please review it and give you comments, we really appreciate.
>
> http://blackfin.uclinux.org/frs/download.php/1010/blackfin_arch_2.6.18.patch
>
> Signed-off-by:  Luke Yang <luke.adi@gmail.com>
>
>  arch/blackfin/Kconfig                              |  840 +++++++
>  arch/blackfin/Kconfig.ide                          |   88
>  arch/blackfin/Makefile                             |   78
>  arch/blackfin/defconfig                            | 1088 +++++++++
>  arch/blackfin/kernel/Makefile                      |   11
>  arch/blackfin/kernel/asm-offsets.c                 |  138 +
>  arch/blackfin/kernel/bfin_dma_5xx.c                |  749 ++++++
>  arch/blackfin/kernel/bfin_ksyms.c                  |  114
>  arch/blackfin/kernel/dma-mapping.c                 |  174 +
>  arch/blackfin/kernel/dualcore_test.c               |   51
>  arch/blackfin/kernel/entry.S                       |   99
>  arch/blackfin/kernel/init_task.c                   |   63
>  arch/blackfin/kernel/irqchip.c                     |  150 +
>  arch/blackfin/kernel/module.c                      |  469 +++
>  arch/blackfin/kernel/process.c                     |  346 ++
>  arch/blackfin/kernel/ptrace.c                      |  431 +++
>  arch/blackfin/kernel/setup.c                       |  941 +++++++
>  arch/blackfin/kernel/signal.c                      |  715 +++++
>  arch/blackfin/kernel/sys_bfin.c                    |  254 ++
>  arch/blackfin/kernel/time.c                        |  336 ++
>  arch/blackfin/kernel/traps.c                       |  640 +++++
>  arch/blackfin/kernel/vmlinux.lds.S                 |  225 +
>  arch/blackfin/lib/Makefile                         |    9
>  arch/blackfin/lib/ashldi3.c                        |   56
>  arch/blackfin/lib/ashrdi3.c                        |   57
>  arch/blackfin/lib/checksum.c                       |  139 +
>  arch/blackfin/lib/divsi3.S                         |  156 +
>  arch/blackfin/lib/gcclib.h                         |   49
>  arch/blackfin/lib/ins.S                            |   78
>  arch/blackfin/lib/lshrdi3.c                        |   70
>  arch/blackfin/lib/memchr.S                         |   64
>  arch/blackfin/lib/memcmp.S                         |  108
>  arch/blackfin/lib/memcpy.S                         |  128 +
>  arch/blackfin/lib/memmove.S                        |  102
>  arch/blackfin/lib/memset.S                         |  103
>  arch/blackfin/lib/modsi3.S                         |   74
>  arch/blackfin/lib/muldi3.c                         |   97
>  arch/blackfin/lib/outs.S                           |   63
>  arch/blackfin/lib/udivsi3.S                        |  157 +
>  arch/blackfin/lib/umodsi3.S                        |   63
>  arch/blackfin/mach-bf533/Kconfig                   |  103
>  arch/blackfin/mach-bf533/Makefile                  |   10
>  arch/blackfin/mach-bf533/boards/Makefile           |    8
>  arch/blackfin/mach-bf533/boards/cm_bf533.c         |  236 +
>  arch/blackfin/mach-bf533/boards/ezkit.c            |  213 +
>  arch/blackfin/mach-bf533/boards/generic_board.c    |   78
>  arch/blackfin/mach-bf533/boards/stamp.c            |  265 ++
>  arch/blackfin/mach-bf533/cpu.c                     |  169 +
>  arch/blackfin/mach-bf533/head.S                    |  767 ++++++
>  arch/blackfin/mach-bf533/ints-priority.c           |   69
>  arch/blackfin/mach-bf533/pm.c                      |  152 +
>  arch/blackfin/mach-bf537/Kconfig                   |  147 +
>  arch/blackfin/mach-bf537/Makefile                  |   10
>  arch/blackfin/mach-bf537/boards/Makefile           |    7
>  arch/blackfin/mach-bf537/boards/cm_bf537.c         |  268 ++
>  arch/blackfin/mach-bf537/boards/ezkit.c            |  213 +
>  arch/blackfin/mach-bf537/boards/generic_board.c    |  469 +++
>  arch/blackfin/mach-bf537/boards/led.S              |  183 +
>  arch/blackfin/mach-bf537/boards/stamp.c            |  489 ++++
>  arch/blackfin/mach-bf537/cpu.c                     |  169 +
>  arch/blackfin/mach-bf537/head.S                    |  584 ++++
>  arch/blackfin/mach-bf537/ints-priority.c           |   79
>  arch/blackfin/mach-bf537/pm.c                      |  150 +
>  arch/blackfin/mach-bf561/Kconfig                   |  224 +
>  arch/blackfin/mach-bf561/Makefile                  |    9
>  arch/blackfin/mach-bf561/boards/Makefile           |    6
>  arch/blackfin/mach-bf561/boards/ezkit.c            |   84
>  arch/blackfin/mach-bf561/boards/generic_board.c    |   78
>  arch/blackfin/mach-bf561/coreb.c                   |  413 +++
>  arch/blackfin/mach-bf561/head.S                    |  504 ++++
>  arch/blackfin/mach-bf561/ints-priority.c           |  113
>  arch/blackfin/mach-common/Makefile                 |   12
>  arch/blackfin/mach-common/bf5xx_rtc.c              |  140 +
>  arch/blackfin/mach-common/cache.S                  |  255 ++
>  arch/blackfin/mach-common/cacheinit.S              |  140 +
>  arch/blackfin/mach-common/cplbhdlr.S               |  128 +
>  arch/blackfin/mach-common/cplbinfo.c               |  212 +
>  arch/blackfin/mach-common/cplbmgr.S                |  623 +++++
>  arch/blackfin/mach-common/dpmc.S                   |  438 +++
>  arch/blackfin/mach-common/entry.S                  | 1169 +++++++++
>  arch/blackfin/mach-common/flush.S                  |  400 +++
>  arch/blackfin/mach-common/interrupt.S              |  255 ++
>  arch/blackfin/mach-common/ints-priority-dc.c       |  545 ++++
>  arch/blackfin/mach-common/ints-priority-sc.c       |  619 +++++
>  arch/blackfin/mach-common/irqpanic.c               |  193 +
>  arch/blackfin/mach-common/lock.S                   |  215 +
>  arch/blackfin/mm/Makefile                          |    5
>  arch/blackfin/mm/blackfin_sram.c                   |  532 ++++
>  arch/blackfin/mm/blackfin_sram.h                   |   40
>  arch/blackfin/mm/init.c                            |  222 +
>  arch/blackfin/mm/kmap.c                            |   86
>  arch/blackfin/oprofile/Kconfig                     |   29
>  arch/blackfin/oprofile/Makefile                    |   14
>  arch/blackfin/oprofile/common.c                    |  170 +
>  arch/blackfin/oprofile/op_blackfin.h               |  100
>  arch/blackfin/oprofile/op_model_bf533.c            |  168 +
>  arch/blackfin/oprofile/timer_int.c                 |   79
>  fs/Kconfig.binfmt                                  |    2
>  include/asm-blackfin/a.out.h                       |   25
>  include/asm-blackfin/atomic.h                      |  176 +
>  include/asm-blackfin/auxvec.h                      |    4
>  include/asm-blackfin/bf53x_timers.h                |  137 +
>  include/asm-blackfin/bf5xx_rtc.h                   |   19
>  include/asm-blackfin/bfin-global.h                 |  126 +
>  include/asm-blackfin/bfin5xx_spi.h                 |  170 +
>  include/asm-blackfin/bfin_spi_channel.h            |  180 +
>  include/asm-blackfin/bfin_sport.h                  |  176 +
>  include/asm-blackfin/bitops.h                      |  213 +
>  include/asm-blackfin/blackfin.h                    |   13
>  include/asm-blackfin/board/eagle.h                 |    4
>  include/asm-blackfin/board/ezkit.h                 |    4
>  include/asm-blackfin/board/hawk.h                  |    4
>  include/asm-blackfin/board/pub.h                   |   17
>  include/asm-blackfin/bug.h                         |   14
>  include/asm-blackfin/bugs.h                        |   16
>  include/asm-blackfin/byteorder.h                   |   48
>  include/asm-blackfin/cache.h                       |   18
>  include/asm-blackfin/cacheflush.h                  |  103
>  include/asm-blackfin/checksum.h                    |  101
>  include/asm-blackfin/cplb.h                        |   51
>  include/asm-blackfin/cplbtab.h                     |  572 ++++
>  include/asm-blackfin/cpumask.h                     |    6
>  include/asm-blackfin/cputime.h                     |    6
>  include/asm-blackfin/current.h                     |   23
>  include/asm-blackfin/delay.h                       |   41
>  include/asm-blackfin/div64.h                       |    1
>  include/asm-blackfin/dma-mapping.h                 |   68
>  include/asm-blackfin/dma.h                         |  212 +
>  include/asm-blackfin/dpmc.h                        |   66
>  include/asm-blackfin/elf.h                         |  127 +
>  include/asm-blackfin/emergency-restart.h           |    6
>  include/asm-blackfin/entry.h                       |  367 +++
>  include/asm-blackfin/errno.h                       |    6
>  include/asm-blackfin/fcntl.h                       |   87
>  include/asm-blackfin/flat.h                        |  128 +
>  include/asm-blackfin/futex.h                       |    6
>  include/asm-blackfin/hardirq.h                     |   41
>  include/asm-blackfin/hw_irq.h                      |    6
>  include/asm-blackfin/ide.h                         |   31
>  include/asm-blackfin/io.h                          |  155 +
>  include/asm-blackfin/ioctl.h                       |    1
>  include/asm-blackfin/ioctls.h                      |   82
>  include/asm-blackfin/ipc.h                         |   31
>  include/asm-blackfin/ipcbuf.h                      |   30
>  include/asm-blackfin/irq.h                         |   85
>  include/asm-blackfin/kmap_types.h                  |   21
>  include/asm-blackfin/l1layout.h                    |   30
>  include/asm-blackfin/linkage.h                     |    7
>  include/asm-blackfin/local.h                       |    6
>  include/asm-blackfin/mach-bf533/anomaly.h          |  172 +
>  include/asm-blackfin/mach-bf533/bf533.h            |  288 ++
>  include/asm-blackfin/mach-bf533/bfin_serial_5xx.h  |   81
>  include/asm-blackfin/mach-bf533/blackfin.h         |   48
>  include/asm-blackfin/mach-bf533/cdefBF532.h        |  691 +++++
>  include/asm-blackfin/mach-bf533/defBF532.h         | 1202 ++++++++++
>  include/asm-blackfin/mach-bf533/dma.h              |   56
>  include/asm-blackfin/mach-bf533/irq.h              |  178 +
>  include/asm-blackfin/mach-bf533/mem_init.h         |  314 ++
>  include/asm-blackfin/mach-bf533/mem_map.h          |  135 +
>  include/asm-blackfin/mach-bf535/bf535.h            | 1285 ++++++++++
>  include/asm-blackfin/mach-bf535/bf535_serial.h     |  109
>  include/asm-blackfin/mach-bf535/blackfin.h         |   44
>  include/asm-blackfin/mach-bf535/cdefBF535.h        |  121 +
>  include/asm-blackfin/mach-bf535/cdefblackfin.h     |   69
>  include/asm-blackfin/mach-bf535/defBF535.h         | 1154 +++++++++
>  include/asm-blackfin/mach-bf535/defblackfin.h      |  444 +++
>  include/asm-blackfin/mach-bf535/irq.h              |  125 +
>  include/asm-blackfin/mach-bf537/anomaly.h          |  118
>  include/asm-blackfin/mach-bf537/bf537.h            |  268 ++
>  include/asm-blackfin/mach-bf537/bfin_serial_5xx.h  |  101
>  include/asm-blackfin/mach-bf537/blackfin.h         |  440 +++
>  include/asm-blackfin/mach-bf537/cdefBF534.h        | 1805 +++++++++++++++
>  include/asm-blackfin/mach-bf537/cdefBF537.h        |  209 +
>  include/asm-blackfin/mach-bf537/defBF534.h         | 2520 +++++++++++++++++++++
>  include/asm-blackfin/mach-bf537/defBF537.h         |  404 +++
>  include/asm-blackfin/mach-bf537/dma.h              |   55
>  include/asm-blackfin/mach-bf537/irq.h              |  185 +
>  include/asm-blackfin/mach-bf537/mem_init.h         |  328 ++
>  include/asm-blackfin/mach-bf537/mem_map.h          |  143 +
>  include/asm-blackfin/mach-bf561/anomaly.h          |  182 +
>  include/asm-blackfin/mach-bf561/bf561.h            |  378 +++
>  include/asm-blackfin/mach-bf561/blackfin.h         |   54
>  include/asm-blackfin/mach-bf561/cdefBF561.h        | 1528 ++++++++++++
>  include/asm-blackfin/mach-bf561/defBF561.h         | 1713 ++++++++++++++
>  include/asm-blackfin/mach-bf561/dma.h              |   36
>  include/asm-blackfin/mach-bf561/irq.h              |  451 +++
>  include/asm-blackfin/mach-bf561/mem_init.h         |  283 ++
>  include/asm-blackfin/mach-bf561/mem_map.h          |   61
>  include/asm-blackfin/mach-common/cdef_LPBlackfin.h |  474 +++
>  include/asm-blackfin/mach-common/def_LPBlackfin.h  |  706 +++++
>  include/asm-blackfin/macros.h                      |   95
>  include/asm-blackfin/mem_map.h                     |   12
>  include/asm-blackfin/mman.h                        |   45
>  include/asm-blackfin/mmu.h                         |   30
>  include/asm-blackfin/mmu_context.h                 |  130 +
>  include/asm-blackfin/module.h                      |   19
>  include/asm-blackfin/msgbuf.h                      |   31
>  include/asm-blackfin/mutex.h                       |    9
>  include/asm-blackfin/namei.h                       |   19
>  include/asm-blackfin/page.h                        |   89
>  include/asm-blackfin/page_offset.h                 |    6
>  include/asm-blackfin/param.h                       |   22
>  include/asm-blackfin/pci.h                         |  148 +
>  include/asm-blackfin/percpu.h                      |    6
>  include/asm-blackfin/pgalloc.h                     |    8
>  include/asm-blackfin/pgtable.h                     |   62
>  include/asm-blackfin/poll.h                        |   24
>  include/asm-blackfin/posix_types.h                 |   65
>  include/asm-blackfin/processor.h                   |  104
>  include/asm-blackfin/ptrace.h                      |  102
>  include/asm-blackfin/resource.h                    |    6
>  include/asm-blackfin/scatterlist.h                 |   26
>  include/asm-blackfin/sections.h                    |    7
>  include/asm-blackfin/segment.h                     |    7
>  include/asm-blackfin/semaphore-helper.h            |   82
>  include/asm-blackfin/semaphore.h                   |  106
>  include/asm-blackfin/sembuf.h                      |   25
>  include/asm-blackfin/setup.h                       |   17
>  include/asm-blackfin/shmbuf.h                      |   42
>  include/asm-blackfin/shmparam.h                    |    6
>  include/asm-blackfin/sigcontext.h                  |   50
>  include/asm-blackfin/siginfo.h                     |   35
>  include/asm-blackfin/signal.h                      |  159 +
>  include/asm-blackfin/socket.h                      |   53
>  include/asm-blackfin/sockios.h                     |   12
>  include/asm-blackfin/spinlock.h                    |    6
>  include/asm-blackfin/stat.h                        |   77
>  include/asm-blackfin/statfs.h                      |    6
>  include/asm-blackfin/string.h                      |   97
>  include/asm-blackfin/system.h                      |  212 +
>  include/asm-blackfin/termbits.h                    |  173 +
>  include/asm-blackfin/termios.h                     |  106
>  include/asm-blackfin/thread_info.h                 |  142 +
>  include/asm-blackfin/timex.h                       |   18
>  include/asm-blackfin/tlb.h                         |   16
>  include/asm-blackfin/tlbflush.h                    |   62
>  include/asm-blackfin/topology.h                    |    6
>  include/asm-blackfin/traps.h                       |   75
>  include/asm-blackfin/types.h                       |   66
>  include/asm-blackfin/uaccess.h                     |  260 ++
>  include/asm-blackfin/ucontext.h                    |   30
>  include/asm-blackfin/unaligned.h                   |    6
>  include/asm-blackfin/unistd.h                      |  545 ++++
>  include/asm-blackfin/user.h                        |   91
>  include/linux/elf-em.h                             |    1
>  include/linux/usb_sl811.h                          |   26
>  init/Kconfig                                       |    3
>  init/Kconfig.orig                                  |  516 ++++
>  lib/Kconfig.debug                                  |    4
>  scripts/genksyms/genksyms.c                        |    3
>  scripts/mod/mk_elfconfig.c                         |    3
>  251 files changed, 49661 insertions(+), 6 deletions(-)
>
> http://blackfin.uclinux.org/frs/download.php/1010/blackfin_arch_2.6.18.patch
>    (same as above link)
> --
> Best regards,
> Luke Yang
> luke.adi@gmail.com
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com
