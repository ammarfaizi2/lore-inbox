Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135997AbRDTTs1>; Fri, 20 Apr 2001 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135995AbRDTTsS>; Fri, 20 Apr 2001 15:48:18 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:14865 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135997AbRDTTsC>;
	Fri, 20 Apr 2001 15:48:02 -0400
Date: Fri, 20 Apr 2001 15:47:43 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Matthew Wilcox <willy@ldl.fc.hp.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420154743.A19618@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Matthew Wilcox <willy@ldl.fc.hp.com>, linux-kernel@vger.kernel.org,
	parisc-linux@parisc-linux.org
In-Reply-To: <20010419203639.H4217@zumpano.fc.hp.com> <20010419230009.A32500@thyrsus.com> <20010419211749.I4217@zumpano.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419211749.I4217@zumpano.fc.hp.com>; from willy@ldl.fc.hp.com on Thu, Apr 19, 2001 at 09:17:49PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@ldl.fc.hp.com>:
> > Could I ask you to audit your tree and change the prefix on any 
> > CONFIG_ symbols that are private over there?  This would make life 
> > easier for my auditing tools (kxref and Stephen Cole's ach script).
> 
> I don't think we have any of those.  We certainly have symbols which are
> defined for symmetry and may not actually be used yet (CONFIG_PA11 might not
> be, perhaps).  But that's what happens when you're developing software :-)

Here's what I have for you guys:

CONFIG_BINFMT_JAVA: arch/parisc/config.in arch/parisc/defconfig arch/cris/config.in arch/cris/defconfig

You've already gotten rid of that one.

CONFIG_BINFMT_SOM: arch/parisc/config.in arch/parisc/defconfig

Not used in code anywhere.  Can you get rid of this one?

CONFIG_DMB_TRAP: arch/parisc/kernel/sba_iommu.c
CONFIG_FUNC_SIZE: arch/parisc/kernel/sba_iommu.c

Would you please take these out of the CONFIG_ namespace?  Changing the 
prefix to CONFIGURE would do nicely.

CONFIG_GENRTC: arch/parisc/defconfig

This is a typo for GEN_RTC.  Please fix it or get rid of it.

CONFIG_HIL: arch/parisc/defconfig

Looks like an orphan.  Can you get rid of it?

CONFIG_GSC: arch/parisc/config.in arch/parisc/defconfig
CONFIG_GSC_DINO: arch/parisc/config.in arch/parisc/defconfig
CONFIG_GSC_LASI: arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/led.c
CONFIG_GSC_PS2: arch/parisc/config.in arch/parisc/defconfig
CONFIG_IODC_CONSOLE: arch/parisc/config.in arch/parisc/kernel/setup.c
CONFIG_IOMMU_CCIO: arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/Makefile
CONFIG_IOMMU_SBA: arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/Makefile
CONFIG_IOSAPIC: arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/Makefile
CONFIG_KWDB: arch/parisc/Makefile arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/entry.S arch/parisc/kernel/traps.c arch/parisc/mm/init.c
CONFIG_LASI_82596: arch/parisc/config.in arch/parisc/defconfig
CONFIG_PARPORT_GSC: drivers/parport/Makefile arch/parisc/config.in arch/parisc/defconfig
CONFIG_PCI_LBA: arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/Makefile
CONFIG_SCSI_LASI: arch/parisc/config.in arch/parisc/defconfig
CONFIG_SCSI_ZALON: arch/parisc/config.in arch/parisc/defconfig
CONFIG_STI_CONSOLE: arch/parisc/Makefile arch/parisc/config.in arch/parisc/defconfig arch/parisc/kernel/setup.c arch/parisc/mm/init.c

Looks like these need Configure.help entries.

CONFIG_SERIAL_GSC: drivers/char/serial.c arch/parisc/defconfig

That reference pattern looks kind of weird.  Is this a bug?

If you could clean these up, that's everything I need from the parisc tree.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

(Those) who are trying to read the Second Amendment out of the Constitution by
claiming it's not an individual right (are) courting disaster by encouraging
others to use the same means to eliminate portions of the Constitution they
don't like.
	-- Alan Dershowitz, Harvard Law School
