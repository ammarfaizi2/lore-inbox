Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUFZWpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUFZWpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUFZWpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:45:53 -0400
Received: from mail1.kontent.de ([81.88.34.36]:49867 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266520AbUFZWpw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:45:52 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 00:46:53 +0200
User-Agent: KMail/1.6.2
Cc: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, <stern@rowland.harvard.edu>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
In-Reply-To: <20040626130645.55be13ce@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406270046.53352.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 26. Juni 2004 22:06 schrieb Pete Zaitcev:
> +static int ub_submit_top_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
> +{
> +       struct ub_scsi_cmd *scmd;
> +
> +       scmd = &sc->top_rqs_cmd;
> +
> +       /* XXX Can be done at init */
> +       scmd->cdb[0] = REQUEST_SENSE;
> +       scmd->cdb_len = 6;
> +       scmd->dir = UB_DIR_READ;
> +       scmd->state = UB_CMDST_INIT;
> +       scmd->data = sc->top_sense;

You must allocate a separate buffer to the sense data.
We had similar code in hid which leads to data corruption
on some architectures. It's an issue of DMA coherency.
 
> +       scmd->len = SENSE_SIZE;
> +       scmd->done = ub_top_sense_done;
> +       scmd->back = cmd;
> +
> +       scmd->tag = sc->tagcnt++;
> +       return ub_submit_scsi(sc, scmd);
> +}

	Regards
		Oliver
