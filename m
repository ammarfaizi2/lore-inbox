Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSENSs5>; Tue, 14 May 2002 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSENSs4>; Tue, 14 May 2002 14:48:56 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:7990 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S314085AbSENSsz>;
	Tue, 14 May 2002 14:48:55 -0400
Date: Tue, 14 May 2002 19:49:01 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Dead2 <dead2@circlestorm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <00fd01c1fb76$1d8654a0$0d01a8c0@studio2pw0bzm4>
Message-ID: <Pine.LNX.4.33.0205141938390.1577-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Dead2 wrote:
> Isolinux: http://syslinux.zytor.com/iso.php
>
> If you have a tutorial of how to make a bootable cdrom that does not use
> Isolinux, then please point me to it.. =)

I don't have a tutorial, unfortunately. I just wrote the necessary scripts
myself. Besides, this is not something fundamental where one should rely
on the work of others, imho. Creating a bootable CD is too "custom" to be
generic and when it is made generic you end up with problems like you are
having, i.e. not knowing exactly what is going on.

But the basic steps I do are:

a) generate the 2.88M floppy image on /dev/ram0 and fake the geometry like
this:

disk=/dev/ram0
  bios=0
  sectors=36 # or 18 for 1.44M
  cylinders=80
  heads=2

b) make the minimum content of the image:

mkdir boot dev etc
mknod dev/null c 1 3
mknod dev/ram1 b 1 1
mknod dev/zero c 1 5

c) copy the kernel image and LILO bits in there

d) lilo -r /mnt ; umount /mnt

e) dd if=/dev/ram0 of=boot/boot2880.img bs=1k count=2880

f) mkisofs -b boot/boot2880.img -c boot/boot.cat \
        -J -R -quiet \
        -o image.iso

(actually, I add a lot more parameters to mkisofs but they are too
specific to my task so are not interesting)


>
> To make the iso image I use the following command:
>
> 'mkisofs -b isolinux.bin -o test.iso -no-emul-boot -boot-load-size
> 4 -boot-info-table /iso'
>

Interesting, so you are saying that the modern BIOSes are already capable
of booting no-emulation CDs? Last time I tried it (perhaps a year ago)
some of my Dell machines couldn't do it so I gave up and decided to live
with the 2.88M limit. I thought that BIOSes only support enough of "no
emulation" to boot Windows installation CD.

But if things changed and I should revisit the idea (i.e. if it is now
possible to have boot images larger than 2.88M in a portable manner) then
I would like to know.

Regards
Tigran

