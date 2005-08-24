Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVHXKBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVHXKBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVHXKBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:01:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19112 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750833AbVHXKBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:01:39 -0400
Date: Wed, 24 Aug 2005 11:01:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Frederik Schueler <fs@lowpingbastards.de>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050824100112.GA27216@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frederik Schueler <fs@lowpingbastards.de>,
	Patrick Mansfield <patmans@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050823112535.GB13391@mail.lowpingbastards.de> <20050823200040.GA8310@us.ibm.com> <20050824095520.GD13391@mail.lowpingbastards.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824095520.GD13391@mail.lowpingbastards.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:55:20AM +0200, Frederik Schueler wrote:
> Hello,
> 
> On Tue, Aug 23, 2005 at 01:00:40PM -0700, Patrick Mansfield wrote:
> > The use of scsiadd script implies that you are attaching or somehow
> > modifying the storage after the driver has loaded. Is that correct?
> 
> yes exactly, only the bootdrive LUN is registered after bootup. I have
> to selectively scsiadd the other LUNs if there is a gap between the 
> boot LUN (1-8 in our setup) and the shared storages (9-14). I don't
> consider this a bug though, I had to remove some devices otherwise, 
> and old drivers had to be patched to allow this at all.

Actually this sounds like a bug in your storage system.  It's probably
reporting to be only SCSI2 complicant, which doesn't make sense for
FC storage.  Please try the patch below:

Index: scsi-misc-2.6/drivers/scsi/scsi_devinfo.c
===================================================================
--- scsi-misc-2.6.orig/drivers/scsi/scsi_devinfo.c	2005-08-13 13:53:53.000000000 +0200
+++ scsi-misc-2.6/drivers/scsi/scsi_devinfo.c	2005-08-24 12:00:22.000000000 +0200
@@ -162,6 +162,7 @@
 	{"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
 	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
+	{"IFT", "A16F-R1211", NULL, BLIST_REPORTLUN2},
 	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
 	{"IOMEGA", "Io20S         *F", NULL, BLIST_KEY},
 	{"INSITE", "Floptical   F*8I", NULL, BLIST_KEY},
