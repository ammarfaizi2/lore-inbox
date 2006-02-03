Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWBCBNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWBCBNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBCBNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:13:32 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:62862 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751249AbWBCBNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:13:31 -0500
Date: Fri, 3 Feb 2006 02:13:24 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Bill Davidsen <davidsen@tmr.com>
cc: Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.60.0602030212200.18478@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org>
 <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz> <43E26CB6.7030808@tmr.com>
 <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="546507526-1568323624-1138929204=:18478"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--546507526-1568323624-1138929204=:18478
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 3 Feb 2006, Martin Drab wrote:

> On Thu, 2 Feb 2006, Bill Davidsen wrote:
>=20
> Just to state clearly in the first place. I've allready solved the proble=
m=20
> by low-level formatting the entire disk that this inconsistent array in=
=20
> question was part of.
>=20
> So now everything is back to normal. So unforunatelly I would not be able=
=20
> to do any more tests on the device in the non-working state.
>=20
> I mentioned this problem here now just to let you konw that there is such=
=20
> a problematic Linux behviour (and IMO flawed) in such circumstances, and=
=20
> that perhaps it may let you think of such situations when doing further=
=20
> improvements and development in the design of the block device layer (or=
=20
> wherever the problem may possibly come from).

Perhaps maybe rather of the SCSI layer, than of the block layer ??
=20
> And I also hope you would understand, that I wouldn't try to create that=
=20
> state again deliberatelly, since my main system is running on that array=
=20
> and I wouldn't risk loosing some more data because of this.
>=20
> However maybe someone perhaps in Adaptec or smewhere else may have=20
> some simillar system at the disposal on which he could allow to experimen=
t=20
> on demand without any serious risk of loosing anything important.
>=20
> So what I may say is that it is an Adaptec 2410SA with 8205 firmware and=
=20
> without a battery backup system (which is probably the crutial thing).=20
> And the inconsistency was caused by a MB protection of CPU overheat=20
> shutdown, because I've started the system and booted Linux from the array=
=20
> in question (which consisted by just one part of one disk), while I've=20
> forgotten to turn on the water cooling of the CPU and northbridge. So=20
> after about 3 minutes the system automatically shut down and Linux was=20
> probably doing some writing in that very moment, which wasn't able to=20
> complete fully (most probably due to the lack of the battery backup syste=
m=20
> on the RAID controller). So my guess is that this may be artificially=20
> reproduced when you suddenly switch off a power source of the system whil=
e=20
> Linux is doing some writing to the array.
>=20
> My arrays in particular are:
>=20
> =09HDD1 (160 GB): 120 GB Array 1, 40 GB Array 2
> =09HDD2 (120 GB): 120 GB Array 1
> =09HDD3 (120 GB): 120 GB Array 1
> =09HDD4 (120 GB): 120 GB Array 1
>=20
> Where Array 1 is a RAID 5 array /dev/sdb (labeled as "Data 1"), which=20
> contains just one 330 GB partition /dev/sdb1, and Array 2 is a bootable=
=20
> (in Adaptec BIOS setup so called) Volume array (i.e. no RAID) /dev/sda=20
> (labeled as "SYSTEM"), which contains /dev/sda1 (NTFS Windows), /dev/sda2=
=20
> (ext3 Linux), /dev/sda3 (Linux swap). Problem was accessing the whole Arr=
ay 2.=20
> Array 1 from Linux worked well.
>=20
> Then, when I tried, the array checking function within the BIOS of the=20
> Adaptec controller found an inconsistency on the position somewhere in th=
e=20
> middle of the /dev/sda, so somewhere within the /dev/sda2 in particular.=
=20
> So I low-level formatted the entire HDD1, resynced the Array 1 (which is=
=20
> RAID 5, so no problem) and reinstalled both systems in Array 2, and now i=
t=20
> is all back to normal again.
>=20
> > Martin Drab wrote:
> >=20
> > > Well, I had a similar experience lately with the Adaptec AAC-2410SA R=
AID 5
> > > array. Due to the CPU overheating the whole box was suddenly shot dow=
n by
> > > the CPU damage protection mechanism. While there is no battery backup=
 on
