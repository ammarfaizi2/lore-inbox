Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVBUNqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVBUNqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVBUNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:46:31 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:40867 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261963AbVBUNqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:46:24 -0500
Message-ID: <4219E62D.7000009@ribosome.natur.cuni.cz>
Date: Mon, 21 Feb 2005 14:46:21 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050126
X-Accept-Language: en, en-us, cs
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: memory management weirdness
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have received no answer to my former question
(see http://marc.theaimsgroup.com/?l=linux-kernel&m=110827143716215&w=2).
I've spent some more time on that problem and have more or less confirmed
it's because of buggy bios. However, the linux kernel doesn't handle properly
such case. I've tested 2.4.30-pre1 kernel and latest 2.6.11-rc4 kernel.
The conclusion is, that once the machine has physically installed 4x1GB
DDR400 DIMM's (bios detects only 3556 or less memory as some buffers
are allocated by the Intel 875P chipset and AGP card), the linux 2.6.11*
runs up-to 18x slower than when only 2x1GB + 2x 512MB DDR memory is installed.

  Although I've not re-tested this today again, it used to help a bit to specify
mem=3548M to decrease memory used by linux (tested with AGP card plugged in, when
bios reported 3556MB RAM only).

  I found that removing the AGP based videoc card and using an old PCI based
video card results in bios detecting 4072MB of RAM. But still, the machine was
slow. I've tried to "cat >| /proc/mtrr" to alter the memory settings, but the
result was only a partial speedup.

  I'm not sure how to convince linux kernel to run fast again.
I suspect either the memory mapping of interrupts are the cause. Disabling
acpi did not help me initially, so I've conducted most of my tests with
acpi enabled.

  I've put dmesg, iomem, interrupt, lspci and time(1) requirements of my test
on web: http://www.natur.cuni.cz/~mmokrejs/tmp/. The differences can be seen easily
by diffing the files. All tests in http://www.natur.cuni.cz/~mmokrejs/tmp/4MB/
we carried with AGP aperture size set to 4MB, although teh video card has
128MB RAM.
  
  Later I've reverted to AGP aperture set to 128MB back and tested again:
http://www.natur.cuni.cz/~mmokrejs/tmp/128MB/.

  Finally, I put back two 512MB memory modules to have only 3GB RAM physically,
and the result is at http://www.natur.cuni.cz/~mmokrejs/tmp/128MB/only_phys_3GB/.

  About a week ago I tried to contact ASUS, but no answer so far from their
techinical support through some web robot.
http://vip.asus.com/eservice/techmailstatus.aspx?ID=WTM200502111723398547
I do not recommend their "greatest" and real "flag-ship" P4C800-E-Deluxe
motherboard for use with memory sizes above 3GB (although they claim 4GB
is possible). BIOS is the latest release 1.19, although 1.20.001 was tested
as well.


  
My questions to LKML people are:

1)  Could someone tell me what are the differences in
2.4.30-pre1 kernel'd dmesg and 2.6.11-rc4* dmesg outputs? For example, memory
areas "reserved twice" reported by 2.4.30-pre1. Also, differences in /proc/mtrr
under both kernels differ.

2)  How about the /proc/interrupts outputs? Aren't they too high? How about the
level/edge interrupt mappings? Would they help?

Please Cc: me in replies. Many thanks for any response, I have wasted seemingly
a lot of money on 2GB RAM. :(
martin

P.S.:

1GB DDR400 modules are Micron CL2.5 2bank 512M chip modules (64Mx8),
non-ecc, unbuffered

512MB DDR 500 modules (yes, PC4000, not PC3200 as is the max supported
by the motherboard) are Kingston HyperX modules, non-ecc, unbuffered.
