Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTK2OWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 09:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTK2OWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 09:22:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59021 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263528AbTK2OWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 09:22:10 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: John Goerzen <jgoerzen@complete.org>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Sat, 29 Nov 2003 15:23:37 +0100
User-Agent: KMail/1.5.4
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <200311281400.55500.bzolnier@elka.pw.edu.pl> <20031129015230.GA3124@complete.org>
In-Reply-To: <20031129015230.GA3124@complete.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311291523.37651.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It means two things:

(a) There is a bug in drivers/ide/pci/pdc202xx_new.c:init_hwif_pdc202new(),
    hwif->autodma shouldn't be set to 0 or "idex=dma" parameter won't work.

(b) If you don't use autodma you have to tune desired mode _explicitly_ first,
    because most of ->ide_dma_check() implementations (for pdc202xx_new.c
    it is pdcnew_config_drive_xfer_rate()) check for hwif->autodma.

--bart

On Saturday 29 of November 2003 02:52, John Goerzen wrote:
> On Fri, Nov 28, 2003 at 02:00:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > My mistake, it should have been -Xudma5 :-).
>
> I tried the ide2=dma in the kernel and then:
>
> hdparm -d 1 -u 1 -X 69 /dev/hde
>
> That did seem to solve the problem.  Output of hdparm after that
> command:
>
> pi:~# hdparm /dev/hde
>
> /dev/hde:
>  multcount    = 16 (on)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 19929/255/63, sectors = 320173056, start = 0
>
> What does that mean?

