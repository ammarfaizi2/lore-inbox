Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbQLZIKQ>; Tue, 26 Dec 2000 03:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbQLZIJz>; Tue, 26 Dec 2000 03:09:55 -0500
Received: from [24.65.192.120] ([24.65.192.120]:20980 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S130026AbQLZIJq>;
	Tue, 26 Dec 2000 03:09:46 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012260739.eBQ7dFH25619@webber.adilger.net>
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
In-Reply-To: <20001226002944.A6058@convergence.de> "from Felix von Leitner at
 Dec 26, 2000 00:29:44 am"
To: Felix von Leitner <leitner@convergence.de>
Date: Tue, 26 Dec 2000 00:39:15 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner writes:
> I bought 4 ATA-100 Maxtor drives and put them on a Promise Ultra100
> controller to make a single striping RAID of them to increase
> throughput.
> 
> I wrote a small test program that simply reads stdin linearly and
> displays the throughput. Here are the results of my test program:
>   # rb < /dev/ide/host2/bus0/target0/lun0/part1
>   27.8 meg/sec
>   # rb < /dev/ide/host2/bus0/target0/lun0/part1
>   26.8 meg/sec
> 
> Here is the result of my test program on the strip set:
>   # rb < /dev/md/0
>   30.3 meg/sec

>   hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
>   hdf: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
>   hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
>   hdh: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)

That's because IDE doesn't allow multiple requests on the same bus, unlike
SCSI.  That's why IDE disks on the same bus are "master" and "slave".  If
you look at the 3ware IDE RAID systems, each drive has its own IDE bus.
Maybe try a stripe set on only two disks, hde and hdg, and see how it works.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
