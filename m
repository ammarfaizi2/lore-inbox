Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283496AbRLOS6e>; Sat, 15 Dec 2001 13:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283488AbRLOS6Z>; Sat, 15 Dec 2001 13:58:25 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26642
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S283501AbRLOS6J> convert rfc822-to-8bit; Sat, 15 Dec 2001 13:58:09 -0500
Date: Sat, 15 Dec 2001 10:52:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rene Rebe <rene.rebe@gmx.net>
cc: Jurij Smakov <jurij.smakov@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: PDC20265 IDE controller trouble
In-Reply-To: <20011215185643.252d5547.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.10.10112151049260.13398-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well blame that on the folks that are not taking kernel code that will
allow you to solve this problem.  Linus is the number one offender.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Sat, 15 Dec 2001, Rene Rebe wrote:

> Hi.
> 
> This is on a AMD K6-2 350Mhz, 128MB RAM, on a Ali Aladin5 based Gigabyte board
> 3x IBM DTLA 40GB discs on a Promisse TX2 Ultra 100 in a PCI slot.
> 
> Single transfer to one disk:
> server1:~ # hdparm -tT /dev/ide/host2/bus0/target0/lun0/disc
> 
> /dev/ide/host2/bus0/target0/lun0/disc:
>  Timing buffer-cache reads:   128 MB in  2.12 seconds = 60.38 MB/sec
>  Timing buffered disk reads:  64 MB in  2.86 seconds = 22.38 MB/sec
> 
> Dual transfer to disks on sperated channels (values per disk):
> server1:~ # hdparm -tT /dev/ide/host2/bus0/target0/lun0/disc
> 
> /dev/ide/host2/bus0/target0/lun0/disc:
>  Timing buffer-cache reads:   128 MB in  4.13 seconds = 30.99 MB/sec
>  Timing buffered disk reads:  64 MB in  4.66 seconds = 13.73 MB/sec
> 
> Dual transfer to disks on the same channel (values per dics):
> server1:~ # hdparm -tT /dev/ide/host2/bus0/target1/lun0/disc
> 
> /dev/ide/host2/bus0/target1/lun0/disc:
>  Timing buffer-cache reads:   128 MB in  4.44 seconds = 28.83 MB/sec
>  Timing buffered disk reads:  64 MB in  8.36 seconds =  7.66 MB/sec
> 
> Hey! This might be the cause for the slowdown I reported in another
> Raid5 / ReiserFS thread!!
> 
> Is this an general IDE issue or is some queueing code in the kernel
> rather bad/slow for this task???
> 
> On Sat, 15 Dec 2001 18:35:29 +0100 (MET)
> Jurij Smakov <jurij.smakov@telia.com> wrote:
> 
> > Hi!
> > 
> > Recently I've got an Asus TUSL2 motherboard, which has an extra Promise
> > IDE RAID controller with a PDC20265 chip. I've connected two IBM 60 GB
> > disks to it (one disk per channel). I am using kernel 2.4.17-pre8
> > (with CONFIG_BLK_DEV_PDC202XX=y and with/without CONFIG_PDC202XX_BURST=y),
> > which nicely detects the extra controller and both disks, hde and hdg. If
> > I test the writing and reading speed (hdparm -t, dd if=/dev/zero of=test
> > ...) separately for each disk, I get the expected figures, like 36-37
> > MB/sec for reading, about 30 MB/sec for writing. If, however, I try to
> > write simultaneously to both disks, the performance drops drastically. The
> > rate for writing is then something like 3.5 MB/sec (!). I wonder if anyone
> > have seen anything like that or might have any ideas on how to solve the
> > problem.
> > 
> > Suspecting the hardware, I've posted this message to
> > comp.os.linux.hardware first, but no one have seen such a behaviour. I
> > have also tried different sets of IDE cables.
> > 
> > Best regards and TIA,
> > 
> > 
> > Jurij.
> > 
> > P.S. Please cc responses to me, because I'm not on the list.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> k33p h4ck1n6
>   René
> 
> -- 
> René Rebe (Registered Linux user: #248718 <http://counter.li.org>)
> 
> eMail:    rene.rebe@gmx.net
>           rene@rocklinux.org
> 
> Homepage: http://www.tfh-berlin.de/~s712059/index.html
> 
> Anyone sending unwanted advertising e-mail to this address will be
> charged $25 for network traffic and computing time. By extracting my
> address from this message or its header, you agree to these terms.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

