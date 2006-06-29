Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWF2P00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWF2P00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWF2P00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:26:26 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:41782 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWF2P0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:26:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qWq88QLbJ4QvxZUSTIIheUkKfrzQYO5f5y6howd5F4lUdc8Cs+JK4E9lhKVTC5FH80/E9KqxCCEjQ4NhfC4NmfzlF4fFI0+i939z8nkeQ8yA6bxhpEH9QGPcEHFNaalWze29g9MdlPEr7l3gNk6SRujA+aBpdLBVdgS7vhw5Iy4=
Message-ID: <1defaf580606290826s39ea9330j62385d767a63ed74@mail.gmail.com>
Date: Thu, 29 Jun 2006 17:26:22 +0200
From: "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: AVR32 architecture support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

As some of you probably know, Atmel released a new 32-bit
microprocessor architecture called AVR32 earlier this year. The first
chip implementing this architecture, AT32AP7000, and a development
board, AT32STK1000 have also been released.

The BSP for AT32STK1000 includes a Linux 2.6.16 kernel with a set of
patches adding support for AVR32, AT32AP7000 and the most important
drivers. I've rebased a subset of that patchset against a fresh git
snapshot (taken earlier today) and uploaded them to

http://avr32linux.org/twiki/bin/view/Main/LinuxPatches

so you can have a look at them if you're curious. Comments are very welcome.

I didn't attach any of the patches since the main avr32-architecture
patch is quite large (520K), and the other patches make little sense
without it. I've included the diffstat of the entire patchset below.

I've already received some feedback, so the latest patchset is
significantly different from the one included with the BSP. Most
importantly, I've implemented the clock management API in
<linux/clk.h>, so if anyone have looked at the BSP patches and become
suspicious about the at32_device thing included there, I can assure
you that it's going away.

The BSP patchset also includes a serial driver which was written from
scratch long before the at91_serial driver was merged into the 2.6
kernel. I've managed to boot Linux on AVR32 using the at91_serial
driver with only a few changes, so I'm planning to rip my existing
usart driver into pieces and submit it as improvements to the
at91_serial driver. The changes I had to make is in a separate patch
on the page mentioned above.

There's a status page for the AVR32 port at

http://avr32linux.org/twiki/bin/view/Main/LinuxKernel

