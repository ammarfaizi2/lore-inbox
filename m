Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265307AbTLHCf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTLHCf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:35:58 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:44216 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265292AbTLHCfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:35:55 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16339.58195.71921.425034@wombat.chubb.wattle.id.au>
Date: Mon, 8 Dec 2003 13:34:59 +1100
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@osdl.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Can't disable IDE DMA on 2.6.0-test9 (patch)
In-Reply-To: <200312080239.58602.bzolnier@elka.pw.edu.pl>
References: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au>
	<200312080239.58602.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bartlomiej" == Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

Bartlomiej> On Friday 21 of November 2003 00:05, Peter Chubb wrote:
>> Hi Folks,

Bartlomiej> Hi,

>> If you try to disable IDE DMA from Kconfig, you'll end up with an
>> undefined symbol, ide_hwif_setup_dma().
>> 
>> The attached rather ugly patch fixes the problem by defining a
>> dummy function.

Bartlomiej> Not exactly.  Disable IDE DMA and enable support for every
Bartlomiej> PCI chipset.  Now try to compile... welcome to compile
Bartlomiej> time hell :-).

If you disable IDE_DMA, then the other chipset drivers cannot be
enabled --- the config system won't let you.
With IDE_DMA disabled and all chipsets disabled, I see:

drivers/built-in.o(.text+0x9f8bc): In function `ide_hwif_setup_dma':
: undefined reference to `ide_setup_dma'

And *that's* what my patch was supposed to fix.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
