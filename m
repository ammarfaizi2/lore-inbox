Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbUC3Qn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUC3Qn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:43:26 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:10507
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263740AbUC3QnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:43:20 -0500
Date: Tue, 30 Mar 2004 08:38:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
In-Reply-To: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually this issue an errata correction in ATA-6 and changed in ATA-7.

48-bit command set support is different than capacity.

A fix that address the erratium is prefered, just need to take some time
to read it.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 30 Mar 2004, Geert Uytterhoeven wrote:

> 
> Apparently some IDE drives (e.g. a pile of 80 GB ST380020ACE drives I have
> access to) advertise to support LBA48, but don't, causing kernels that support
> LBA48 (i.e. anything newer than 2.4.18, including 2.4.25 and 2.6.4) to fail on
> them.  Older kernels (including 2.2.20 on the Debian woody CDs) work fine.
> 
> One problem with those drives is that the lba_capacity_2 field in their drive
> identification is set to 0, making the IDE driver think the disk is 0 bytes
> large. At first I tried modifying the driver to use lba_capacity if
> lba_capacity_2 is set to 0, but this caused disk errors. So it looks like those
> drives don't support the increased transfer size of LBA48 neither.
> 
> I added a workaround for these drives to both 2.4.25 and 2.6.4. I'll send
> patches in follow-up emails.
> 
> BTW, this problem (incl. a small patch to fix it for 2.4.19, which doesn't work
> on 2.4.25 anymore) was reported a while ago by JunHyeok Heo, cfr.
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-42/0312.html
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 