> > > this particular RAID controller, the sudden poweroff caused some very
> > > localized inconsistency of one disk in the RAID. The configuration wa=
s 1x160
> > > GB and 3x120GB, with the 160 GB being split into 120 GB part within t=
he RAID
> > > 5 and a 40 GB part as a separate volume. The inconsistency happend in=
 the 40
> > > GB part of the 160 GB HDD (as reported by the Adaptec BIOS media chec=
k). In
> > > particular the problem was in the /dev/sda2 (with /dev/sda being the =
40 GB
> > > Volume, /dev/sda1 being an NTFS Windows system, and /dev/sda2 being e=
xt3
> > > Linux system).
> > >=20
> > > Now, what is interesting, is that Linux completely refused any possib=
le
> > > access to every byte within /dev/sda, not even dd(1) reading from any
> > > position within /dev/sda, not even "fdisk /dev/sda", nothing. Everyth=
ing
>                                         ^^^^^^^^^^^^^^
> > > ended up with lots of following messages:
> > >=20
> > >         sd 0:0:0:0: SCSI error: return code =3D 0x8000002
> > >         sda: Current: sense key: Hardware Error
> > >             Additional sense: Internal target failure
> > >         Info fld=3D0x0
> > >         end_request: I/O error, dev sda, sector <some sector number>
> >=20
> > But /dev/sda is not a Linux filesystem, running fsck on it makes no sen=
se. You
> > wanted to run on /dev/sda2.
>=20
> But I was talking about fdisk(1). This wasn't a problematic behaviour of =
a=20
> filesystem, but of the entire block device.
>=20
> > > I've consulted this with Mark Salyzyn, because I thought it was a pro=
blem of
> > > the AACRAID driver. But I was told, that there is nothing that AACRAI=
D can
> > > possibly do about it, and that it is a problem of the upper Linux lay=
ers
> > > (block device layer?) that are strictly fault intollerant, and thouth=
 the
> > > problem was just an inconsistency of one particular localized region =
inside
> > > /dev/sda2, Linux was COMPLETELY UNABLE (!!!!!) to read a single byte =
from
> > > the ENTIRE VOLUME (/dev/sda)!
> >=20
> > The obvious test of this "it's not us" statement is to connect that one=
 drive
> > to another type controller and see if the upper level code recovers. I'=
m
> > assuming that "sda" is a real drive and not some pseudo-drive which exi=
sts
> > only in the firmware of the RAID controller.
>=20
> /dev/sda is a 40 GB RAID array consisting of just one 40 GB part of one=
=20
> 160 GB drive. But it is in fact a virtual device supplied by the=20
> controller. I.e. this 40 GB part of that disc behaves as an entire=20
> harddisk (with it's own MBR etc.). And it is at the end of the drive, so=
=20
> it may be a little tricky to find the exact position of the partitions=20
> there, but it may be possible.
>=20
> > That message is curious, did you
> > cat /proc/scsi/scsi to see what the system thought was there? Use the i=
nfamous
> > "cdrecord -scanbus" command?
>=20
> ----------
> $ cdrecord -scanbus
> Cdrecord-Clone 2.01.01a03-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2005=
 J=EF=BF=BDg Schilling
> Note: This version is an unofficial (modified) version with DVD support
> Note: and therefore may have bugs that are not present in the original.
> Note: Please send bug reports or support requests to warly at mandriva.co=
m.
> Note: The author of cdrecord should not be bothered with problems in this=
=20
> version.
> Linux sg driver version: 3.5.33
> Using libscg version 'schily-0.8'.
> scsibus0:
>         0,0,0     0) 'Adaptec ' 'SYSTEM          ' 'V1.0' Disk
>         0,1,0     1) 'Adaptec ' 'Data 1          ' 'V1.0' Disk
>         0,2,0     2) *
>         0,3,0     3) *
>         0,4,0     4) *
>         0,5,0     5) *
>         0,6,0     6) *
>         0,7,0     7) *
>=20
> $ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: Adaptec  Model: SYSTEM           Rev: V1.0
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: Adaptec  Model: Data 1           Rev: V1.0
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> -----------
>=20
> The 0,0,0 is the /dev/sda. And even though this is now, after low-level=
=20
> formatting of the previously inconsistent disc, the indications back then=
=20
> were just the same. Which means every indication behaved as usual. Both=
=20
> arrays were properly identified. But when I was accessing the inconsisten=
t=20
> one, i.e. /dev/sda, in any way (even just bytes, this has nothing to do=
=20
> with any filesystems) the error messages mentioned above appeared. I'm no=
t=20
> sure what exactly was generating them, but I've CC'd Mark Salyzyn, maybe=
=20
> he can explain more to it.
>=20
> > > And now for the best part: From Windows, I was able to access the ENT=
IRE
> > > VOLUME without the slightest problem. Not only did Windows boot entir=
ely
> > > from the /dev/sda1, but using Total Commander's ext3 plugin I was als=
o able
> > > to access the ENTIRE /dev/sda2 and at least extract the most importan=
t data
> > > and configurations, before I did the complete low-level formatting of=
 the
