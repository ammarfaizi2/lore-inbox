Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317808AbSFMTqi>; Thu, 13 Jun 2002 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317809AbSFMTqi>; Thu, 13 Jun 2002 15:46:38 -0400
Received: from stingr.net ([212.193.32.15]:2435 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S317808AbSFMTqh>;
	Thu, 13 Jun 2002 15:46:37 -0400
Date: Thu, 13 Jun 2002 23:46:36 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] aic7xxx won't compile w/o PCI at all <- fixed
Message-ID: <20020613194636.GA26527@stingr.net>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

I know I shouldn't do that
I also know someone should do at least compile on cases which affected by
some patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.538   -> 1.539  
#	drivers/scsi/aic7xxx/aic7xxx_proc.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/13	stingray@boxster.stingr.net	1.539
# Fix two obscure cases in heh aic7xxx
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_proc.c b/drivers/scsi/aic7xxx/aic7xxx_proc.c
- --- a/drivers/scsi/aic7xxx/aic7xxx_proc.c	Thu Jun 13 23:43:23 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_proc.c	Thu Jun 13 23:43:23 2002
@@ -282,7 +282,11 @@
 		sd.sd_CK = SEECK;
 		sd.sd_DO = SEEDO;
 		sd.sd_DI = SEEDI;
+#ifdef CONFIG_PCI
 		have_seeprom = ahc_acquire_seeprom(ahc, &sd);
+#else
+		have_seeprom = 0;
+#endif
 	}
 
 	if (!have_seeprom) {
@@ -306,8 +310,10 @@
 				  sizeof(struct seeprom_config)/2);
 		ahc_read_seeprom(&sd, (uint16_t *)ahc->seep_config,
 				 start_addr, sizeof(struct seeprom_config)/2);
+#ifdef CONFIG_PCI
 		if ((ahc->chip & AHC_VL) == 0)
 			ahc_release_seeprom(&sd);
+#endif
 		written = length;
 	}
 
- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAj0I9poACgkQyMW8naS07KSyFgCeIaq/qC3CjghpuzZaQZDk+xFk
gbEAn2VYDXsq+VC5lvvgOXCTUTr2DCsa
=g0mm
-----END PGP SIGNATURE-----
