Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSJ0C2F>; Sat, 26 Oct 2002 22:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbSJ0C2F>; Sat, 26 Oct 2002 22:28:05 -0400
Received: from gate.gau.hu ([192.188.242.65]:8128 "EHLO gate.gau.hu")
	by vger.kernel.org with ESMTP id <S262235AbSJ0C2E>;
	Sat, 26 Oct 2002 22:28:04 -0400
Date: Sun, 27 Oct 2002 03:26:47 +0100 (CET)
From: Cajoline <cajoline@andaxin.gau.hu>
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: RE: ASUS TUSL2-C and Promise Ultra100 TX2
In-Reply-To: <008b01c27cfd$5a6f7820$020da8c0@nitemare>
Message-ID: <Pine.LNX.4.44.0210270227260.9538-100000@andaxin.gau.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Oct 2002, Robbert Kouprie wrote:

> > This board should be rather similar to mine, with the main difference
> > being suport for Coppermine/Tualatin processors.
> > also use the PIIX4 onboard IDE chipset?
>
> >From the Asus website, the motherboards are very similar, both have the
> Intel 815 north bridge, and both have the ICH2 (Intel 82801BA Enhanced
> I/O Controller Hub 2) IDE controller onboard. This chip is handled by
> the piix.c driver.

Right, it is ICH2. However, when I boot on Red Hat's 2.4.18 kernels, the
chipset is always reported as PIIX4, not as ICH2, but for example on the
2.4.19 stock kernel I compiled, it is reported as ICH2; yet the two
kernels display the same behavior regarding this issue.
This difference couldn't be a problem though, right?

> > Indeed, that could be a workaround, but I'm afraid it's not that good
> > after all, because not all the drives have the same capabilities, it's
> > still slower than udma 5 (UDMA100) and from my tests, with such a
> > forced setting, the performance is still poor even for this udma mode.
>
> Note that "ata66" actually means UDMA66 and up (it actually means that
> you use 80-conductor cables), so with this parameter your drive _will_
> run at UDMA 100 if that's supported by the drive and controller. I have
> several boxes which need this parameter with the Linus kernel tree, and
> they all have disks running at UDMA100 with this boot parameter. Also,
> my tests show good speeds on these drives.

I'm sorry, I made a mistake; I meant to write I tried the idebus=66 kernel
parameter, not the one you mentioned. The idebus option didn't have any
effect. I will try the ideX=66 one soon.

> > This is interesting. Excuse my ignorance, but do you know what has
> > actually changed exactly regarding PDC20268 and PDC20269?
>
> LBA48 support (for disks > 127Gb) I think was added.

Somehow I believe LBA48 is already supported in 2.4.19 and even 2.4.18. I
have a 160 GB Maxtor drive attached to one of the PDCs (which have already
been flashed with the latest bios that supports LBA48) and it operates
at its' full capacity.

> This night, I experienced another hang on my box. Even magic sysreq
> doesn't do anything anymore. Do you have a reproducible testcase to
> trigger this?

No unfortunately not, that's the whole point here, I don't have any sign
whatsoever of what causes this and where the problem is, since I also
don't get any error or diagnostic whatsoever. Otherwise I would perhaps be
able to narrow it down.
I have noticed this always occurs when reading (copying) from the devices
on the PDCs to another disk. Actually, the disks on the PDCs are all part
in a logical volume (LVM) together with hdc (on the ICH2). I try to copy
files from the LV (ext3 fs) to hdb1 (vfat), and the system always hangs at
some point, which I can not even determine.
I haven't been able to cause the same problem when writing to the LV.
I doubt the LVM code could have something to do with this, but I should
try this with a single partition on a disk attached to the PDC anyway.
Will do very soon.

> > OK fine, I agree, but how do you explain this only happens
> > when running on
> > this motherboard?
>
> Maybe we should start blaming the onboard ICH2 controller, or the piix.c
> driver in this case, because that's the only common thing in our faulty
> setups. I also noticed that the ICH2 on the Asus TUSL2-C and CUSL2-C
> boards have its own PCI device id in the pci.ids file. So this could
> mean they have something different than regular ICH2 chips. I'll include
> my full lspci -vvvx for anyone who is interested.

I will also send the output of lspci soon enough, in case it makes any
sense to your or anyone else. I just can't do it right away.

> > Indeed. The same controllers work just fine on a P3 600 + QDI
> > Advance 10F
> > motherboard (with onboard VIA vt82c686a IDE UDMA66 controller).
>
> Did you also try this motherboard with a different brand add-on PCI
> controller (like a CMD one)?

No, I don't have any other brand cards to use. I remember I also tried one
Ultra66 controller on this board and it worked fine.

Thanks for your help and comments - they have been quite helpful.
I will try the current -ac tree patches, as well as everything noted
above, and write back asap with my findings.

Regards,
CJ Leblanc