which I will try to keep updated with known issues and missing
features in the core patches and the drivers. Or you can add stuff
yourself (it's a wiki, after all.)

Well, since this is my first announcement to linux-kernel, I've
probably failed to mention lots of important things. Please don't
hesitate to ask.

Håvard

 arch/avr32/Kconfig                               |  185 ++++
 arch/avr32/Kconfig.debug                         |   38 +
 arch/avr32/Makefile                              |   82 ++
 arch/avr32/boards/at32stk1000/Makefile           |    2
 arch/avr32/boards/at32stk1000/at32stk1002.c      |   31 +
 arch/avr32/boards/at32stk1000/setup.c            |   70 +
 arch/avr32/boards/at32stk1000/spi.c              |   28 +
 arch/avr32/boot/images/Makefile                  |   62 +
 arch/avr32/boot/u-boot/Makefile                  |    3
 arch/avr32/boot/u-boot/empty.S                   |    1
 arch/avr32/boot/u-boot/head.S                    |   60 +
 arch/avr32/kernel/Makefile                       |   19
 arch/avr32/kernel/asm-offsets.c                  |   25
 arch/avr32/kernel/avr32_ksyms.c                  |   53 +
 arch/avr32/kernel/cpu.c                          |  328 ++++++
 arch/avr32/kernel/dma-controller.c               |   34 +
 arch/avr32/kernel/entry-avr32b.S                 |  741 ++++++++++++++
 arch/avr32/kernel/head.S                         |   46 +
 arch/avr32/kernel/init_task.c                    |   38 +
 arch/avr32/kernel/irq.c                          |  420 ++++++++
 arch/avr32/kernel/kprobes.c                      |  275 +++++
 arch/avr32/kernel/module.c                       |  325 ++++++
 arch/avr32/kernel/process.c                      |  272 +++++
 arch/avr32/kernel/ptrace.c                       |  371 +++++++
 arch/avr32/kernel/semaphore.c                    |  148 +++
 arch/avr32/kernel/setup.c                        |  348 +++++++
 arch/avr32/kernel/signal.c                       |  329 ++++++
 arch/avr32/kernel/switch_to.S                    |   35 +
 arch/avr32/kernel/sys_avr32.c                    |   51 +
 arch/avr32/kernel/syscall-stubs.S                |   84 ++
 arch/avr32/kernel/syscall_table.S                |  251 +++++
 arch/avr32/kernel/time.c                         |  338 ++++++
 arch/avr32/kernel/traps.c                        |  425 ++++++++
 arch/avr32/kernel/vmlinux.lds.c                  |  140 +++
 arch/avr32/lib/Makefile                          |   11
 arch/avr32/lib/__avr32_asr64.S                   |   31 +
 arch/avr32/lib/__avr32_lsl64.S                   |   31 +
 arch/avr32/lib/__avr32_lsr64.S                   |   31 +
 arch/avr32/lib/__udivdi3.c                       |  229 ++++
 arch/avr32/lib/clear_user.S                      |   76 +
 arch/avr32/lib/copy_user.S                       |  119 ++
 arch/avr32/lib/csum_partial.S                    |   47 +
 arch/avr32/lib/csum_partial_copy_generic.S       |   99 ++
 arch/avr32/lib/delay.c                           |   53 +
 arch/avr32/lib/findbit.S                         |  154 +++
 arch/avr32/lib/io-readsl.S                       |   24
 arch/avr32/lib/io-readsw.S                       |   43 +
 arch/avr32/lib/io-writesl.S                      |   20
 arch/avr32/lib/io-writesw.S                      |   38 +
 arch/avr32/lib/libgcc.h                          |   33 +
 arch/avr32/lib/longlong.h                        |   98 ++
 arch/avr32/lib/memcpy.S                          |   62 +
 arch/avr32/lib/memset.S                          |   72 +
 arch/avr32/lib/strncpy_from_user.S               |   60 +
 arch/avr32/lib/strnlen_user.S                    |   67 +
 arch/avr32/mach-at32ap/Makefile                  |    3
 arch/avr32/mach-at32ap/at32ap.c                  |   60 +
 arch/avr32/mach-at32ap/at32ap7000.c              |  668 +++++++++++++
 arch/avr32/mach-at32ap/clock.c                   |   95 ++
 arch/avr32/mach-at32ap/clock.h                   |   27 +
 arch/avr32/mach-at32ap/early_printk.c            |  132 +++
 arch/avr32/mach-at32ap/intc.c                    |   68 +
 arch/avr32/mach-at32ap/intc.h                    |  327 ++++++
 arch/avr32/mach-at32ap/pio.c                     |  114 ++
 arch/avr32/mach-at32ap/pio.h                     |  178 +++
 arch/avr32/mach-at32ap/sm.c                      |  288 +++++
 arch/avr32/mach-at32ap/sm.h                      |  240 +++++
 arch/avr32/mm/Makefile                           |    7
 arch/avr32/mm/cache.c                            |  150 +++
 arch/avr32/mm/clear_page.S                       |   25
 arch/avr32/mm/copy_page.S                        |   28 +
 arch/avr32/mm/discontig.c                        |   27 +
 arch/avr32/mm/dma-coherent.c                     |  140 +++
 arch/avr32/mm/fault.c                            |  280 +++++
 arch/avr32/mm/init.c                             |  502 ++++++++++
 arch/avr32/mm/ioremap.c                          |  197 ++++
 arch/avr32/mm/tlb.c                              |  378 +++++++
 drivers/char/mem.c                               |    8
 drivers/net/Kconfig                              |   11
 drivers/net/Makefile                             |    2
 drivers/net/macb.c                               | 1161 ++++++++++++++++++++++
 drivers/net/macb.h                               |  228 ++++
 drivers/serial/Kconfig                           |    2
 drivers/serial/at91_serial.c                     |   30 -
 include/asm-avr32/a.out.h                        |   26
 include/asm-avr32/addrspace.h                    |   43 +
 include/asm-avr32/arch-at32ap/at91rm9200_pdc.h   |   36 +
 include/asm-avr32/arch-at32ap/at91rm9200_usart.h |  123 ++
 include/asm-avr32/arch-at32ap/board.h            |   23
 include/asm-avr32/arch-at32ap/init.h             |   22
 include/asm-avr32/arch-at32ap/portmux.h          |   16
 include/asm-avr32/arch-at32ap/sm.h               |   28 +
 include/asm-avr32/asm.h                          |  103 ++
 include/asm-avr32/atomic.h                       |  205 ++++
 include/asm-avr32/auxvec.h                       |    4
 include/asm-avr32/bitops.h                       |  299 ++++++
 include/asm-avr32/bug.h                          |   49 +
 include/asm-avr32/bugs.h                         |   15
 include/asm-avr32/byteorder.h                    |   25
 include/asm-avr32/cache.h                        |   29 +
 include/asm-avr32/cachectl.h                     |   11
 include/asm-avr32/cacheflush.h                   |  129 ++
 include/asm-avr32/checksum.h                     |  156 +++
 include/asm-avr32/cputime.h                      |    6
 include/asm-avr32/current.h                      |   15
 include/asm-avr32/delay.h                        |   26
 include/asm-avr32/div64.h                        |    6
 include/asm-avr32/dma-controller.h               |  165 +++
 include/asm-avr32/dma-mapping.h                  |  324 ++++++
 include/asm-avr32/dma.h                          |    8
 include/asm-avr32/elf.h                          |  110 ++
 include/asm-avr32/emergency-restart.h            |    6
 include/asm-avr32/errno.h                        |    6
 include/asm-avr32/fcntl.h                        |    6
 include/asm-avr32/hardirq.h                      |   33 +
 include/asm-avr32/hw_irq.h                       |    9
 include/asm-avr32/intc.h                         |  129 ++
 include/asm-avr32/io.h                           |  246 +++++
 include/asm-avr32/ioctl.h                        |    6
 include/asm-avr32/ioctls.h                       |   83 ++
 include/asm-avr32/ipcbuf.h                       |   29 +
 include/asm-avr32/irq.h                          |   44 +
 include/asm-avr32/kdebug.h                       |   35 +
 include/asm-avr32/kmap_types.h                   |   32 +
 include/asm-avr32/kprobes.h                      |   36 +
 include/asm-avr32/linkage.h                      |    7
 include/asm-avr32/local.h                        |    6
 include/asm-avr32/mach/serial_at91.h             |   33 +
 include/asm-avr32/mman.h                         |   17
 include/asm-avr32/mmu.h                          |   12
 include/asm-avr32/mmu_context.h                  |  152 +++
 include/asm-avr32/mmzone.h                       |   30 +
 include/asm-avr32/module.h                       |   28 +
 include/asm-avr32/msgbuf.h                       |   31 +
 include/asm-avr32/mutex.h                        |    9
 include/asm-avr32/namei.h                        |    7
 include/asm-avr32/numnodes.h                     |    7
 include/asm-avr32/ocd.h                          |   77 +
 include/asm-avr32/page.h                         |  113 ++
 include/asm-avr32/param.h                        |   24
 include/asm-avr32/pci.h                          |    8
 include/asm-avr32/percpu.h                       |    6
 include/asm-avr32/periph/hebi.h                  |  316 ++++++
 include/asm-avr32/periph/hmatrix2.h              |  372 +++++++
 include/asm-avr32/periph/intc.h                  |  327 ++++++
 include/asm-avr32/pgalloc.h                      |   96 ++
 include/asm-avr32/pgtable-2level.h               |   47 +
 include/asm-avr32/pgtable.h                      |  409 ++++++++
 include/asm-avr32/platform.h                     |   43 +
 include/asm-avr32/poll.h                         |   27 +
 include/asm-avr32/posix_types.h                  |  129 ++
 include/asm-avr32/processor.h                    |  147 +++
 include/asm-avr32/ptrace.h                       |  156 +++
 include/asm-avr32/resource.h                     |    6
 include/asm-avr32/scatterlist.h                  |   21
 include/asm-avr32/sections.h                     |    6
 include/asm-avr32/semaphore.h                    |  112 ++
 include/asm-avr32/sembuf.h                       |   25
 include/asm-avr32/setup.h                        |  142 +++
 include/asm-avr32/shmbuf.h                       |   42 +
 include/asm-avr32/shmparam.h                     |    6
 include/asm-avr32/sigcontext.h                   |   34 +
 include/asm-avr32/siginfo.h                      |    6
 include/asm-avr32/signal.h                       |  180 +++
 include/asm-avr32/socket.h                       |   52 +
 include/asm-avr32/sockios.h                      |   12
 include/asm-avr32/stat.h                         |   79 +
 include/asm-avr32/statfs.h                       |    6
 include/asm-avr32/string.h                       |   17
 include/asm-avr32/sysreg.h                       |  327 ++++++
 include/asm-avr32/system.h                       |  186 ++++
 include/asm-avr32/termbits.h                     |  173 +++
 include/asm-avr32/termios.h                      |   80 ++
 include/asm-avr32/thread_info.h                  |  112 ++
 include/asm-avr32/timex.h                        |   30 +
 include/asm-avr32/tlb.h                          |   32 +
 include/asm-avr32/tlbflush.h                     |   40 +
 include/asm-avr32/topology.h                     |    6
 include/asm-avr32/traps.h                        |   23
 include/asm-avr32/types.h                        |   70 +
 include/asm-avr32/uaccess.h                      |  335 ++++++
 include/asm-avr32/ucontext.h                     |   12
 include/asm-avr32/unaligned.h                    |   25
 include/asm-avr32/unistd.h                       |  460 +++++++++
 include/asm-avr32/user.h                         |   66 +
 include/linux/elf-em.h                           |    1
 kernel/softirq.c                                 |   10
 lib/Kconfig.debug                                |    4
 188 files changed, 20486 insertions(+), 22 deletions(-)
