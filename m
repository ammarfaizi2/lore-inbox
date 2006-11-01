Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752256AbWKASZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbWKASZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbWKASZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:25:21 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5322 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1752256AbWKASZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:25:19 -0500
Date: Wed, 01 Nov 2006 19:25:04 +0100
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: jens.axboe@oracle.com
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: SCSI over USB showstopper bug?
Message-ID: <4548e680.oVsI92sKYOz7VSzN%Joerg.Schilling@fokus.fraunhofer.de>
References: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de>
 <1162333090.3044.53.camel@laptopd505.fenrus.org>
 <4547e164.k3W0GpiCAd3p3Tkh%Joerg.Schilling@fokus.fraunhofer.de>
 <20061101153128.GM13555@kernel.dk>
In-Reply-To: <20061101153128.GM13555@kernel.dk>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> wrote:

> > > > it looks as if SG_GET_RESERVED_SIZE & SG_SET_RESERVED_SIZE
> > > > are not in interaction with the underlying SCSI transport.
> > > > 
> > > > Programs like readcd and cdda2wav that try to get very large SCSI
> > > > transfer buffers get a confirmation for nearly any SCSI transfer size 
> > > > but later when readcd/cdda2wav try to transfer data with an
> > > > actual SCSI command, they fail with ENOMEM.
> > > > 
> > > > Correct fix: let sg.c make a callback to the underlying SCSI transport
> > > > 		and let it get a confirmation tfor the buffer size.
> > > > 
> > > > Quick and dirty fix: reduce the maximum allowed DMA size to the smallest
> > > > 		max DMA size of all SCSI transports.
> > >
> > > real good fix:
> > >
> > > use SG_IO on the device directly that checks this already
> > 
> > From looking into the source, this claim seems to be wrong.
>
> The block layer SG_IO entry point does what Arjan describes - it checks
> the queue settings, which must match the hardware limits. It needs to,
> since it won't accept a command larger than what the path to that device
> will allow in one go. The SCSI sg variant may be more restricted, since
> it should handle partial completions of such commands.

Then someone should change the source to match this statements.

>From a report I have from the k3b Author, readcd and cdda2wav only work
if you add a "ts=128k" option. 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
