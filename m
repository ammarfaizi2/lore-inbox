Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRJaIep>; Wed, 31 Oct 2001 03:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279689AbRJaIef>; Wed, 31 Oct 2001 03:34:35 -0500
Received: from 119.ppp1-4.ski.worldonline.dk ([212.54.90.247]:23680 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S279277AbRJaIeU>; Wed, 31 Oct 2001 03:34:20 -0500
Date: Wed, 31 Oct 2001 09:33:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Dan Maas <dmaas@dcine.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes (was Re: BUG() in asm/pci.h:142 with 2.4.13)
Message-ID: <20011031093353.F631@suse.de>
In-Reply-To: <fa.cdhetrv.1828dgd@ifi.uio.no> <fa.j17q3gv.m6e1ju@ifi.uio.no> <022401c16164$21a945d0$1a01a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022401c16164$21a945d0$1a01a8c0@allyourbase>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30 2001, Dan Maas wrote:
> > Can people try out this patch?  I believe this will fix the bug.
> > + tb->sg[0].page = NULL;
> >   if (tb->sg[segs].address == NULL) {
> 
> For the sake of making this clear to other kernel hackers (I got bitten by
> it too) - starting with 2.4.13 you must zero out the fields of struct
> scatterlist that you are not using. i.e. it is no longer sufficient to
> simply set sg.address and sg.length, because junk might still be present in
> the new sg.page field, and pci_map_*() will BUG() if both sg.address and
> sg.page are non-zero.

True, perhaps we should add a init_sg or something like that.

-- 
Jens Axboe

