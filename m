Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTH0PTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbTH0PTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:19:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45536 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263438AbTH0PTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:19:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Promise IDE patches
Date: Wed, 27 Aug 2003 17:20:06 +0200
User-Agent: KMail/1.5
Cc: Jan Niehusmann <jan@gondor.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030826223158.GA25047@gondor.com> <200308270054.27375.bzolnier@elka.pw.edu.pl> <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271720.06382.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 of August 2003 16:59, Alan Cox wrote:
> On Maw, 2003-08-26 at 23:54, Bartlomiej Zolnierkiewicz wrote:
> > Thanks Jan.
> >
> > Marcelo can you apply these patches?
>
> The first one of these is wrong too. It'll stop some people from
> being able to access existing file systems. This has to be fixed
> properly (in both 2.4 and 2.6) to distinguish between
> "Can PIO LBA48" "Can DMA LBA48" and "no LBA48". The latter being
> basically non existant.
>
> If you fail to do this then existing PIO LBA48 setups will just die
> on boot.

Alan, its not true.  Please check with ide-disk.c.
If hwif->addressing is 1 then probe_lba_addressing() wont set
drive->addressing to 1 and therefore you wont get LBA48
(both PIO and DMA) because of drive->addressing check
insided __ide_do_rw_disk().

Its not complete fix but it doesnt break anything and stops fs corruption.

--bartlomiej

