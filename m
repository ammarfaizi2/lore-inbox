Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSACMfV>; Thu, 3 Jan 2002 07:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287206AbSACMfM>; Thu, 3 Jan 2002 07:35:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65036 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287205AbSACMez>;
	Thu, 3 Jan 2002 07:34:55 -0500
Date: Thu, 3 Jan 2002 13:34:34 +0100
From: Jens Axboe <axboe@suse.de>
To: R.Oehler@GDImbH.com
Cc: Scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Marcelo <marcelo@conectiva.com.br>
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
Message-ID: <20020103133434.B6267@suse.de>
In-Reply-To: <XFMail.20020103130541.R.Oehler@GDImbH.com> <20020103130941.B1027@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103130941.B1027@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


seeing an older post on linux-scsi, you might want to retry your test
with the aic7xxx nseg bug fixed. this is against 2.4.17, haven't checked
if it's applied in 2.4.18-pre1 -- if not, Marcelo please apply.

--- drivers/scsi/aic7xxx/aic7xxx_linux.c~	Thu Jan  3 13:32:33 2002
+++ drivers/scsi/aic7xxx/aic7xxx_linux.c	Thu Jan  3 13:33:00 2002
@@ -1703,6 +1703,7 @@
 			       cmd->request_buffer,
 			       cmd->request_bufflen,
 			       scsi_to_pci_dma_dir(cmd->sc_data_direction));
+			scb->sg_count = 0;
 			scb->sg_count = ahc_linux_map_seg(ahc, scb,
 							  sg, addr,
 							  cmd->request_bufflen);


-- 
Jens Axboe

