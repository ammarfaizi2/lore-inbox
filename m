Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKSXPx>; Sun, 19 Nov 2000 18:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKSXPn>; Sun, 19 Nov 2000 18:15:43 -0500
Received: from [213.8.184.104] ([213.8.184.104]:11524 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129308AbQKSXPd>;
	Sun, 19 Nov 2000 18:15:33 -0500
Date: Mon, 20 Nov 2000 00:41:51 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Taisuke Yamada <tai@imasy.or.jp>
cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using
 oldBIOS
In-Reply-To: <200011192213.eAJMDPO02395@research.imasy.or.jp>
Message-ID: <Pine.LNX.4.21.0011200036030.775-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Taisuke Yamada wrote:

> > This patch is not good. It compiles, but when I boot the kernel, it
> > decides to ignore the hdc=5606,255,63 parameter that I pass to the kernel,
> > and limits the number of sectors to fill 8.4GB.
> 
> Please retest with hdc=... parameter removed. If hd[a-z]=...
> parameter is specified, my patch will be disabled, trusting
> whatever user has specified.
> 

Ok, I've booted without the parameter, and without the jumper on clipping
mode (I'll do it tommorow, it's 1AM now) got something similiar to what
you've written, and everything looks ok.

BTW, I have created the paratition table and all paratitions when the
drive reported 90069840 sectors. Now it reports 90069839 - one sector
less. Any damage risk to my filesystems?

dmesg:

hdc: host protected area => 1
hdc: checking for max native LBA...
hdc: max native LBA is 90069839
hdc: (un)clipping max LBA...
hdc: max LBA (un)clipped to 90069839
hdc: lba = 1, cap = 90069839
hdc: 90069839 sectors (46116 MB) w/1916KiB Cache, CHS=89354/16/63, UDMA(33)
Partition check:
 hdc: [PTBL] [5606/255/63] hdc1 hdc2 hdc3 hdc4 < hdc5 >

>   hda: host protected area => 1
>   hda: checking for max native LBA...
>   hda: max native LBA is 90045647
>   hda: (un)clipping max LBA...
>   hda: max LBA (un)clipped to 90045647
>   hda: lba = 1, cap = 90045647
>   hda: 90045647 sectors (46103 MB) w/2048KiB Cache, CHS=89330/16/63, UDMA(33)
>   hdc: host protected area => 1
>   hdc: checking for max native LBA...
>   hdc: max native LBA is 90045647
>   hdc: (un)clipping max LBA...
>   hdc: max LBA (un)clipped to 90045647
>   hdc: lba = 1, cap = 90045647
>   hdc: 90045647 sectors (46103 MB) w/2048KiB Cache, CHS=89330/16/63, UDMA(33)

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
