Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUJVSUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUJVSUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUJVSTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:19:49 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:19107 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266749AbUJVSOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:14:42 -0400
Date: Fri, 22 Oct 2004 11:14:40 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH BK][ARM] Various ARM updates for 2.6.9
Message-ID: <20041022181440.GA31624@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus

Please do a

	bk pull bk://dsaxena.bkbits.net/linux-2.6-for-rmk

This pull contains a set of ARM updates that have been pending in my
tree but Russell has not had a chance to pull them.  They have been 
tested by various folks and Russell has OK'd for me to push them 
directly to you.

This will update the following files:

 Documentation/arm/IXP2000                     |   10 
 Documentation/arm/IXP4xx                      |   11 
 arch/arm/kernel/entry-armv.S                  |  997 --------------------------
 arch/arm/kernel/entry-header.S                |    2 
 arch/arm/mach-ixp2000/core.c                  |  104 --
 arch/arm/mach-ixp2000/ixdp2x00.c              |    6 
 arch/arm/mach-ixp2000/ixdp2x01.c              |   35 
 arch/arm/mach-ixp2000/pci.c                   |    8 
 arch/arm/mach-ixp4xx/Kconfig                  |    7 
 arch/arm/mach-ixp4xx/Makefile                 |    1 
 arch/arm/mach-ixp4xx/common-pci.c             |   30 
 arch/arm/mach-ixp4xx/common.c                 |    5 
 arch/arm/mach-ixp4xx/coyote-setup.c           |   35 
 arch/arm/mach-ixp4xx/ixdpg425-pci.c           |   65 +
 arch/arm/mm/mm-armv.c                         |   25 
 include/asm-arm/arch-cl7500/entry-macro.S     |    3 
 include/asm-arm/arch-clps711x/entry-macro.S   |   51 +
 include/asm-arm/arch-ebsa110/entry-macro.S    |   36 
 include/asm-arm/arch-ebsa285/entry-macro.S    |  106 ++
 include/asm-arm/arch-epxa10db/entry-macro.S   |   27 
 include/asm-arm/arch-h720x/entry-macro.S      |   57 +
 include/asm-arm/arch-imx/entry-macro.S        |   31 
 include/asm-arm/arch-integrator/entry-macro.S |   35 
 include/asm-arm/arch-iop3xx/entry-macro.S     |   62 +
 include/asm-arm/arch-ixp2000/dma.h            |    2 
 include/asm-arm/arch-ixp2000/entry-macro.S    |   53 +
 include/asm-arm/arch-ixp2000/io.h             |    2 
 include/asm-arm/arch-ixp2000/irqs.h           |   30 
 include/asm-arm/arch-ixp2000/ixdp2x00.h       |    4 
 include/asm-arm/arch-ixp2000/ixdp2x01.h       |    8 
 include/asm-arm/arch-ixp2000/ixp2000-regs.h   |   79 +-
 include/asm-arm/arch-ixp2000/platform.h       |    6 
 include/asm-arm/arch-ixp2000/serial.h         |    4 
 include/asm-arm/arch-ixp2000/system.h         |    2 
 include/asm-arm/arch-ixp2000/vmalloc.h        |    2 
 include/asm-arm/arch-ixp4xx/entry-macro.S     |   26 
 include/asm-arm/arch-ixp4xx/ixp4xx-regs.h     |    2 
 include/asm-arm/arch-l7200/entry-macro.S      |   30 
 include/asm-arm/arch-lh7a40x/entry-macro.S    |   67 +
 include/asm-arm/arch-omap/entry-macro.S       |   32 
 include/asm-arm/arch-pxa/entry-macro.S        |   32 
 include/asm-arm/arch-rpc/entry-macro.S        |    3 
 include/asm-arm/arch-s3c2410/entry-macro.S    |  128 +++
 include/asm-arm/arch-sa1100/entry-macro.S     |   40 +
 include/asm-arm/arch-shark/entry-macro.S      |   36 
 include/asm-arm/arch-versatile/entry-macro.S  |   37 
 include/asm-arm/hardware/entry-macro-iomd.S   |  145 +++
 include/asm-arm/mach/map.h                    |   11 
 48 files changed, 1324 insertions(+), 1206 deletions(-)

through these ChangeSets:

