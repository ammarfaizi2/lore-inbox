Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWBZXI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWBZXI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWBZXI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:08:57 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:27828 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S932245AbWBZXI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:08:56 -0500
Date: Mon, 27 Feb 2006 00:08:50 +0100
To: linux-kernel@vger.kernel.org
Subject: o_sync in vfat driver
From: col-pepper@piments.com
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s5lrw0hrj68xd1@mail.piments.com>
User-Agent: Opera M2/8.51 (Linux, build 1462)
X-Ovh-Remote: 213.103.54.253 (d213-103-54-253.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*** Is that aim being achieved by the current policy? ***

As I understand it the old (<=2.6.11) sync model kept the data in sync
without updating the FAT until later. This runs the risks of partial
corruption of one or more files on pullout.

The new model attempts to be more rigourous by updating the FAT every time
a block of data is written. Thus the "hammering" of the physical memory
hosting the FAT record.

In view of the nature of flash memory this may actually be drastically
increasing the chance that the whole FAT gets erased.
part IV (end of a sage)

If a pullout occurs during write , there is now a near 50% chance that
this takes out the entire FAT.

It would seem that the main advantage of this scheme is that it is so slow
that it encourages users to turn it off. Presumably in the process of
coming to that conclusion they will become aware of the need to run umount
or the sync command before doing removing the device.

= Danger of destroying hardware =

It seems that there are well documented cases of this abusive rewriting of
the FAT causing rapid and total premature failure of what Alan Cox refers
to as "ultra-crap devices".

There may be valid reasons of cost or miniaturisation that preclude the
additional hardware found in more complex devices.

Even if better quality devices may have some sort of paging mechanism
which makes them more resistant to this sort of abuse, it does not seem
good engineering practice to dismiss those that fail as "shite".

There is nothing in the spec of vfat that suggests the FAT will be written
10.000 during the writing of one large file. Indeed it is hard to imagine
that any other implementation on any other OS or any previous linux kernel
behaves like that.

So should the hardware manufacturers have anticipated this particular
driver implementation or should the kernel be more aware of the existing
hardware that it purports to support.

= The way forward =

It would seem that the first step could be to revert to the 2.6.11
behaviour which was more appropriate and probably safer even from the data
point of view.

I lack the knowlege and experience to produce reliable kernel code so I
wont try. However, I have already seen a number of suggestions of how the
old model could be improved. This post could be the starting point for a
discussion of more robust techniques. In any case the coding is unlikely
to be very complex given the existing , tested code base that is in place
in 2.6.11

Any new technique should probably aim to be applicable to larger devices
as well. The 2G limit is artificial and is a tacit recognition of the
precarity of the current code. USB hard disks are just as prone to
accidental cable pullout. Some periodic or per file sync should probably
be envisaged for the VFAT sync mount option.


PS if anyone can tell me why I had to post this ten times and chop it into  
little bits it would be appreciated in not messing up the list in the  
future.

I spent an hour reading the faq and I dont see anything taboo here.

