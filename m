Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUF0X5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUF0X5V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 19:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUF0X5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 19:57:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11162 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264543AbUF0X5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 19:57:20 -0400
Date: Sun, 27 Jun 2004 16:57:13 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: tburke@redhat.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       <stern@rowland.harvard.edu>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com
Subject: Re: drivers/block/ub.c
Message-Id: <20040627165713.1a265ce7@lembas.zaitcev.lan>
In-Reply-To: <mailman.1088290201.14081.linux-kernel2news@redhat.com>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<mailman.1088290201.14081.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 00:46:53 +0200
Oliver Neukum <oliver@neukum.org> wrote:

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

I agree. This is also an issue for the work_bcs. I postponed doing it
right because that area waits for changes regarding queueing and
error processing in such case.

-- Pete