> > > drive, which fixed the inconsistency problem.
> > >=20
> > > I call this "AN IRONY" to be forced to use Windows to extract informa=
tion
> > > from Linux partition, wouldn't you? ;)
> > >=20
> > > (Besides, even GRUB (using BIOS) accessed the /dev/sda without compli=
cations
> > > - as it was the bootable volume. Only Linux failed here a 100%. :()
> >=20
> > From the way you say sda when you presumably mean sda1 or sda2 it's not=
 clear
> > if you don't understand the difference between drive and partition acce=
ss or
> > are just so pissed off you are not taking the time to state the distinc=
tion
> > clearly.
>=20
> No, I understand the differences very clearly. But maybe I was just=20
> unclear in my expressions (for which I appologize). What I mean is that=
=20
> the problem was with the entire RAID array /dev/sda. So whenever ANY=20
> access to ANY part of /dev/sda, which of course also includes accesses to=
=20
> all of /dev/sda1, /dev/sda2, and /dev/sda3, the error messages appeared=
=20
> and no access was performed. That includes even accesses like this
> "dd if=3D/dev/sda of=3D/dev/null bs=3D512 count=3D1" and any other possib=
le=20
> accesses. So the problem was with the entire device /dev/sda.
>=20
> > There was a problem with recovery from errors in RAID-5 which is addres=
sed by
> > recent changes to fail a sector, try rewriting it, etc.
>=20
> Maybe this was again my bad explanation, but this wasn't a problem of a=
=20
> RAID 5 array, and much less of a software array. Adaptec 2410SA is a=20
> 4-channel HW SATA-I RAID controller.
>=20
> > I would have to read linux-raid archives to explain it, so I'll stop=20
> > with the overview. I don't think that's the issue here, you're using a=
=20
> > RAID controller rather than the software RAID, so it should not apply.
>=20
> Yes, exactly. And again, I've solved it by lowlevel formatting.
>=20
> > I assume that the problem is gone, so we can't do any more analysis aft=
er the
> > fact.
>=20
> Unfortunatelly, yes. But I've described above how did it happen, so maybe=
=20
> someone in Adaptec would be able to reproduce, Mark?
>=20
> Martin

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Martin Drab
Department of Solid State Engineering
Department of Mathematics
Faculty of Nuclear Sciences and Physical Engineering
Czech Technical University in Prague
Trojanova 13
120 00  Praha 2, Czech Republic
Tel: +420 22435 8649
Fax: +420 22435 8601
E-mail: drab@kepler.fjfi.cvut.cz
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--546507526-1568323624-1138929204=:18478--
