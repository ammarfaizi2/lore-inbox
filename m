Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUF0DwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUF0DwW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 23:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267243AbUF0DwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 23:52:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50694 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S266543AbUF0DwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 23:52:21 -0400
Date: Sat, 26 Jun 2004 23:52:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pete Zaitcev <zaitcev@redhat.com>, <greg@kroah.com>, <arjanv@redhat.com>,
       <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>
Subject: Re: drivers/block/ub.c
In-Reply-To: <200406270046.53352.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0406262349200.28968-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Oliver Neukum wrote:

> Am Samstag, 26. Juni 2004 22:06 schrieb Pete Zaitcev:
> > +static int ub_submit_top_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
> > +{
> > +       struct ub_scsi_cmd *scmd;
> > +
> > +       scmd = &sc->top_rqs_cmd;
> > +
> > +       /* XXX Can be done at init */
> > +       scmd->cdb[0] = REQUEST_SENSE;
> > +       scmd->cdb_len = 6;
> > +       scmd->dir = UB_DIR_READ;
> > +       scmd->state = UB_CMDST_INIT;
> > +       scmd->data = sc->top_sense;
> 
> You must allocate a separate buffer to the sense data.
> We had similar code in hid which leads to data corruption
> on some architectures. It's an issue of DMA coherency.

I mentioned this some time ago to the SCSI maintainers.  They felt that it 
wasn't necessary to allocate a separate buffer for the sense data -- I'm 
not sure why.  Apparently most if not all SCSI drivers fail to do this.  
Usb-storage doesn't do it either; maybe we should.

Alan Stern

