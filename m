Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUGDSOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUGDSOy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUGDSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 14:14:54 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:54146
	"EHLO tumblerings.org") by vger.kernel.org with ESMTP
	id S265446AbUGDSOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 14:14:48 -0400
Date: Sun, 4 Jul 2004 11:14:38 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems getting SMP to work with vanilla 2.4.26
Message-ID: <20040704181438.GB3816@tumblerings.org>
References: <20040704020543.GA1776@tumblerings.org> <20040704141336.GA18851@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704141336.GA18851@logos.cnet>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, folks,

On Sun, Jul 04, 2004 at 11:13:36AM -0300, Marcelo Tosatti wrote:
> On Sat, Jul 03, 2004 at 07:05:43PM -0700, Zack Brown wrote:
> > Hi folks,
> > 
> > When booting vanilla 2.4.26 with SMP enabled, I get a lockup before the
> > boot sequence is completed. The same kernel with SMP disabled boots and runs
> > just fine. Both CPUs are detected by the system at bootup, before lilo takes
> > over. Here's the error as I wrote it down from the screen, followed by the
> > .config file:
> > 
> > ------------------------------ cut here ------------------------------
> > Using local APIC timer interrupts.
> > Calibrating APIC timer...
> > ..... CPU clock speed is 1004.4785 MHZ
> > ..... hostbus clock speed is 133.9304 MHz
> > cpu: 0, clocks: 1339304, slice: 446434
> > CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> > cpu: 1, clocks: 1339304, slice: 446434
> > CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> > ------------------------------ cut here ------------------------------
> > 
> > At that point the machine just hangs, with no keys recognized, and I have
> > to power-cycle the machine in order to boot to a UP kernel.
> > 
> > I'd appreciate any help I can get with this.
> 
> I can't help much really. Tried CONFIG_ACPI_BOOT=n ? 
> 

I did after getting your email, and I had some trouble with that. After
'make mrproper', and loading in the relevant .config I'd saved, menuconfig
then said that I had the ACPI option already disabled. If I enabled the master
ACPI section, all the sub-options were also disabled. So I had to quit out of
that and edit the .config by hand in order to set CONFIG_ACPI_BOOT=n. That's
the only change I made to the .config before recompiling.

I did a 'make dep' and 'make bzImage', and got the following error. It
looks like the kernel really wants that option enabled.

Be well,
Zack

------------------------------ cut here ------------------------------
make[1]: Leaving directory `/usr/src/linux-2.4.26/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.26/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pcmcia/pcmcia.o drivers/pnp/pnp.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/media/media.o drivers/input/inputdrv.o
drivers/message/i2o/i2o.o drivers/i2c/i2c.o crypto/crypto.o \
        net/network.o \
        /usr/src/linux-2.4.26/arch/i386/lib/lib.a
/usr/src/linux-2.4.26/lib/lib.a
/usr/src/linux-2.4.26/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o(.text.init+0x1138): In function
`parse_cmdline_early':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x1166): In function
`parse_cmdline_early':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x119b): In function
`parse_cmdline_early':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x11a5): In function
`parse_cmdline_early':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x11c5): In function
`parse_cmdline_early':
: undefined reference to `acpi_strict'
arch/i386/kernel/kernel.o(.text.init+0x1217): In function
`parse_cmdline_early':
: undefined reference to `acpi_sci_flags'
arch/i386/kernel/kernel.o(.text.init+0x1223): In function
`parse_cmdline_early':
: undefined reference to `acpi_sci_flags'
arch/i386/kernel/kernel.o(.text.init+0x1240): In function
`parse_cmdline_early':
: undefined reference to `acpi_sci_flags'
arch/i386/kernel/kernel.o(.text.init+0x125f): In function
`parse_cmdline_early':
: undefined reference to `acpi_sci_flags'
arch/i386/kernel/kernel.o(.text.init+0x1281): In function
`parse_cmdline_early':
: undefined reference to `acpi_sci_flags'
arch/i386/kernel/kernel.o(.text.init+0x18e2): In function `setup_arch':
: undefined reference to `acpi_boot_init'
arch/i386/kernel/kernel.o(.text.init+0x40c1): In function
`dmi_disable_acpi':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x4114): In function
`force_acpi_ht':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x4214): In function
`dmi_check_blacklist':
: undefined reference to `acpi_ht'
arch/i386/kernel/kernel.o(.text.init+0x6699): In function
`smp_boot_cpus':
: undefined reference to `acpi_lapic'
arch/i386/kernel/kernel.o(.text.init+0x7193): In function
`smp_read_mpc':
: undefined reference to `acpi_lapic'
arch/i386/kernel/kernel.o(.text.init+0x72f5): In function
`smp_read_mpc':
: undefined reference to `acpi_lapic'
arch/i386/kernel/kernel.o(.text.init+0x7594): In function
`get_smp_config':
: undefined reference to `acpi_lapic'
arch/i386/kernel/kernel.o(.text.init+0x75a7): In function
`get_smp_config':
: undefined reference to `acpi_ioapic'
arch/i386/kernel/kernel.o(.text.init+0x9bb2): In function
`setup_IO_APIC':
: undefined reference to `acpi_ioapic'
arch/i386/kernel/kernel.o(.text.init+0x9c20): In function
`setup_IO_APIC':
: undefined reference to `acpi_ioapic'
make: *** [vmlinux] Error 1
------------------------------ cut here ------------------------------

-- 
Zack Brown
