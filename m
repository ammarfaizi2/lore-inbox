Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHAWf>; Wed, 7 Feb 2001 19:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRBHAWZ>; Wed, 7 Feb 2001 19:22:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:27293 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129032AbRBHAWU>;
	Wed, 7 Feb 2001 19:22:20 -0500
Date: Thu, 8 Feb 2001 01:22:14 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102080022.BAA04424.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, cat@zip.com.au
Subject: Re: suspecious ide hdparm results with 2.4.1 (and a minor capacity question)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There are two entirely different things both called LBA.
>> Neither of them wastes any space.

> You sure?

Yes. One is the hardware disk access - all disk access is LBA
these days, certainly by Linux, but if the disk is small
one can also use CHS access, when it is old one has to use CHS.

The other thing called LBA is a translation scheme.
Translation means that the BIOS will use one set of parameters
when talking to the disk, and another when talking to DOS or so.
This just means that the same sector on the disk has different
names.

But when you partition your disk using DOS fdisk, it will want
to use an integral number of "cylinders" for each partition,
and for example with 8MB cylinders you may have the bad luck
that the rounding costs you almost 8MB. But here each of the
possible translations can be lucky or unlucky.
Under Linux there is no restriction that a partition has to
start on a cylinder boundary, but an integral number of blocks
is used, so for example with 1KB blocks and an odd number of
sectors this may cost you 512 bytes.
These days one sees various (rather ugly) patches floating around
just to get at this last sector. (But they are unnecessary, I think.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
