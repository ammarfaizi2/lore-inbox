Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSEVEOM>; Wed, 22 May 2002 00:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSEVEOM>; Wed, 22 May 2002 00:14:12 -0400
Received: from ns.neureal.com ([64.29.18.145]:50950 "HELO mail2.neureal.com")
	by vger.kernel.org with SMTP id <S316847AbSEVEOL>;
	Wed, 22 May 2002 00:14:11 -0400
Message-ID: <004b01c20146$fa2d3380$050010ac@niunia.org>
From: "Artur Jasowicz" <arturj@mousebusiness.com>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10205130112110.14909-100000@master.linux-ide.org>
Subject: Re: Fw: DriveReady SeekComplete problems
Date: Tue, 21 May 2002 23:12:56 -0500
Organization: mousebusiness.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,
I've been away from the office for a few days. I am getting back to you
with results after applying the patch.

The patch applied cleanly, but did not fix the problem. I am still getting
bad DMA status (dma_stat=1) and status=0x50 { DriveReady SeekComplete }
messages with DMA on.

I've done further tests and observed following:

-creating RAID1 array of 5 drives does not produce errors
-creating RAID5 array causes errors
-doing dd if=/dev/hdx of=/dev/null bs=512 with x=one of the drives in array
 works fine as long as the drives are on the same controller. I've tried
this
 with up to 10 dd commands, 5/drive 2 drives on same controller
-the above command causes errors when used with drives on diferent
 controllers. i.e. if I start dd on hde - works fine, then I execute dd on
hdi
 and see errors

Creating RAID1 is mostly writing to drives, while doing dd and creating
RAID5 involves intense reading from drives. This de me think that the
system can't keep up with reading flood of data comming from the drives.

I've tried limiting speed of resyncing array by doing
#echo 1000 > /proc/sys/dev/raid/speed_limit_max
This slowed down pace at which error messages appeared in logs, but
did not eliminate them. I've tried diferent values instead of 1000,
the higher, the worse things were.

What else can I try?

Artur

From: Andre Hedrick <andre@linux-ide.org>
>
> Please try the latest driver changes on www.linuxdiskcert.org
>
> If it still presists let me know, again!
>
> Cheers,
>
> On Mon, 13 May 2002, Artur Jasowicz wrote:
>
> > ----- Original Message -----
> > From: Artur Jasowicz <arturj@mousebusiness.com>
> > To: <linux-kernel@vger.kernel.org>
> > Sent: Wednesday, May 08, 2002 12:34 PM
> > Subject: DriveReady SeekComplete problems
> >
> >
> > > I am building a file server with 5 drive software RAID5 array. I am
using
> > three IWill SIDE-100 (Highpoint 370A) controllers as my IDE interfaces,
not
> > using their RAID functionality. One Maxtor 160GB drive per channel, two
> > channels per controller. I plan on adding hot spare as the sixth drive
in
> > the future. There's one 160GB partition on each drive. Linux version
> > 2.4.19-pre7smp-020502b (root@production) (gcc version 2.96 20000731 (Red
Hat
> > Linux 7.1 2.96-98)) #6 SMP Thu May 2 12:15:34 CDT 2002
> > > This is a dual Athlon 2000+ MP on Tyan Tiger S2466N-4 with 1GB RAM. OS
and
> > swap runs on separate drives and controllers. This array will be just
for
> > data once it is configured.
> > >
[snip lengthy description of error messages]

