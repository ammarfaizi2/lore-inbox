Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWHMNF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWHMNF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 09:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWHMNF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 09:05:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:26307 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751216AbWHMNF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 09:05:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id;
        b=LSJEEglaE8JHgy1rTbvYngzLdF4/BaX4i57UVeK6ksrvUImEYpP7haon5pLtiPW6dMn86sPtL48IfK5AGufDrhz05E6KzNqc+IPeTR5kQtxpP1MwDVQFf2AwkVm6siLEyUizI8fSA7pIZ7tLInlyd6FZnbEZdUGMVIYKDqV7tmQ=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/4] aic7xxx: remove excessive inlining
Date: Sun, 13 Aug 2006 15:05:49 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200608131457.21951.vda.linux@googlemail.com> <200608131502.10664.vda.linux@googlemail.com> <200608131503.07987.vda.linux@googlemail.com>
In-Reply-To: <200608131503.07987.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tOy3E9ALqzrmxIZ"
Message-Id: <200608131505.49995.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tOy3E9ALqzrmxIZ
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 13 August 2006 15:03, Denis Vlasenko wrote:
> On Sunday 13 August 2006 15:02, Denis Vlasenko wrote:
> > Basically, patches deinline some functions, mainly those
> > which perform port I/O.
> 
> ahd_suspend/resume are not used. #ifdef them out.

I forgot to attach the file. :(
--
vda

--Boundary-00=_tOy3E9ALqzrmxIZ
Content-Type: text/x-diff;
  charset="koi8-r";
  name="3.UNUSED.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3.UNUSED.diff"

diff -urpN -U4 linux-2.6.17.8.aic2/drivers/scsi/aic7xxx/aic79xx_core.c linux-2.6.17.8.aic3/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.6.17.8.aic2/drivers/scsi/aic7xxx/aic79xx_core.c	2006-08-13 12:01:38.000000000 +0200
+++ linux-2.6.17.8.aic3/drivers/scsi/aic7xxx/aic79xx_core.c	2006-08-13 12:01:42.000000000 +0200
@@ -7681,8 +7681,9 @@ ahd_pause_and_flushwork(struct ahd_softc
 
 	ahd->flags &= ~AHD_ALL_INTERRUPTS;
 }
 
+#ifdef UNUSED
 int
 ahd_suspend(struct ahd_softc *ahd)
 {
 
@@ -7704,16 +7705,17 @@ ahd_resume(struct ahd_softc *ahd)
 	ahd_intr_enable(ahd, TRUE); 
 	ahd_restart(ahd);
 	return (0);
 }
+#endif
 
 /************************** Busy Target Table *********************************/
 /*
  * Set SCBPTR to the SCB that contains the busy
  * table entry for TCL.  Return the offset into
  * the SCB that contains the entry for TCL.
  * saved_scbid is dereferenced and set to the
- * scbid that should be restored once manipualtion
+ * scbid that should be restored once manipulation
  * of the TCL entry is complete.
  */
 static u_int
 ahd_index_busy_tcl(struct ahd_softc *ahd, u_int *saved_scbid, u_int tcl)

--Boundary-00=_tOy3E9ALqzrmxIZ--
