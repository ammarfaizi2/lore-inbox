Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311024AbSC2TMN>; Fri, 29 Mar 2002 14:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311614AbSC2TMD>; Fri, 29 Mar 2002 14:12:03 -0500
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:16058 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S311024AbSC2TLv>; Fri, 29 Mar 2002 14:11:51 -0500
Message-ID: <3CA4BC6B.EAEB4364@wanadoo.fr>
Date: Fri, 29 Mar 2002 20:11:39 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4-ac3 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac[23] do not boot
In-Reply-To: <E16qz6l-0001Ud-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reverted the 1st change with the same result : the system hang
I've reverted the 2nd change and then the system boot fine

-------
Regards
	Jean-Luc

Alan Cox wrote:
> 
> > 2.4.19-pre4-ac[23] does not boot. I've not tested ac1 but vanilla pre4
> > works.
> 
> Can you try backing out the following two changes, one at a time. These are
> the only ALi specific changes. So firstly I want to see if its an ALi or
> core IDE bug
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.19p4/drivers/ide/alim15x3.c linux.19pre4-ac3/drivers/ide/alim15x3.c
> --- linux.19p4/drivers/ide/alim15x3.c   Mon Mar 25 17:47:11 2002
> +++ linux.19pre4-ac3/drivers/ide/alim15x3.c     Tue Mar 26 18:36:23 2002
> @@ -248,7 +248,7 @@
>         byte s_clc, a_clc, r_clc;
>         unsigned long flags;
>         int bus_speed = system_bus_clock();
> -       int port = hwif->index ? 0x5c : 0x58;
> +       int port = hwif->channel ? 0x5c : 0x58;
>         int portFIFO = hwif->channel ? 0x55 : 0x54;
>         byte cd_dma_fifo = 0;
> 
> @@ -442,6 +442,8 @@
>         ide_dma_action_t dma_func       = ide_dma_on;
>         byte can_ultra_dma              = ali15x3_can_ultra(drive);
> 
> +       (void) config_chipset_for_pio(drive);
> +
>         if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
>                 return hwif->dmaproc(ide_dma_off_quietly, drive);
>
