Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbUKVTW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUKVTW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKVTVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:21:00 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:62457
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262364AbUKVTTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:19:33 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Mon, 22 Nov 2004 19:19:32 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk> <20041122130202.GO10463@suse.de>
In-Reply-To: <20041122130202.GO10463@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411221919.32174.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 13:02, Jens Axboe wrote:

>
> I think the more correct patch is the following. It seems I was wrong in
> assuming that the ide_intr() path already waited 400ns for us, I think
> this should work for you. Can you test it?

Bad news - it didn't work.

It certainly looks as though it should - I am trying to find out what not.


>
> ===== drivers/ide/ide-iops.c 1.31 vs edited =====
> --- 1.31/drivers/ide/ide-iops.c 2004-11-01 18:06:50 +01:00
> +++ edited/drivers/ide/ide-iops.c 2004-11-22 13:59:27 +01:00
> @@ -476,10 +476,8 @@
>   if (drive->waiting_for_dma)
>    return hwif->ide_dma_test_irq(drive);
>
> -#if 0
>   /* need to guarantee 400ns since last command was issued */
> - udelay(1);
> -#endif
> + ndelay(400);
>
>  #ifdef CONFIG_IDEPCI_SHARE_IRQ
>   /*

-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
