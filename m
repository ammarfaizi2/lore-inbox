Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSIZP52>; Thu, 26 Sep 2002 11:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSIZP52>; Thu, 26 Sep 2002 11:57:28 -0400
Received: from linux3.contactor.se ([193.15.23.23]:53969 "EHLO
	linux3.contactor.se") by vger.kernel.org with ESMTP
	id <S261325AbSIZP51>; Thu, 26 Sep 2002 11:57:27 -0400
Date: Thu, 26 Sep 2002 17:59:09 +0200
From: =?iso-8859-1?Q?Bj=F6rn_Stenberg?= <bjorn@haxx.se>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: PPC: unresolved module symbols in 2.4.20-pre7+bk
Message-ID: <20020926175909.E11535@linux3.contactor.se>
References: <20020924234815.GE788@opus.bloom.county> <Pine.GSO.4.44.0209261127110.27736-100000@rubiin.physic.ut.ee> <20020926142927.GE5746@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020926142927.GE5746@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Sep 26, 2002 at 07:29:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Tom Rini wrote:
> > > > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/usb/storage/usb-storage.o
> > > > depmod: 	ppc_generic_ide_fix_driveid
> 
> Configuration issue.  CONFIG_USB_STORAGE_ISD200 needs to depend on
> CONFIG_IDE, since it calls ide_fixup_driveid().  Greg? Björn?

This is only an issue for PPC and SPARC64. Other targets have an empty macro for ide_fix_driveid().

I don't know how this kind of "target-dependent dependency" is normally handled. The attached patch is one way.

-- 
Björn

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Config.in-isd200.patch"

--- linux-2.4.20-pre7/drivers/usb/Config.in~	2002-09-26 17:04:18.000000000 +0200
+++ linux-2.4.20-pre7/drivers/usb/Config.in	2002-09-26 17:41:06.000000000 +0200
@@ -41,7 +41,11 @@
       dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
       dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
-      dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
+      if [ "$CONFIG_PPC" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
+         dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE $CONFIG_IDE
+      else
+         dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
+      fi
       dep_mbool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
       dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL

--qjNfmADvan18RZcF--