<dsaxena@plexity.net> (04/09/16 1.1842.1.1)
   [ARM] Move platform-specific code out of entry-armv.S
   
   This patch borrows from the uclinux source where they have moved
   the per-platform code for get_irqnr_and_base, disable_fiq, and
   irq_prio_table out of entry-armv.S. However, instead of putting the
   macros in arch/arm/mach-$(MACHINE)/entry-header.S, we just have
   it in the machine's incdir. This means we don't need the extra
   complexity of creating symlink at build time. The patch also removes 
   the irq_prio_table as a requirement for all machines and makes it
   specific to IOC/IOMD machines. 
   
   This patch drastically shrinks entry-armv.S and allows us to delete 
   and add machines without having to touch generic code (there were two 
   dead machines laying around in entry-armv.S).
   
   Tested on IXP4xx and test-built for following def-configs:
      rpc, mainstone, neponset, netwinder, footbrdige, ixdp2400,
      iq80331, and mx1ads
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/09/16 1.1842.1.2)
   [ARM] Remove leftover NEXUSPCI machine reference 
   
   ARCH_NEXUSPCI since machine is no longer in kernel, so removing
   leftover reference in arch/arm/boot/Makefile.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/09/17 1.1837.1.1)
   [ARM] Fix a few typos in arch/arm/boot/Makefile
   
   IXP4xx and IXP2000 had params-phys when it should be params_phys
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/09/22 1.1842.1.4)
   [ARM] IXP2400 erratum #66 workaround using MT_IXP2000_DEVICE
   
   Intel's IXP2400 chip contains an erratum (#66) that requires 
   tweaking the page table entries of on-board I/O devices so that 
   instead of mapping them CB=00, we must map them XCB=101.  Without 
   this, writes to I/O regions cannot be guaranteed to complete in 
   order and we can end up with data from a write to regsiter A in 
   register B. This is very bad and leads to intermittent crashes.
   
    This changeset adds a MT_IXP2000_DEVICE mem_types entry with XCB
    set to 101 for section mappings and rearranges the memory map 
    on the IXP2000 port to map on-board devices via sections instead
    of pages. While this wastes a bit more VM, it solves the issues 
    without the need of board-specific hacks in proc-xscale.S or
    walking the page table to set the PMDs after mapping the I/O.
    
   These changes have been tested by myself on IXDP2401 and by 
   Lennert Buytenhek on ENP-2611.
    
   For more information on the issue:
    
   ARM mailing list discussions (tinyurl to make readable):
    
      http://tinyurl.com/6b64h
      http://tinyurl.com/6zfs9
      http://tinyurl.com/3nzjd 
    
   Intel Specification Update for IXP2400:
   
      ftp://download.intel.com/design/network/specupdt/30116110.pdf
    
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
   

<buytenh@wantstofly.org> (04/09/22 1.1842.1.5)
   [ARM] Cleanup use of ixp_reg_write in arch/arm/mach-ixp2000
   
   Several files in this directory directly dereference pointers
   to on-chip I/O instead of using ixp_reg_write, making them
   susceptible to IXP2400 erratum #66. This changset fixes those.
   We do not touch any files that will only be built for IXP2800
   systems as the 2800 does not have this issue.
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxerna@plexity.net>

<dsaxena@plexity.net> (04/09/24 1.1842.2.1)
   [ARM] Fix IXP4xx PCI bus scan routines
   
   The IXP4xx PCI bus scan routines currently virtualize accesses
   to device 0:0 to map to the host bridge itself. This is technically
   incorrect b/c on certain boards have an actual device wired to 0:0
   and the existing code will not see these.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
   

<dsaxena@plexity.net> (04/09/28 1.1842.2.2)
   [ARM] Add IXDPG425 platform support
   
   Add support for new IXP4xx platform from Intel.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<palves@portus.com.sg> (04/09/29 1.1842.2.3)
   [ARM] Fix ixp4xx-regs.h PCI config address typo
   
   There seems to be a typo that has creeped into
   include/asm/arch-ixp4xx/ixp4xx-regs.h. IXP4XX_EXP_CFG_BASE_VIRT and
   IXP4XX_PCI_CFG_BASE_VIRT were both defined to the same value. The patch
   changes them to the value in the memory map comment.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<y.rutschle@indigovision.com> (04/09/29 1.1842.2.4)
   [ARM] Fix IXP4xx timer interrupt implementation
   
   The current timer interrupt implementation can cause time to skip
   forward by ~65s and causes a 1 minute pause during bootup. The fix
   for this was found during 2.4 but got lost in the 2.6 transition.
   
   Details @:
   
   http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-September/017171.html
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/10/04 1.1842.3.1)
   [ARM] Fix header file ordering for IRQ handling
   
   We need to include <asm/arch/irqs.h> before <asm/arch/entry-macro.S>
   because entry-macro.S might need the platform IRQ definitions.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
    

