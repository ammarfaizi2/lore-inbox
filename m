Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315795AbSEJEIG>; Fri, 10 May 2002 00:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315796AbSEJEIF>; Fri, 10 May 2002 00:08:05 -0400
Received: from ns.neureal.com ([64.29.18.145]:58377 "HELO mail2.neureal.com")
	by vger.kernel.org with SMTP id <S315795AbSEJEIF>;
	Fri, 10 May 2002 00:08:05 -0400
Message-ID: <003301c1f7d8$2653b060$050010ac@niunia.org>
From: "Artur Jasowicz" <arturj@mousebusiness.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Pieter Hollants" <pieter@hollants.com>
In-Reply-To: <001701c1f79e$50349000$c264a8c0@hoytpub.com> <4171.192.168.0.20.1020979544.squirrel@mail.fra.hollants.com>
Subject: Re: Fw: DriveReady SeekComplete problems
Date: Thu, 9 May 2002 23:06:39 -0500
Organization: mousebusiness.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I did something along these lines early on in testing. I had four
diferent drives plugged in. I had one 6GB, two 80GB and one 160GB. I've
tried doing dd if=/dev/hd... of=/dev/null. This was with DMA on. Everything
seemed to work fine with up to three drives, but after I've issused above
command for the fourth drive, I started getting errror messages. Now, to my
knowledge I'm not using a Highpoint driver. I'm just letting Kernel detect
whatever it sees and use it.

Today, I've tried mkraid on 4-drive config. With DMA disabled it seemed to
work without errors at miserable 500K/s reported by /proc/mdstat. Even my
old K6-2 333 with four 80GB on two IWills ran at 800+K/s. You would expect
more from a dual 2GHz. With DMA enabled I got 2000K/s with log full of the
same errors again.

Another odd thing is that both CPUs are running at 99% usage when trying to
sync array. Strange for 4GHz total clock speed. I was expecting that such
fast CPU's would barely break the sweat doing IDE I/O.

Any other IDE controllers I should be looking at?

Artur

From: Pieter Hollants <pieter@hollants.com>
> I'd say it's a driver problem (had nothing but trouble with Highpoint
> myself).
> To verify this: try creating an ordinary partition on one of the disks and
> do some mass copying & reading onto it, with and without DMA disabled.
> You'll most certainly still get these errors.
>
> Artur Jasowicz sagte:
> > I am building a file server with 5 drive software RAID5 array. I am
> > using three IWill SIDE-100 (Highpoint 370A) controllers as my IDE
> > interfaces, not using their RAID functionality. One Maxtor 160GB drive
> > per channel, two channels per controller. I plan on adding hot spare as
> > the sixth drive in the future. There's one 160GB partition on each
> > drive. Linux version 2.4.19-pre7smp-020502b (root@production) (gcc
> > version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #6 SMP Thu May 2
> > 12:15:34 CDT 2002
>  This is a dual Athlon 2000+ MP on Tyan Tiger
> > S2466N-4 with 1GB RAM. OS and swap runs on separate drives and
> > controllers. This array will be just for data once it is configured.
> [...]
> > 17:34:39 production kernel: md: hdk1 [events: 00000001]<6>(write)
> > hdk1's sb offset: 160079552
>  May  7 17:34:39 production kernel: hde: 0
> > bytes in FIFO
> > May  7 17:34:39 production kernel: ide_dmaproc: chipset supported
> > ide_dma_timeout func only: 14
>  May  7 17:34:39 production kernel: hde:
> > dma_intr: bad DMA status (dma_stat=1)
>  May  7 17:34:39 production
> > kernel: hde: dma_intr: status=0x50 { DriveReady SeekComplete }
>  May  7
> > 17:34:39 production kernel: hdi: 4 bytes in FIFO
> [...]
> >
> > I've mdstopped the process and disbled DMA for all RAID members with
> > hdparm -d 0. Tried mdrun again and got following messages:
>
> > May  7 18:43:26 production kernel: hdi: status error: status=0x58 {
> > DriveReady SeekComplete DataRequest }
>  May  7 18:43:26 production
> > kernel: hdi: drive not ready for command
>  May  7 18:44:40 production
> > kernel: hdi: status error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
>  May  7 18:44:40 production kernel: hdi: drive not ready
> > for command


