Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbUKQPFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUKQPFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUKQPFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:05:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262339AbUKQPFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:05:09 -0500
Date: Wed, 17 Nov 2004 15:05:08 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [CFT] 2.6.9-rc2-bk1-bird1 patchset
Message-ID: <20041117150508.GD26051@parcelfarce.linux.theplanet.co.uk>
References: <20041016005230.GF23987@parcelfarce.linux.theplanet.co.uk> <20041018020617.GH23987@parcelfarce.linux.theplanet.co.uk> <20041020233547.GN23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020233547.GN23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

News:
 	* based on 2.6.10-rc2-bk1 now
	* a bunch of patches got merged - some into Linus' tree, some into
bk-net
	* iomem patches in sound/oss
	* eicon patchset added; that one is *not* for merge until maintainer
ACKs the sucker
	* more __user annotations for recently merged stuff (folks, please
at least try to run make C=2 after your patches and look for regressions).
	* misc iomem annotations and fixes all over the place in drivers/*

 	Currently patch is on
ftp.linux.org.uk/pub/people/viro/patch-2.6.10-rc2-bk1-bird1.bz2.  Splitup is
in ftp.linux.org.uk/pub/people/viro/patchset/.

	Added chunks:

X6	alpha-numa	CONFIG_NUMA is broken on alpha right now
X11	emu10k-ioctl	CONFIG_EMU10K1 is broken on a shitload of platforms
U573	pc300		portability fixes for pc300
X15	xircom		fix for botched MODULE_PARM conversion in xircom
U574	i2o		i2o iomem annotation
U575	cpq		cpqphp_nvram iomem annotation
U576	misc_user	trivial __user annotations
U577	init		more C99 initializers
U578	w1		drivers/w1 iomem annotations
U579	isdn		more trivial isdn iomem annotations
U580	pcilynx		pcilynx iomem annotations
U581	media		trivial drivers/media iomem annotations
U582	oss		sound/oss iomem annotations
U583	ad1889		ad1889 iomem annotations and leak fixes
U584	64bit		misc portability fixes
U585	sound_pci	sound/pci iomem annotations
U586	isdn_fix	isdn/pcbit iomem fix
U587	zoran_fix	zoran iomem fix
U588	imsttfb		imsttfb iomem annotations
U589	tgafb		tgafb iomem annotations
U590	i386_uaccess	i386 uaccess.h annotations
X20	config-rio	marks rio broken
EIC1	eicon_getword	distinguish between iomem and normal memory access
# adds new helpers ({GET,PUT}_{WORD,DWORD}) parallel to READ_WORD et.al.,
# but used on normal memory instead of iomem.  Instances of READ_WORD
# and friends that are applied to vmalloc'ed memory and local variables
# switched to new helpers.
EIC2	eicon_iomem	eicon iomem annotations
EIC3	eicon_readb	eicon byte iomem access fixes
# new helpers - READ_BYTE() and WRITE_BYTE().  On Linux they are needed, since
# direct access to iomem pointers is not allowed (and does not work on some
# architectures).
# memcpy() to/from iomem is not allowed on Linux (same story). Proper
# primitives are memcpy_toio() and memcpy_fromio().  Several places
# misused memcpy(); switched to memcpy_{to,from}io().
EIC4	eicon_fix	s_4bri.c bugfix (bogus &)
# s_4bri.c has a nasty typo - bogus & in qBri_cpu_trapped().
# We have
#	void *base;
# followed by
#	regs[0] = READ_DWORD((&base + offset) + 0x70);
# which is *NOT* what is meant there - instead of access to memory pointed to
# by base we get access to _stack_ at some offset from the place where the
# local variable base lives.