<dsaxena@plexity.net> (04/10/07 1.1842.3.2)
   [ARM] Add I2C controller to IXDP2x01 platforms
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/10/07 1.1842.3.3)
   [ARM] Various typo fixes and comment cleanups for IXP2000
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/10/08 1.1842.3.4)
   [ARM] Force IXP2000 slowport to 8-bit operation
   
   As I understand it, the IXP2000 slowport has two modes:
   
   - 8-bit.  In this mode, every 8-bit read by the xscale core is sent
     to the slowport as a single 8-bit read, and on a 16-bit or 32-bit
     read, the xscale core does either 2 or 4 individual byte reads and
     combines them according to its current endian setting.
   - 32-bit.  In this mode, every 32-bit read is sent to the slowport
     as a 32-bit read, and the slowport then does four individual 8-bit
     reads and combines them into a 32-bit value according to little
     endian byte ordering.  8-bit accesses are done in this mode by
     doing a 32-bit access, and extracting the relevant sub-byte.
   
   So when the xscale is in big-endian mode and the slowport is in 32-bit
   mode, a read from byte address #0 will actually cause the byte at
   address #3 to be read.  The same with #1-#2, and of course vice versa.
   
   The only thing that 32-bit mode is good for is the initial boot.  If
   you flash the bootloader into flash with little-endian byte ordering,
   then the xscale will always read the (32-bit) instructions in its
   then-current word ordering regardless of whether that is big or
   little endian.
   
   After booting, it doesn't make any sense to use 32-bit mode anymore.
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/10/08 1.1842.3.5)
   [ARM] Don't mask IRQ_STATUS with IXP2000_VALID_IRQ_MASK
   
   According to the IXP Programmer's Reference Manual, a read from
   IRQ_STATUS can only return '1' for IRQ sources that have been
   explicitly enabled in IRQ_ENABLE.  So if we never enable 'invalid'
   IRQ sources, we don't actually have to mask off IRQ_STATUS with
   IXP2000_VALID_IRQ_MASK.
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/10/08 1.1842.3.6)
   [ARM] Fix some more IXP2000 comments
   
   ixp2000-regs.h has a minor typo in a comment (0xc000000 instead of
   0xc0000000.)  While we're at it, add warnings about the virtual
   addresses of the CAP, INTCTL and PCI_CSR mappings having been
   hardcoded elsewhere, just in case anyone ever tries to move them
   around and ends up wondering why it doesn't work.
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/10/11 1.1842.3.7)
   [ARM} Rename IRQ_IXP2000_SWI as IRQ_IXP2000_SOFT_INT
   
   IXP2000 interrupt source zero is a software-generated interrupt source,
   but it is not an SWI in the ARM sense of the word.  Rename the interrupt
   source to reduce confusion.
   
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<buytenh@wantstofly.org> (04/10/11 1.1842.3.8)
   [ARM]  Rip out ixp2000 IRQ_ERR_STATUS demultiplexing
   
   There are thirteen different IRQs chained off IRQ_ERR_STATUS, one for
   each possible error class that the IXP can signal an interrupt for, but
   there are no in-tree users of these interrupts, and it doesn't make much
   sense to treat them as separate interrupts if we can just have one
   handler checking each of the thirteen errors in one go instead.
   
   Besides that, the error interrupt handling can't even have been working
   properly in the first place as the chained handler was testing the wrong
   bits in the IRQ_ERR_STATUS register.
   
   So this patch rips it all out.
   
   Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/10/17 1.1988.93.2)
   [ARM] Add H720x entry-macro.S header file
   
   Compile tested with both h7201 and h7202 defconfigs.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/10/21 1.2038)
   [ARM] Make IXDPG425 use new timer infrastructure
   
   A new IXP4xx machine type was added to my tree and 
   needs updating to use new timer infrastructure.
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

In reponse to this message I will post the individual changesets to the 
mailing list for those that want to see/review them.


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
