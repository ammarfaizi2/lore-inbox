Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSGFXlr>; Sat, 6 Jul 2002 19:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGFXlq>; Sat, 6 Jul 2002 19:41:46 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:31981 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314078AbSGFXlp>; Sat, 6 Jul 2002 19:41:45 -0400
Date: Sat, 6 Jul 2002 17:44:21 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: B.Zolnierkiewicz@elka.pw.edu.pl
Message-ID: <Pine.LNX.4.44.0207061734500.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a small question about IDE 96: in __ata_end_request(), we do

	spin_lock_irqsave(ch->lock, flags);

	BUG_ON(!(rq->flags & REQ_STARTED));

Shouldn't we rather flip these two, or much rather move 
spin_lock_irqsave() even more down, below

	if (!nr_secs)
		nr_secs = rq->hard_cur_sectors;

since it hasn't got any use to hold a spin lock until the udma_enable & 
co.? However, I'd at least move it below the BUG_ON().

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

