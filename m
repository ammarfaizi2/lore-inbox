Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJYT0G>; Fri, 25 Oct 2002 15:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSJYT0G>; Fri, 25 Oct 2002 15:26:06 -0400
Received: from smtp07.wxs.nl ([195.121.6.39]:21637 "EHLO smtp07.wxs.nl")
	by vger.kernel.org with ESMTP id <S261550AbSJYT0F>;
	Fri, 25 Oct 2002 15:26:05 -0400
Message-ID: <007501c27c5d$378aef10$1400a8c0@Freaky>
From: "freaky" <freaky@bananateam.nl>
To: <linux-kernel@vger.kernel.org>
Subject: KT333, IO-APIC, Promise Fasttrak, Initrd
Date: Fri, 25 Oct 2002 21:32:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

this is gonna be a long one, please bear with me. :-)

I've got several problems/questions. My slackware 8.1 iso-image can't
install so I tried making my own install flop (I've made several kernels
before since 2.2.4 for various machines) which I think is made ok (pretty
sure of it), but I've got some problems with it.

First my setup:

MSI KT3 Turbo2-R mainboard
AthlonXP 2000+
512MB 333MHz DDR
MSI GF4-MX460-VTP
Realtek 8139
Promise Fasttrak Lite IDE RAID (onboard see
http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php?UID=
341&MODEL=MS-6380E)

The promise fasttrak controller has 4 disks... I just use it as a fancy IDE
controller. This controller doesn't have a jumper/BIOS setting for putting
it in IDE mode so I tricked it. Attached the harddisks one by one so arrays
were created of one disk each. This works under WinXP. Most of the
partitions were created on my previous system with PIIX intel controllers
and are read without probs under XP.

This goes for all my tests... made a dir /tmp/lindisk/<name>.i copied the
.config from /usr/src/linux to the <name.i>/config and copied the System.map
and gzipped it in the <name.i>. Put the makedisk sh script and the
1440k.img.gz (compressed formatted floppy image for mount usage) to the
/tmp/lindisk. Then made kernels and copied bzImage to the <name.i> and ran
./makedisk <name.i> <name.i>/bzImage. Next I made the floppy disk using dd
if=/tmp/<name.i> of=/dev/fd0u1440 (the docs say to use zcat, but I found
with some defected floppy disks it didn't give errors whilst dd does). The
floppies boot so it should be fine :-)

Now the problems start. I've used 2.4.19 and 2.4.20-pre11 (the latest at
this moment)

On 2.4.19 I compiled with APIC but without IO-APIC. It gave messages about
spurious IRQ's (7.. nothing is connected to the parallel port tho', also
there is no parallel port support in the kernels cause I wanted to keep them
as small as possible). The 2.4.20pre is compiled with IO-APIC and didn't
give those messages.

It gives the message i should contact Vojtech so I did for the via chipset.

The RAID controller comes up with both hd[e-h] and d<x>p<y>'s. Can I use the
hd[e-h]'s? since I have 1 disk arrays?

Tried booting into my old partitions with the hdg3 but came up with IO
errors. I'm guessing it has to do with the south bridge not being supported
or the ext 2 partitions having trouble with being on the raid controller.

I used the slackware install.[1-5] from the current tree (downloaded
yesterday). After loading the first disk it nicely mentions it has to load 5
disks, asks for the 2nd I put it in and it's done reading in 0.1secs and
asks for 3, it does that for all the remaining 4 disks (that means, it
actually reads the first disk but only asks for the rest but doesn't
actually read them). Then it boots.... Comes up with message that the dir
#41 is invalid which probably is because the other 4 disks aren't loaded.

Hoping someone can tell me more or has some experimental patches. I have
reasonable computer knowledge and am willing to help were I can. Can't
really program yet but I'm learning C++ (the kernel looks really tough tho'
:-()

Found something in the (unofficial) archives that's probably similar:

quote:

On 2002-09-24T19:19:34,
   Benjamin LaHaise <bcrl@redhat.com> said:

> > >APIC makes perfect sense albeit rare.  Single processor IO APICs are
very
> > >rare and are usually MP systems with only one processor.
> > I think most AMD Athlon boards have an IO APIC
> I'd love to have it enabled in a distro kernel, but as Arjan pointed out,
it
> currently breaks some laptops if enabled.

Well, _not_ enabling IO-APIC on UP breaks my Athlon / KT333 at home; random
freezes are the result, so I prefer to enable it...

So whichever default is chosen, someone is burned. I hate hardware.

--

Well nice weekend everyone and TIA




