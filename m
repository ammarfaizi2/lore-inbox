Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317846AbSGPONR>; Tue, 16 Jul 2002 10:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317847AbSGPONQ>; Tue, 16 Jul 2002 10:13:16 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:14863 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317846AbSGPONP>; Tue, 16 Jul 2002 10:13:15 -0400
Date: Tue, 16 Jul 2002 15:15:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: James.Bottomley@steeleye.com, lmb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020716151556.A13538@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joerg Schilling <schilling@fokus.gmd.de>,
	James.Bottomley@steeleye.com, lmb@suse.de,
	linux-kernel@vger.kernel.org
References: <200207161406.g6GE6tYh021918@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207161406.g6GE6tYh021918@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Tue, Jul 16, 2002 at 04:06:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 04:06:55PM +0200, Joerg Schilling wrote:
> Just a hint: the block layer is for caching blocks from disk type deveices.
> 
> -	Block device access is always going directly into the block cache.
> 	So the I/O is always kernel I/O. In addition, it is async I/O - the 
> 	block layer fires it up and may wait for it later after sending out other
> 	requests.
> 
> -	Character device access is synchronous access and may be either kernel
> 	or user space DMA access. In most cases, it is user space DMA access.
> 
> How try to ask your question again...

The discussion would be much easier if you got the terminology right.
The linux block layer does no caching at all, the caching of the block device
nodes is handles by the page (>= 2.4.10) or buffer (<= 2.4.9) cache.

> >That is not true. Late IDE also has this, and systems like drbd - which
> >currently uses a quite clever heuristic to deduce barriers - could also
> >utilize this input.
> 
> How is it implemented?

RTFS: drivers/ide/tcq.c (in 2.5)

