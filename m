Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTELTaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTELTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:30:00 -0400
Received: from havoc.daloft.com ([64.213.145.173]:40382 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262623AbTELT36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:29:58 -0400
Date: Mon, 12 May 2003 15:42:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512194243.GC10089@gtf.org>
References: <785F348679A4D5119A0C009027DE33C102E0D31A@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D31A@mcoexc04.mlm.maxtor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:58:10AM -0600, Mudama, Eric wrote:
> The only difference between SATA TCQ and PATA TCQ is that in PATA TCQ, the
> drive doesn't report the active tag bitmap back to the host after each
> command.  Other than that they are functionally identical to my
> understanding.  (Yes, there are options like first-party DMA, but these are
> not requirements)

That's from the "drive side."  From the OS side, the ideal
implementation isn't here yet :)

Ideally there is a DMA ring of taskfiles and scatterlists.  The OS
(producer) queues these up asynchrously, and the host+devices
(consumer) executes the taskfiles in the ring.  AHCI does this.

With PATA TCQ, we only have a single scatterlist, and are forced to
have more OS-side infrastructure for command queueing, processing, etc.

As an aside, as drives and hosts get faster, we will actually want
_fewer_ interrupts (i.e. interrupt coalescing).

All this points to making the host smarter.
The drives are already pretty damn smart ;-)

	Jeff



