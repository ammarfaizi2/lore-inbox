Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSIZOYa>; Thu, 26 Sep 2002 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSIZOY3>; Thu, 26 Sep 2002 10:24:29 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:10159
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261296AbSIZOY3>; Thu, 26 Sep 2002 10:24:29 -0400
Date: Thu, 26 Sep 2002 07:29:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org, bjorn@haxx.se, greg@kroah.com
Subject: Re: PPC: unresolved module symbols in 2.4.20-pre7+bk
Message-ID: <20020926142927.GE5746@opus.bloom.county>
References: <20020924234815.GE788@opus.bloom.county> <Pine.GSO.4.44.0209261127110.27736-100000@rubiin.physic.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.44.0209261127110.27736-100000@rubiin.physic.ut.ee>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 11:31:20AM +0300, Meelis Roos wrote:

> The errors are still there in 2.4.20-pre8 and none of them went away
> after make mrproper.

Thanks for the .config, I see most of them now.

[re-ordered slightly]
> > > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/macintosh/nvram.o
> > > depmod: 	pmac_get_partition
> > > depmod: 	nvram_write_byte_R9ce3f83f
> > > depmod: 	nvram_read_byte_R0f28cb91
> > > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/sound/dmasound/dmasound_pmac.o
> > > depmod: 	pmac_xpram_read

CONFIG_NVRAM cannot really be =m as you have in your .config on
CONFIG_ALL_PPC.  I'll send Marcelo a bit more Makefile gunk to work
around this.  For now just set it to y.

> > > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/media/video/tda7432.o
> > > depmod: 	__fixdfsi
> > > depmod: 	__floatsidf
> > > depmod: 	__divdf3
> > > depmod: 	__muldf3
> > > depmod: 	__subdf3

This driver is doing floating point operations inside the kernel, and is
therefore broken.

> > > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/usb/storage/usb-storage.o
> > > depmod: 	ppc_generic_ide_fix_driveid

Configuration issue.  CONFIG_USB_STORAGE_ISD200 needs to depend on
CONFIG_IDE, since it calls ide_fixup_driveid().  Greg? Björn?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
