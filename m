Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUJPAwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUJPAwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 20:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUJPAwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 20:52:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48309 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268482AbUJPAwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 20:52:31 -0400
Date: Sat, 16 Oct 2004 01:52:30 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [CFT] 2.6.9-rc4-bird1 patchset
Message-ID: <20041016005230.GF23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Yes, folks, it's YATree.  It is supposed to act as a staging area
for the stuff like sparse cleanups, etc.

	Right now it's mostly about iomem annotations and fixes; it gets
drivers/net more or less back to sanity and takes a swipe at other parts
of drivers/*.  Other stuff that will eventually get in there includes e.g.
endianness annotations and fixes.  It builds with allmodconfig on x86,
amd64, alpha, sparc32, sparc64 and ppc.  *Note*: right now a bunch of
modules are broken on ppc since it doesn't have ioread*/iowrite* implemented.

	Currently patch is on
ftp.linux.org.uk/pub/people/viro/patch-2.6.9-rc4-bird1.bz2.  Splitup is
in ftp.linux.org.uk/pub/people/viro/patchset/.  Patch is against 2.6.9-rc4;
the first chunk in splitup is bk-net snapshot circa Oct 12, the rest is
the series proper.

	Testers are welcome.  If you have patches in that direction, feel
free to send them for review/inclusion into patchset.

	Hopefully, updated versions of patchset will be posted more or less
daily; for now - based on 2.6.4-rc9, once we get 2.6.9 and things start
moving again - on bk snapshots.

	Current contents:
Base patches:
bk-net.patch	jgarzik's tree
bk-net.fixes	compile fixes - missing include in typhoon.c + use of -mm-only
		function in tulip.

Infrastructure patches [not for merge]
kconfig		teaches allmodconfig to pin a set of options in given state
		[NB: rz has another variant; this is just a temporary]
CHECKFLAGS	allows to add stuff to CHECKFLAGS from command line
disable-DI	disables CONFIG_DEBUG_INFO for test builds

Series proper:
alpha-writeq-fix	alpha compile fix (writeq/readq)
		 some drivers do ifdef on writeq; alpha has it as inline
		 function, so they
		 get confused.
sparc-kconfig-fixes	sparc32 kconfig fixes
		 CONFIG_VT should select CONFIG_INPUT, parport, oss and serial
		 are broken.
alpha-io_remap_page_range compile fix for alpha io_remap_page_range
bw2		fixes for drivers/video/bw2.c
sparc-atomic-UP	compile fix for UP sparc32 with DEBUG_SPINLOCK enabled
gadget-ether	sparc32 compile fixes for drivers/usb/gadget/ether.c
amd64-ioremap	amd64 io.h annotations
amd64-get_user	amd64 uaccess.h annotations
qla2xxx		qla2xx iomem annotations
ppc-ioremap	ppc io.h annotations
s2io		s2io iomem annotations
sparc64-io	sparc64 io.h annotations
cycx		cyclom iomem annotations
		__iomem added where needed in cyclom code
		cycx_setup() gets physical address as an explicit argument
		instead of abusing hw->dpmbase
sparc64-ioremap	added typechecking to sparc64 ioremap
		made sparc64 ioremap an inlined function, fixed a bug in
		sbus/char/cpwatchdog.c found by that.
ppc-uaccess	ppc uaccess.h annotations
aacraid		aacraid iomem annotations
aic-trivial	aic7xxx iomem annotations
aic-ioremap	aic7xxx ioremap cleanup
		ioremap does the right thing when it sees a non-aligned
		address; no need duplicate that in driver.
qla1820		qla1820 iomem annotionats
syscall		pci/syscall.c __user annotations
msi		msi iomem annotations
cpq-hotplug	cpqphp iomem annotations
hotplug-misc	the rest of pci/hotplug iomem annotations
fusion		message/fusion iomem annotations
cycx-64bit	64bit fix in cycx_x25.c
		comparing u32 with ~0UL is wrong
memcpy_io	consistent prototypes for memcpy_..io()
		x86_64 and sparc64 switched to usual prototypes for
		memcpy_toio() et.al.
hd6457		hd6457x iomem annotations
dscc4		dscc4 iomem annotations
netdev-trivial	bunch of trivial iomem annotations in drivers/net
rrunner		rrunner iomem annotations
amd8111e	amd8111e iomem annotations
r8169		r8169 iomem annotations
via-velocity	via-velocity iomem annotations
via-rhine	via-rhine iomem annotations, switch to io{read,write}
tulip		tulip iomem annotations, switch to io{read,write}
winbond		winbond840 iomem annotations, switch to io{read,write}
forcedeth	forcedeth iomem annotations
sundance	sundance iomem annotations, switch to io{read,write}
yellowfin	yellowfin iomem annotations, switch to io{read,write}
ac3200		ac3200 iomem annotations and fixes
		annotated, killed isa_... uses by making ioremap()
		unconditional, fixed the use of isa_... on already remapped
		address.
hp100		hp100 iomem annotations
ne3210		ne3210 iomem annotations
starfire	starfire iomem annotations
3c507		killed isa_... in 3c507
		switched to ioremap() + normal read../write..
depca		depca iomem annotations
hamachi		hamachi iomem annotations
3c359		3c359 iomem annotations
e2100		e2100 iomem annotations and fixes
		added missing ioremap(); driver was using readw() et.al. on
		non-remapped addresses.
ibmtr		beginning of ibmtr iomem annotations
		the easy parts of ibmtr annotations, there will be another
		patch dealing with the rest of it [yet to be merged]
lanstreamer	lanstreamer iomem annotations
lanstreamer-fix	lanstreamer fix
		copy from on-stack array is memcpy(), not memcpy_fromio()
arlan-priv	netdev_priv() in arlan
arlan		arlan iomem annotations and cleanups
		iomem annotations + couple of bad implementations of offsetof()
		replaced with the real thing.
netwave-priv	netdev_priv() in netwave_cs
netwave		netwave iomem annotations
pcmcia		net/pcmcia iomem annotations
olympic		olympic_open() cleanup and fixes
		fixed direct dereference of iomem pointers and plugged a leak.
