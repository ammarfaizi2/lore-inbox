Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRBTJsK>; Tue, 20 Feb 2001 04:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBTJsA>; Tue, 20 Feb 2001 04:48:00 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:48096 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129191AbRBTJry>; Tue, 20 Feb 2001 04:47:54 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200102200947.KAA02817@sunrise.pg.gda.pl>
Subject: Re: [IDE] meaningless #ifndef?
To: pozsy@sch.bme.hu (Pozsar Balazs)
Date: Tue, 20 Feb 2001 10:47:41 +0100 (MET)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.GSO.4.30.0102192252130.7963-100000@balu> from "Pozsar Balazs" at Feb 19, 2001 10:57:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pozsar Balazs wrote:"
> from drivers/ide/ide-features.c:
> 
> /*
>  *  All hosts that use the 80c ribbon mus use!
>  */
> byte eighty_ninty_three (ide_drive_t *drive)
> {
>         return ((byte) ((HWIF(drive)->udma_four) &&
> #ifndef CONFIG_IDEDMA_IVB
>                         (drive->id->hw_config & 0x4000) &&
> #endif /* CONFIG_IDEDMA_IVB */
>                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
> }
> 
> If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
> defined or not.

No, it is not the same. But it duplicates the test when CONFIG_IDEDMA_IVB
is not set. If both tests are done and the first is true, the second also
must be true. If the first is false, the second is meaningless.
Maybe the above code should be:

        return ((byte) ((HWIF(drive)->udma_four) &&
#ifndef CONFIG_IDEDMA_IVB
                        (drive->id->hw_config & 0x4000)
#else
                        (drive->id->hw_config & 0x6000)
#endif /* CONFIG_IDEDMA_IVB */
			) ? 1 : 0);

Just my 0.03 PLN... 
--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

