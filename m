Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131994AbQLVPmv>; Fri, 22 Dec 2000 10:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbQLVPml>; Fri, 22 Dec 2000 10:42:41 -0500
Received: from ip166-35.fli-ykh.psinet.ne.jp ([210.129.166.35]:26563 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131994AbQLVPmZ>;
	Fri, 22 Dec 2000 10:42:25 -0500
Message-ID: <3A436F2D.3F15E158@yk.rim.or.jp>
Date: Sat, 23 Dec 2000 00:11:41 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE woes:linux and BIOS won't agree on C/H/S detection
In-Reply-To: <3A424B0F.39E71E4F@yk.rim.or.jp> <20001221222735.A15396@win.tue.nl>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your tips.


Guest section DW wrote:



> First a few warnings - probably you know already, but just to be sure:
>

>
> (i) The geometry you get is mostly determined by the BIOS settings
> (Normal / Large / LBA / PartitionTable).
>

>
> (ii) The 2.2.14+ and 2.4 behaviours are both correct, but differ.
> The difference consists in that 2.2.14 will use a 255 head geometry
> by default (on a large disk), while 2.4 will not.
> 2.2.12 is broken for large disks.
>

255 head geometry seems to have crept in after I tried
the 2.2.1x installation. That is for sure.

>
> (iii) The geometry seen on a partition table may override the geometry
> detected earlier. If this happens you see lines like
>          hde: [PTBL] [4441/255/63] hde1 hde2 hde3 < hde5 > hde4
> in the dmesg, but you did not report any PTBL, so as far as Linux
> is concerned the partition table did not play a role.
>

No I don't see [PTBL] entry in the log.

>
> (iv) It is impossible to guess what geometry the BIOS will invent,
> but Linux makes a feeble attempt. For your hda it asks the BIOS
> about hd0, the 0x80 disk. But if you also have SCSI disks, then
> the BIOS may number the disks such that 0x80 is the SCSI disk.
> (This may depend on which disk you boot from.)
> In such a case the geometry the BIOS reports is the geometry
> it uses for that SCSI disk.
>

Aha, this might be playing a role.
I am booting from SCSI! Namely I use loadlin from the
command only prompt of Win98 and boots it.

>
> So, if you play with these things in order to understand all
> details, you can try with and without SCSI disks and see
> whether it makes a difference. (On my machine it does.)
>

I will do so over the weekend and report the result..

>
> > On 586SG motherboard, Linux 2.4.0-testXX reported acceptable
> > 39693/16/63 (QUESTION: why 39693 is one less the number reported by
> > AMI BIOS? Oh well.)
>
> You can do the computation for yourself: 40011300/(16*63) = 39693.
> Apparently the AMI BIOS is buggy here.
>

Oh,  how embarrassing for AMI programmers.

> > (3) CHS=2490/255/63 stuck?
> >
> > I tried
> >
> >   fdisk /mbr
> >
> > from the DOS/Win. (This may not clear the whole 512bytes as explained
> > in the ide.txt and large-disk-howto doc.)
>
> Precisely. It doesnt help at all.
>

Right, it seemed to wipe out the boot record, but the
mysterious partition info was still there.


> >   dd if=/dev/null of=/dev/hdaZ bs=512 count=1
> >
> > But this didn't to seem to work.
> > (I am now not sure which value of Z I used. Maybe I should try simple
> > hda without Z?)
>
> Yes, you should. But this changes something for Linux only in case
> it earlier reported PTBL which it didnt. So, it won't help, unless
> this changes something for the BIOS.
>

Well, I might try just for completeness's sake.

>
> > I even used the Seagate partition tool that could be used to partition
> > large disk from DOS (even on a machine without BIOS support for large
> > ATA disk).  The tool, called Disk manager
>
> Disk managers only make your life much more complicated.
> Stay far away from them, if you can.
>

Too late...

>
> > With the boot line command line parameter, fdisk /dev/hda prints the
> > following.
> > I take that as long as I stay away from the first and the last
> > partition,
> > I can make linux and win98 co-exist.
> >
> > command (m for help): p
> >
> > Disk /dev/hda: 16 heads, 63 sectors, 39693 cylinders
> > Units = cylinders of 1008 * 512 bytes
> >
> >    Device Boot    Start       End    Blocks   Id  System
> > /dev/hda1   *         1      3969   2000061    6  FAT16
> > Partition 1 does not end on cylinder boundary:
> >      phys=(248, 254, 63) should be (248, 15, 63)
> > /dev/hda2          3969     39685  18000832+   f  Win95 Ext'd (LBA)
> > Partition 2 does not end on cylinder boundary:
> >      phys=(1023, 254, 63) should be (1023, 15, 63)
>
> Interesting. It looks like you are trying to get 39693/16/63
> while Windows in fact uses the 2940/255/63 that you are trying
> to get rid of.
>

Are you sure of this?
Gee I am glad I attached this fdisk partition table, but
then I have to think more deeply then what the best measure would
be.

TIA


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
