Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263909AbTCVWPs>; Sat, 22 Mar 2003 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263912AbTCVWPs>; Sat, 22 Mar 2003 17:15:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10946 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263909AbTCVWPo>;
	Sat, 22 Mar 2003 17:15:44 -0500
Message-ID: <3E7CE334.10501@pobox.com>
Date: Sat, 22 Mar 2003 17:27:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] misc merges
Content-Type: multipart/mixed;
 boundary="------------020501030709030407090505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020501030709030407090505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The main thing here is the PCI cacheline size for, for the PCI MWI 
mini-API (that I added).  We need runtime, not compile-time, CPU 
cacheline size detection due to generic vendor kernels.

As IvanK notes, this is a conservative "just-the-fix" change.  A more 
aggressive change is pending later on, that will move cacheline size 
fixups elsewhere (most likely pci_enable_device, but possibly 
pci_set_master).

--------------020501030709030407090505
Content-Type: text/plain;
 name="misc-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5

This will update the following files:

 arch/i386/pci/common.c   |   10 +++++++++
 drivers/char/hw_random.c |    3 +-
 drivers/pci/pci.c        |   48 +++++++++++++++++++++++------------------------
 3 files changed, 36 insertions(+), 25 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/03/22 1.1202)
   [hw_random] fix amd x86-64 RNG pci id
   
   Contributed by Andi Kleen

<ink@jurassic.park.msu.ru> (03/03/22 1.1201)
   [PATCH] PCI MWI cacheline size fix
   
   This is rather conservative variant of previous patch:
   - no changes required for drivers or architectures with HAVE_ARCH_PCI_MWI;
   - do respect BIOS settings: if the cacheline size is multiple
     of that we have expected, assume that this is on purpose;
   - assume cacheline size of 32 bytes for all x86s except K7/K8 and P4.
     Actually it's good for 386/486s as quite a few PCI devices do not support
     smaller values.
   
   If you all are fine with it, I can make a 2.4 counterpart.
   
   As for more aggressive changes: I'd prefer to wait until pending
   stuff from rmk and myself gets in and the whole thing stabilizes.
   Then we can start fine tuning of MWI, FBB, latency timers and so on.
   
   Ivan.

<jgarzik@redhat.com> (03/03/20 1.1101.23.1)
   [hw_random] add AMD x86-64 pci id
   
   Contributed by Andi Kleen


--------------020501030709030407090505--

