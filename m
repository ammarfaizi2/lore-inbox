Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136361AbREIMfD>; Wed, 9 May 2001 08:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136365AbREIMex>; Wed, 9 May 2001 08:34:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136361AbREIMeq>; Wed, 9 May 2001 08:34:46 -0400
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
To: tleete@mountain.net (Tom Leete)
Date: Wed, 9 May 2001 13:38:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3AF92C24.DD8F8660@mountain.net> from "Tom Leete" at May 09, 2001 07:38:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xTEi-0002E9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trace; ffff037f <END_OF_CODE+3fcfb2ab/????>
> Trace; ffff0000 <END_OF_CODE+3fcfaf2c/????>
> Trace; ffff0000 <END_OF_CODE+3fcfaf2c/????>
> Trace; ffff0720 <END_OF_CODE+3fcfb64c/????>

Lets ignore the crap above..

> Trace; c01b956a <ide_build_dmatable+2a/120>
> Trace; c01b3fb5 <ide_set_handler+55/60>
> Trace; c01b9aca <ide_dmaproc+11a/210>
> Trace; c01b9380 <ide_dma_intr+0/b0>
> Trace; c01b9940 <dma_timer_expiry+0/70>
> Trace; c01bd457 <do_rw_disk+257/300>
> Trace; c01b4d2a <ide_wait_stat+7a/e0>
> Trace; c01b5010 <start_request+160/210>
> Trace; c01b51ff <ide_do_request+10f/340>

We seem to be several layers into recursive use of the ide driver - which 
shouldnt happen. In fact if these are the same interface the second dmatable 
build would leave HWIF(drive)->sg_table wrong.

> Trace; c01866ce <__make_request+4ae/6f0>
> Trace; c01866e6 <__make_request+4c6/6f0>
> Trace; c01b956a <ide_build_dmatable+2a/120>
> Trace; c01b3fb5 <ide_set_handler+55/60>
