Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWCMVRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWCMVRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWCMVRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:17:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65294 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932286AbWCMVRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:17:01 -0500
Date: Mon, 13 Mar 2006 22:16:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, support@lsil.com
Cc: linux-kernel@vger.kernel.org, mpt_linux_developer@lsil.com,
       linux-scsi@vger.kernel.org
Subject: [RFC: -mm patch] remove drivers/message/fusion/mptscsih.c:mptscsih_setDevicePage1Flags()
Message-ID: <20060313211659.GI13973@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm3:
>...
>  git-scsi-misc.patch
>...
>  git trees
>...


This function no longer has any user.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/message/fusion/mptscsih.c |   49 ------------------------------
 1 file changed, 49 deletions(-)

--- linux-2.6.16-rc6-mm1-full/drivers/message/fusion/mptscsih.c.old	2006-03-13 21:28:56.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/message/fusion/mptscsih.c	2006-03-13 21:29:10.000000000 +0100
@@ -2783,55 +2783,6 @@
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *  SCSI Config Page functionality ...
- */
-/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*	mptscsih_setDevicePage1Flags  - add Requested and Configuration fields flags
- *	based on width, factor and offset parameters.
- *	@width: bus width
- *	@factor: sync factor
- *	@offset: sync offset
- *	@requestedPtr: pointer to requested values (updated)
- *	@configurationPtr: pointer to configuration values (updated)
- *	@flags: flags to block WDTR or SDTR negotiation
- *
- *	Return: None.
- *
- *	Remark: Called by writeSDP1 and _dv_params
- */
-static void
-mptscsih_setDevicePage1Flags (u8 width, u8 factor, u8 offset, int *requestedPtr, int *configurationPtr, u8 flags)
-{
-	u8 nowide = flags & MPT_TARGET_NO_NEGO_WIDE;
-	u8 nosync = flags & MPT_TARGET_NO_NEGO_SYNC;
-
-	*configurationPtr = 0;
-	*requestedPtr = width ? MPI_SCSIDEVPAGE1_RP_WIDE : 0;
-	*requestedPtr |= (offset << 16) | (factor << 8);
-
-	if (width && offset && !nowide && !nosync) {
-		if (factor < MPT_ULTRA160) {
-			*requestedPtr |= (MPI_SCSIDEVPAGE1_RP_IU + MPI_SCSIDEVPAGE1_RP_DT);
-			if ((flags & MPT_TARGET_NO_NEGO_QAS) == 0)
-				*requestedPtr |= MPI_SCSIDEVPAGE1_RP_QAS;
-			if (flags & MPT_TAPE_NEGO_IDP)
-				*requestedPtr |= 0x08000000;
-		} else if (factor < MPT_ULTRA2) {
-			*requestedPtr |= MPI_SCSIDEVPAGE1_RP_DT;
-		}
-	}
-
-	if (nowide)
-		*configurationPtr |= MPI_SCSIDEVPAGE1_CONF_WDTR_DISALLOWED;
-
-	if (nosync)
-		*configurationPtr |= MPI_SCSIDEVPAGE1_CONF_SDTR_DISALLOWED;
-
-	return;
-}
-
-/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*	mptscsih_writeIOCPage4  - write IOC Page 4
  *	@hd: Pointer to a SCSI Host Structure
  *	@target_id: write IOC Page4 for this ID & Bus

