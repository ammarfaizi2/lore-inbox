Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992615AbWKAP3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992615AbWKAP3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992614AbWKAP3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:29:42 -0500
Received: from brick.kernel.dk ([62.242.22.158]:5385 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S2992615AbWKAP3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:29:41 -0500
Date: Wed, 1 Nov 2006 16:31:28 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Cc: arjan@infradead.org, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: SCSI over USB showstopper bug?
Message-ID: <20061101153128.GM13555@kernel.dk>
References: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de> <1162333090.3044.53.camel@laptopd505.fenrus.org> <4547e164.k3W0GpiCAd3p3Tkh%Joerg.Schilling@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547e164.k3W0GpiCAd3p3Tkh%Joerg.Schilling@fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01 2006, Joerg Schilling wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > On Tue, 2006-10-31 at 23:08 +0100, Joerg Schilling wrote:
> > > Hi,
> > > 
> > > it looks as if SG_GET_RESERVED_SIZE & SG_SET_RESERVED_SIZE
> > > are not in interaction with the underlying SCSI transport.
> > > 
> > > Programs like readcd and cdda2wav that try to get very large SCSI
> > > transfer buffers get a confirmation for nearly any SCSI transfer size 
> > > but later when readcd/cdda2wav try to transfer data with an
> > > actual SCSI command, they fail with ENOMEM.
> > > 
> > > Correct fix: let sg.c make a callback to the underlying SCSI transport
> > > 		and let it get a confirmation tfor the buffer size.
> > > 
> > > Quick and dirty fix: reduce the maximum allowed DMA size to the smallest
> > > 		max DMA size of all SCSI transports.
> >
> > real good fix:
> >
> > use SG_IO on the device directly that checks this already
> 
> From looking into the source, this claim seems to be wrong.

The block layer SG_IO entry point does what Arjan describes - it checks
the queue settings, which must match the hardware limits. It needs to,
since it won't accept a command larger than what the path to that device
will allow in one go. The SCSI sg variant may be more restricted, since
it should handle partial completions of such commands.

-- 
Jens Axboe

