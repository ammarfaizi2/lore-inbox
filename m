Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUJ1X0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUJ1X0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUJ1XYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:24:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41746 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263068AbUJ1XTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:19:08 -0400
Date: Fri, 29 Oct 2004 01:18:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/aic7xxx/aic79xx_osm.c: remove an unused function
Message-ID: <20041028231837.GG3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from 
drivers/scsi/aic7xxx/aic79xx_osm.c


diffstat output:
 drivers/scsi/aic7xxx/aic79xx_osm.c |   26 --------------------------
 1 files changed, 26 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/scsi/aic7xxx/aic79xx_osm.c.old	2004-10-28 23:24:54.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-10-28 23:25:28.000000000 +0200
@@ -549,10 +549,6 @@
 static __inline void ahd_linux_run_device_queues(struct ahd_softc *ahd);
 static __inline void ahd_linux_unmap_scb(struct ahd_softc*, struct scb*);
 
- -static __inline int ahd_linux_map_seg(struct ahd_softc *ahd, struct scb *scb,
- -		 		      struct ahd_dma_seg *sg,
- -				      dma_addr_t addr, bus_size_t len);
- -
 static __inline void
 ahd_schedule_completeq(struct ahd_softc *ahd)
 {
@@ -711,28 +707,6 @@
 	}
 }
 
- -static __inline int
- -ahd_linux_map_seg(struct ahd_softc *ahd, struct scb *scb,
- -		  struct ahd_dma_seg *sg, dma_addr_t addr, bus_size_t len)
- -{
- -	int	 consumed;
- -
- -	if ((scb->sg_count + 1) > AHD_NSEG)
- -		panic("Too few segs for dma mapping.  "
- -		      "Increase AHD_NSEG\n");
- -
- -	consumed = 1;
- -	sg->addr = ahd_htole32(addr & 0xFFFFFFFF);
- -	scb->platform_data->xfer_len += len;
- -
- -	if (sizeof(dma_addr_t) > 4
- -	 && (ahd->flags & AHD_39BIT_ADDRESSING) != 0)
- -		len |= (addr >> 8) & AHD_SG_HIGH_ADDR_MASK;
- -
- -	sg->len = ahd_htole32(len);
- -	return (consumed);
- -}
- -
 /******************************** Macros **************************************/
 #define BUILD_SCSIID(ahd, cmd)						\
 	((((cmd)->device->id << TID_SHIFT) & TID) | (ahd)->our_id)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgX5NmfzqmE8StAARAoCsAKCuy7T+IJ9js2t0WiSg1Gd7trtmpQCfQvx3
HRTI5tHz4pLvSK3WEMq8rzw=
=fG4o
-----END PGP SIGNATURE-----
