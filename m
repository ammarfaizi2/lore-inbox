Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275085AbTHQIwp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275091AbTHQIwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:52:44 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:59019 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275085AbTHQIwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:52:42 -0400
Subject: Re: [PATCH] 8/8 Backport recent 2.6 IDE updates to 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030817061410.GI17621@codepoet.org>
References: <20030817061410.GI17621@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061110328.21502.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 09:52:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 07:14, Erik Andersen wrote:
> This patch limits drive capacity to 137GB if host doesn't support
> LBA48.  This fixes some serious problems (see the recent thread on
> "uncorrectable ext2 errors").

Already fixed in -ac, but this fix cleans up other stuff too

> This also kills the probe_lba_addressing() wrapper, and renames
> "hwif->addressing" to "hwif->no_lba48".  This is because
> "hwif->addressing" is way too similar to "drive->addressing"
> which has a totally different meaning.

Partly ejected, see the FIXME note in the ac3 tree. When playing with
this I found we actually need two different hwif things for each size,
so that we can handle the fact most controllers are PIO capable for
LBA48 even if not DMA capable.

Its actually really important we do fix this properly because someone
using a disk in PIO mode will suddenely find that the update stops
them from using their filesystem any more.

no_lba48 is questionable given the existance of higher modes but either
way we definitely need both "lba48" "lba48_dma"

Other patches look fine and I'll merge them. I'd like to hear Andries
and Bartlomiej views on how we deal with the lba48 pio only case 

Alan

