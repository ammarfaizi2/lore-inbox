Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTLLOnB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTLLOnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:43:01 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:50086
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S264433AbTLLOmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:42:53 -0500
From: Daniel Tram Lux <daniel@starbattle.com>
Date: Fri, 12 Dec 2003 15:42:46 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide.c as a module
Message-ID: <20031212144246.GA15357@starbattle.com>
References: <20031211202536.GA10529@starbattle.com> <200312112225.14540.bzolnier@elka.pw.edu.pl> <20031212092006.GA13250@starbattle.com> <200312121430.36735.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312121430.36735.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried with using only your suggested changes and removing the ide_probe
ptr, but due to (in include/asm-i386/ide.h) where CONFIG_BLK_DEV_IDEPCI is 
indeed undefined:

static __inline__ void ide_init_default_hwifs(void)
{
#ifndef CONFIG_BLK_DEV_IDEPCI
	hw_regs_t hw;
	int index;

	for(index = 0; index < MAX_HWIFS; index++) {
		memset(&hw, 0, sizeof hw);
		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
		hw.irq = ide_default_irq(ide_default_io_base(index));
		ide_register_hw(&hw, NULL);
	}
#endif /* CONFIG_BLK_DEV_IDEPCI */
}

I get the following probing messages (I enabled a debug message which is why there are so
many messages):

Using /lib/modules/2.4.23/kernel/drivers/ide/ide-core.o
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
probing for hda: present=0, media=32, probetype=ATA
hda: SanDisk SDCFB-256, CFA DISK drive
probing for hdb: present=0, media=32, probetype=ATA
probing for hdb: present=0, media=32, probetype=ATAPI
probing for hdc: present=0, media=32, probetype=ATA
hdc: IC25N040ATMR04-0, ATA DISK drive
probing for hdd: present=0, media=32, probetype=ATA
probing for hdd: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
probing for hdc: present=0, media=32, probetype=ATA
hdc: IC25N040ATMR04-0, ATA DISK drive
probing for hdd: present=0, media=32, probetype=ATA
probing for hdd: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI
ide1 at 0x170-0x177,0x376 on irq 15
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table

Any ideas how to avoid this?

Regards

Daniel Lux 

On Fri, Dec 12, 2003 at 02:30:36PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Friday 12 of December 2003 10:20, Daniel Tram Lux wrote:
> > On Thu, Dec 11, 2003 at 10:25:14PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday 11 of December 2003 21:25, Daniel Tram Lux wrote:
> > > > Hi,
> > >
> > > Hi,
> > >
> > > > I needed the ide-subsytem as a module on 2.4.23 and noticed (due to the
> > > > missing modprobe on the embedded linux system) that ide.c tries to load
> > > > the module ide-probe-mod which is called ide-detect now. The patch also
> > > > get's rid of the need for ide-probe-mini alias ide-detect, but I don't
> > > > know if that is desired? (it was in my case).
> > >
> > > It is incorrect, it will make most of modules for PCI IDE chipsets fail
> > > due to always calling ide_init() from ide.c:init_module().
> >
> > ide_init is called from ide.c:init_module()
> > in the original version:
> >
> > int init_module (void)
> > {
> > 	parse_options(options);
> > 	return ide_init(); <--------
> > }
> 
> I was thinking about ideprobe_init_module() not ide_init() :-).
> 
> > > You need to modprobe ide-detect if you are using generic IDE code
> > > (no chipset specific driver - probably the case for your embedded
> > > system).
> >
> > I know this, but ide-detect is basically an empty module, only calling
> > ideprobe_init_module() can't this be done right away from ide.c or are
> > there any reasons to delay the call until later at a user defined point of
> > time?
> 
> YES.  If you have some PCI IDE, you must load PCI chipset module before
> loading ide-detect.o otherwise (you load ide-detect.o before your PCI chipset
> module) generic IDE driver will own your IDE ports and you cannot use your
> specific PCI chipset driver.
> 
> > > You are right that ide-probe-mini alias is not needed, ide-probe-mini.c
> > > should be renamed to ide-detect.c (or ide-detect.o to ide-probe-mini.o).
> > >
> > > > --- linux-2.4.23.org/drivers/ide/ide.c  2003-11-28 19:26:20.000000000
> > > > +0100 +++ linux-2.4.23/drivers/ide/ide.c      2004-03-11
> > > > 20:31:51.000000000 +0100 @@ -514,11 +514,7 @@
> > > >
> > > >  void ide_probe_module (int revaldiate)
> > > >  {
> > > > -       if (!ide_probe) {
> > > > -#if  defined(CONFIG_BLK_DEV_IDE_MODULE)
> > > > -               (void) request_module("ide-probe-mod");
> > > > -#endif
> > > > -       } else {
> > > > +       if (ide_probe) {
> > > >                 (void) ide_probe->init();
> > > >         }
> > > >         revalidate_drives(revaldiate);
> > >
> > > You should make this change in ide_register_hw() instead:
> > >
> > > -		ide_probe_module();
> > > +#ifdef MODULE
> > > +		if (ideprobe_init_module() == -EBUSY)
> > > +#endif
> > > +			ideprobe_init();
> >
> > Your patch will (if MODULE is defined) call ideprobe_init() twice,
> > once from ideprobe_init_module() and once from ideprobe_init()
> > should ideprobe_init really not only be called once and only once?
> 
> No, think about loading chipset modules.  Some (i.e. ide-cs.o) are
> calling ide_register_hw() and expect that this function will probe drives
> (without need to load ide-detect.o by user).  Change above preserves
> current behavior (note that you may have more than one chipset module).
> 
> The same (probing for drives by chipset module) can be done for PCI
> drivers but requires a some more work in case of 2.4.x kernels.
> 
> --bart
> 
> > > And get rid of ide_probe pointer.
> > >
> > > --bart
