Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318768AbSHGSjx>; Wed, 7 Aug 2002 14:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSHGSjx>; Wed, 7 Aug 2002 14:39:53 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22155 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318768AbSHGSjv>;
	Wed, 7 Aug 2002 14:39:51 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 7 Aug 2002 20:43:30 +0200 (MEST)
Message-Id: <UTC200208071843.g77IhUc20546.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mingo@elte.hu
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Cc: alan@lxorguk.ukuu.org.uk, dalecki@evision.ag, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > The funny thing is, I removed some stuff here in 2.5.30,
    > so I would understand things immediately if you reported this
    > about 2.5.30. But for 2.5.29 I do not immediately see why
    > you would see any changes.

    2.5.30 breaks as well.

    > Did you in the meantime find out what was wrong?

    nope. I still keep working it around.

    > Are things OK in 2.5.28 and wrong in vanilla 2.5.29
    > with the same version of LILO? (which version?)

    a fairly standard LILO from RH 7.3: linux-21.4.4-10.

    > Do you use the linear or lba32 options? The fix-table option?

    I use none of these options. I use a very simple setup, a proper /boot 
    partition, nothing complex or unexpected.

    > What corruption do you see in the partition table?

    nothing in the descriptors that i can tell from looking at fdisk output -
    but it would be pretty hard to recover the system via a pure rescue CD
    otherwise.

    > Do you use LVM?

    nope. Plain old IDE, ext3fs, 

    > What happens under 2.5.30?

    the same 'LI' message.

    I'll try Alan's suggestion of adding the 'linear' option.
    ...
    this actually did the trick - lilo no more messes up the bootup.
    So Alan's suspicion is right, there's something wrong about geometries
    in 2.5-current.

I always like to understand all the details - forgive me if I come
with further questions.

LILO without "linear" or "lba32" is inherently broken:
it will talk CHS at boot time to the BIOS and hence needs a geometry
and install time, and nobody knows the geometry required. So, if
LILO doesnt break, this is pure coincidence.

Since 2.5.30 many people will have a different geometry, so many
people will have to find grub or a recent LILO, or add "linear"
to their old LILO. This is all well understood - I just repeat it
a few times in the hope that that will reduce the amount of email.

But now you talk about vanilla 2.5.29, and I am surprised.
Could you send the kernel boot messages concerning that disk
(dmesg | grep hd) for 2.5.28 and 2.5.29 and 2.5.30?

And you talk about corruption, and I am surprised again.
Have you verified that there really was a difference?
Or do you only suspect corruption because LILO has problem?
(In that case I can assure you that there was no corruption.)

Andries

