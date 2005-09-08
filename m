Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVIHUkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVIHUkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVIHUkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:40:18 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:9108 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751265AbVIHUkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:40:17 -0400
Date: Thu, 8 Sep 2005 16:40:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jim Ramsay <jim.ramsay@gmail.com>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       <linux-usb-users@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
In-Reply-To: <4789af9e05090813287f05e12a@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0509081637410.4545-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Jim Ramsay wrote:

> More information:
> 
> The error only occurrs during device sensing when the
> srb->request_buffer is assigned as follows, by usb/storage/transport.c
> in the routine usb_stor_invoke_transport:
> 
> old_request_buffer = srb->request_buffer;
> srb->request_buffer = srb->sense_buffer;
> 
> Now, this is a problem because srb->sense_buffer is defined as follows
> in the struct scsi_cmnd:
> 
> #define SCSI_SENSE_BUFFERSIZE   96
>         unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];
> 
> Since it is not allocated at runtime there is NO WAY the SCSI layer
> can possibly guarantee it is page- or cache-aligned and ready for DMA.
> 
> Any suggestions on best fix for this?  Is it still a SCSI-layer issue?
>  Or should USB step up in this case and ensure this buffer is dma-safe
> itself?

Aha!

I've long thought that usb-storage should allocate its own transfer buffer 
for sense data.  In the past people have said, "No, don't bother, it's not 
really needed."  Here's a good reason for doing it.

Expect a patch before long.

Alan Stern

