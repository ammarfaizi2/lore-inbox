Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286238AbRLTNXo>; Thu, 20 Dec 2001 08:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286241AbRLTNXh>; Thu, 20 Dec 2001 08:23:37 -0500
Received: from oe27.law9.hotmail.com ([64.4.8.84]:64776 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286238AbRLTNXT>;
	Thu, 20 Dec 2001 08:23:19 -0500
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Consistant complete deadlock with kernel 2.4.16 on an Abit VP6 with dual 1 Gig CPUs and an ICP GDT RAID card
Date: Wed, 19 Dec 2001 16:22:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE272TUSzbAUfKRfcjc00005359@hotmail.com>
X-OriginalArrivalTime: 20 Dec 2001 13:23:13.0317 (UTC) FILETIME=[79E41550:01C18959]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I recently setup my spiffy new SMP system.  The System consists of:

Abit VP6 motherboard
Dual ! Gig Pentium III CPUs
128MB memory (for now)
EIDE boot drive on the VIA EIDE port for most of the system
RAID 5 setup using an Ultra2 ICP RAID controller (gdth driver)

    After setting up the new raid I decided to run a burn in test on it with
the following script:

while [ "" = "" ]
do
    rm -rv linux-2.4.16.old
    mv -v linux-2.4.16 linux-2.4.16.old
    cp -av linux-2.4.16.old linux-2.4.16
done

    It didn't take very long.  After a 15 minutes or so the entire system
deadlocked.  And very badly at that.  Not even the magic sysrq key
combinations worked anymore.  I've spent the past few days trying to debug
the problem and this is what I've found so far.

The freezing appears to only happen when running my burn-in test on the raid
drive.  (may have been one instant of it happening on the ide drive while
compiling a kernel too, however I did a file operation on the raid drive
shortly before the freeze so can't say for sure.  Though the EIDE burn-in
test can run for quite a long while)

The freezing only happens on an SMP kernel on dual CPUs.  (I tried out a
non-SMP kernel.  No lockup.)
It doesn't appear filesystem related.  (Tried both ext3 and ext2)
It doesn't appear like a hardware issue.  Ran a burn-in test with FreeBSD.
(Worked beautify)
Also tried switching the RAID controller to different PCI slots and
disabling the built-in Highpoint HPT370 EIDE pseudo raid controller so that
the card didn't share an irq.
Tried different BIOS settings, no change.
Tried passing "noapic" to the kernel.  Deadlock still remained.
Upgraded the BIOS. (deadlock on 2 different BIOSes)

    Best I can tell there appears to be a problem with the ICP raid
controller driver (gdth) in an SMP system, or at least in an SMP system
running on this motherboard.  Does anybody else have an ICP RAID controller
with a RAID 5 setup running successfully in an SMP system?  If so are you on
an Abit VP6?  Anyone know of any 2.4.16 kernel bug that could be doing this?
If so, is there a fix or a workaround?

    Anyone know how I could debug the cause of this problem?  Machine
deadlocks.  Not even an Ooops so I'm short on ideas on how to track the
problem down.  Please help.  8-(  My new SMP system sucks on Linux.  8-(
