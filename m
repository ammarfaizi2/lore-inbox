Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSFOXAz>; Sat, 15 Jun 2002 19:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSFOXAy>; Sat, 15 Jun 2002 19:00:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57546 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315746AbSFOXAu>;
	Sat, 15 Jun 2002 19:00:50 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 01:00:50 +0200 (MEST)
Message-Id: <UTC200206152300.g5FN0oI14286.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dougg@torque.net
Subject: Re: /proc/scsi/map
Cc: garloff@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From dougg@torque.net  Sat Jun 15 23:10:06 2002

    In the lsml "[RFC] Persistent naming of scsi devices" thread
    Martin K. Petersen <mkp@mkp.net> summarized scsi addressing issues
    thus:
    #
    # What we want is (at least) three ways of addressing a device:
    #
    # 1. By content.  This is the persistent naming.  Think
    #    filesystem/MD/LVM UUID.  This is what you put in /etc/fstab and
    #    what metadisk systems use to assemble logical volumes.
    #
    #    Content referencing is used for accessing data.
    #
    # 2. By physical path.  This naming is not persistent.  Not even runtime
    #    because hotplug, iSCSI and whatnot may mess things up.
    #
    #    Path naming is for discovery and recovery.  When you add an
    #    unlabeled disk you want to reference it by path to give it a name.
    #    When you have a failed disk on your system you want to know which
    #    physical device to pull from the array.
    #
    # 3. By enumeration.  This is what the kernel happens to be using to
    #    reference the device.  diskN.  Certainly not persistent.
    #
    #    Enumeration is for the kernel.

Yes, a very nice summary. Maybe also

# 4. By fingerprint.  This naming is persistent, but need not
#    identify the device uniquely.  Think device type, vendor,
#    serial number, capacity.
#
#    Fingerprints are convenient for the user. "My ZIP drive".


    The /proc/scsi/map facility proposed by Kurt does a very
    good job at tying together points 2) and 3) .

Yes. Or, more precisely, it ties together the name sde and the
path (C,B,T,U) = (3,0,00,01). However, this path is not very
"physical". Indeed, these four numbers all arose by enumeration -
they are kernel numbers for some usb-storage device.

I can find the physical path, but that requires quite some digging in
/proc/scsi/scsi and /proc/scsi/sg/host_strs and /proc/scsi/usb-storage*/*
and /proc/bus/usb/devices.


    > Very good - in combination with /proc/scsi/scsi this gives
    > good information. I like it.

    Adding INQUIRY strings would make it harder to parse and more
    cluttered for humans to read.

Yes, I would like to leave that to a user-space utility.
Writing that will also show what kernel facilities are missing.

    > But just "cat /proc/scsi/map" is not good enough.
    > From the above output alone one cannot easily guess which is which.
    > One would need a small utility that reads /proc/scsi/map and
    > /proc/scsi/scsi and produces something readable.

    Note the possible race condition: reading /proc/scsi/scsi
    then /proc/scsi/map (or vice versa) when a hotplug is
    occurring...

Already reading /proc/scsi/map has a race: no locking is done.

    > Will add sth to util-linux in case this gets accepted.

    IMO as soon as lk 2.4.19 comes out, this patch should
    be presented to Marcelo (for inclusion in lk 2.4.20).

Yes, perhaps. I would like to get some experience first,
play with it, see what information is missing.

I have to admit that 2.5 is not very suitable for development
these days, it is not stable enough, but the appropriate path
is to try things out in 2.5 first, and when something crystallizes
out, backport.

    The sooner we get it into the lk 2.5 series the better. Could you 
    forward your lk 2.5 version of Kurt's patch to Linus (and the
    linux-scsi list)?

Yes, but I'll wait for 2.5.22 so that it is clear against
what tree to diff.

Andries
