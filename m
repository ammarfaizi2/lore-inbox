Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTH0VWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTH0VWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:22:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35745 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262271AbTH0VWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:22:49 -0400
Subject: Re: [PATCH] Backport recent IDE updates, take 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030827203913.GA1699@codepoet.org>
References: <20030817061225.GA17621@codepoet.org>
	 <20030822221109.GB3802@codepoet.org>
	 <1061998505.22721.54.camel@dhcp23.swansea.linux.org.uk>
	 <20030827203913.GA1699@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062019254.23493.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 22:20:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-27 at 21:39, Erik Andersen wrote:
>                 if (drive->addressing == 0 && drive->capacity64 > (1ULL)<<28) {
>                         /* FIXME:  most controllers that won't do LBA48 with
>                          * DMA will do it via PIO so we ought to implement a
>                          * PIO fallback...   For now, punt and limit the drive
>                          * to 128 GiB to prevent bad things from happening... */
>                         drive->capacity64 = (1ULL)<<28;
>                 }
> 	}
> 
> This is not sufficient?

Its sufficient to stop bad things happening, its not sufficient to get
the desired end user result of being able to read their disk if it moved
controller. Bartlomiej pointed out that because of the other traps the
problem doesn't occur right now except moving a disk.

I'll post an additional diff tomorrow which adds hwif->dma_addressing
(or dma_lba48 given the changes to naming people seem to prefer) so that
can get fixed.

