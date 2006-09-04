Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWIDKs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIDKs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWIDKs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:48:27 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:54225 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750704AbWIDKsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:48:25 -0400
Date: Mon, 4 Sep 2006 12:46:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Helge Hafting <helge.hafting@aitel.hist.no>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
In-Reply-To: <44FBFFFC.90309@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0609041242350.17115@yvahk01.tjqt.qr>
References: <44FB5AAD.7020307@perkel.com> <44FBD08A.1080600@tls.msk.ru>
 <44FBF62A.1010900@aitel.hist.no> <44FBFFFC.90309@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I thought kernel data weren't swapped at all?

If the swap code was swapped, who would swap it in again?

>Well, it's not that simple.  Kernel uses both swappable and
>non-swappable memory internally.  For some things, it's
>unswappable, for some, it's swappable.  In general, it's
>impossible to say which parts of kernel will break (and
>in wich ways) if swap goes havoc.

In general, everything you type in as C code (.bss, .data, .text) should be 
unswappable. kmalloc()ed areas are resident too, and kmalloc has a 
parameter which defines whether the allocation can/cannot push userspace 
pages into the swap (GFP_ATOMIC/GFP_IO). So if there is some 
kernel-allocation swapped out, it is most likely to be marked as 
'userspace' so that the same algorithms can be used for swapin and -out.


Jan Engelhardt
-- 

-- 
VGER BF report: H 5.48632e-07
