Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUJRCGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUJRCGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 22:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJRCGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 22:06:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269351AbUJRCGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 22:06:19 -0400
Date: Mon, 18 Oct 2004 03:06:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [CFT] 2.6.9-rc4-bird2 patchset
Message-ID: <20041018020617.GH23987@parcelfarce.linux.theplanet.co.uk>
References: <20041016005230.GF23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016005230.GF23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Next version of the patchset.

News:
	* sparse noise in drivers/net/* is practically gone (e.g. i386 is
down to 84 lines of sparse output in there, most of them unrelated to iomem;
that's down from ~10000).
	* a bunch of drivers/net patches had been ACKed for bk-net merge,
so hopefully the next revision will shrink.
	* more iomem patches outside of drivers/net; we are down to 469 gcc
warnings on i386 allmodconfig, more than a half of them from sound/*.  Other
platforms are, surprisingly, not much worse.
	* merged ppc iomap patch from benh, so ppc32 breakage is gone.

 	Currently patch is on
ftp.linux.org.uk/pub/people/viro/patch-2.6.9-rc4-bird2.bz2.  Splitup is
in ftp.linux.org.uk/pub/people/viro/patchset/.  Patch is against 2.6.9-rc4;
the first two chunks in splitup are bk-net snapshot circa Oct 12 and ppc
iomap patch from benh, the rest is the series proper.

 	Testers are welcome.  If you have patches in that direction, feel
free to send them for review/inclusion into patchset.
 
	Next revision will hopefully merge bk-scsi (and sanitize scsi-related
patches).

	Added chunks:
ibmtr2		ibmtr annotations - the rest
		the rest of annotations and cleanup: ->sram_virt abuse removed,
		we have separate ->sram_phys now (not remapped) and keep
		->sram_virt an iomem pointer.
skfp		skfp iomem annotations, switch to io{read,write}
hermes		wireless iomem annotations and fixes, switch to io{read,write}
		hermes.c switched to ioread/iowrite from homegrown analogs,
		its users updated.  Fixed direct dereferencing of ioremapped
		memory in orinoco_plx.
fealnx		fealnx iomem annotations, switch to io{read,write}
lne390		lne390 iomem annotations and fixes
		annotated, killed isa_... uses by making ioremap()
		unconditional, fixed the use of isa_... on already remapped
		address.
includes	a couple of missing includes of asm/irq.h
		disable_irq() needs asm/irq.h and not everyone who needs it
		gets it included indirectly.
wavelan_cs	wavelan_cs iomem annotations
airo		airo iomem annotations
miri_sbus	miri_sbus iomem annotations and fixes
		missing sbus_readl()
depca-noise	depca removal of bogus virt_to_bus() uses
mace1		mace iomem annotations - trivial part
disk_on_chip	disk_on_chip annotations and fixes
		iomem annotations and fix for a bug they'd caught in
		doc2001plus.c (wrong order of arguments in WriteDOC() call).
if_ppp		__user annotations in if_ppp
		annotated ioctl structure
moxa		moxa iomem annotations
sx		sx iomem annotations and fixes
		missing readb(), check of 64Kb alignment of physical address
		done to remapped one.
skystar2	skystar2 iomem annotations
kyro		video/kyro iomem annotations
aty		video/aty iomem annotations
riva		video/riva iomem annotations
video		misc drivers/video iomem annotations
teles		teles0 and telespci iomem annotations
isurf		isurf iomem annotations
ipr		ipr iomem annotations
ips		ips iomem annotations
megaraid	megaraid iomem annotations
nsp32		nsp32 iomem annotations
dpt		partial dpt_i2o iomem annotations
qlogicisp	qlogicisp iomem annotations
aic-old		aic7xxxold iomem annotations
3w-9xxx		3w-9xxx iomem annotations
