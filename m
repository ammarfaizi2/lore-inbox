Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUFAHnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUFAHnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 03:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUFAHnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 03:43:12 -0400
Received: from mail.wdsl.co.za ([196.28.86.3]:6092 "EHLO mail.uninetwork.co.za")
	by vger.kernel.org with ESMTP id S264920AbUFAHnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 03:43:05 -0400
Subject: Multiple CDR's on an IDE based system
From: Hamish Whittal <hamish@QEDux.co.za>
Reply-To: hamish@QEDux.co.za
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: QED Technologies cc
Message-Id: <1086083663.925.114.camel@defender.QEDux.co.za>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 01 Jun 2004 09:54:23 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I have tried, without success to solve this for the last couple of
weeks, so I am trying the guru's as a last resort.....

Here is the problem:

I have a machine that has 3 CDRW's in it. I have tried many different
configurations of these drives on various IDE controllers, but am still
having some problems.

I will try to sketch the scenario:
CDRW1 slave on controller with HDD
CDRW2 as master on second on-board IDE controller
CDRW3 as master on additional PCI IDE controller

(I have also tried adding 2 PCI IDE controllers, and putting each CDRW
as master on each of these controllers, but I get the FIFO buffer
dropping to 0% very soon after starting a write).

In this configuration, provided the writers are writing no faster than
16x (CDRW can write up to 52x) they seem to complete  - reading and
writing the correct number of bytes from the HDD and to the CDR. Any
other configuration seems to fail almost immediately. 

I am writing ISO images (from the HDD) to the CDR's simultaneously using
a parallel perl script which just calls the cdrecord program to actually
do the writing.

Problem is now though, that although cdrecord claims to have
read/written the correct number of bytes from the HDD to the CDR (which
I don't dispute since the files are all there), when I install, the
install seems to go fine bar a couple of files. It would seem that the
files are the same each time. Although they seem to be fine (in terms of
file size), they produce an Input/Output error when I try to install
just those files, or even just copy them.

I have tried writing the single ISO that seems problematic "by hand"
(i.e. not in parallel) and the problem does not seems to be present. It
only seems to raise it's head when I am writing the images
simultaneously. To me this indicates there may be interference on the
IDE bus - but this is a layman speaking(;

I did lots of searching on the Internet about this problem, and only
have found a couple of references to similar problems. (I also tried to
subscribe to the cdrecord mailing list, but seem to be getting emails
bounced saying that the email address I am sending to does not exist -
so not sure whether the list is still alive).

My machine is a Debian linux IDE based machine. The specs of the machine
are as follows:
CPU      : Intel(R) Pentium(R) 4 CPU 2.80GHz
2 IDE controllers, single 120GB HDD.
Additional PCI IDE controller

Kernel: 2.4.25-1-686

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: AOPEN    Model: CD-RW CRW5224    Rev: 1.07
Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
Vendor: AOPEN    Model: CD-RW CRW5224    Rev: 1.07
Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
Vendor: AOPEN    Model: CD-RW CRW5224    Rev: 1.07
Type:   CD-ROM                           ANSI SCSI revision: 02

CD record version:
Cdrecord-Clone 2.01a26 (i686-pc-linux-gnu)

cdrecord called as follows:
cdrecord -immed gracetime=2 -eject -v -tao dev=0,0,0
/distros/Debian/1Disc.iso

Naturally the other two drives are called with dev=0,1,0 and dev=0,2,0

I actually restrict the speed to 20x as if it writes faster the FIFO
buffer empties very quickly with the understood consequences.

Thanks for ANY help,

Kindest,

Hamish

