Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbTJKPaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTJKPaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:30:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52711 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262944AbTJKPaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:30:13 -0400
Date: Sat, 11 Oct 2003 17:30:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Atul Mukker <Atul.Mukker@lsil.com>, linux-megaraid-devel@dell.com,
       linux-kernel@vger.kernel.org
Subject: [patch] Re: 2.4.23-pre7: build error with both megaraid drivers enabled
Message-ID: <20031011153004.GC25478@fs.tum.de>
References: <20031011144400.GB25478@fs.tum.de> <Pine.LNX.4.44.0310110946070.7261-100000@iguana.domsch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310110946070.7261-100000@iguana.domsch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 09:48:08AM -0500, Matt Domsch wrote:
> > I get the following build error when trying to compile both megaraid
> > drivers statically into the kernel:
> 
> They both drive the same hardware, so this isn't such a good idea.  One or
> the other, but not both please, at least not built-in.  Both as modules
> should be fine, you'll only ever load one. It's not surprising that a few
> functions are named the same between both.

This should be expressed through the Config.in dependencies, e.g. as 
follows:

--- linux-2.4.23-pre7-full/drivers/scsi/Config.in.old	2003-10-11 17:00:47.000000000 +0200
+++ linux-2.4.23-pre7-full/drivers/scsi/Config.in	2003-10-11 17:24:00.000000000 +0200
@@ -67,7 +67,12 @@
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
-dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+if [ "$CONFIG_SCSI_MEGARAID" != "y" ]; then
+  define_tristate CONFIG_SCSI_MEGARAID2_DEP $CONFIG_SCSI
+else
+  define_tristate CONFIG_SCSI_MEGARAID2_DEP m $CONFIG_SCSI
+fi
+dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI_MEGARAID2_DEP
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then


> Thanks,
> Matt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

