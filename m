Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285972AbRLHVdm>; Sat, 8 Dec 2001 16:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285974AbRLHVdd>; Sat, 8 Dec 2001 16:33:33 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:51194 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S285972AbRLHVdV>; Sat, 8 Dec 2001 16:33:21 -0500
Message-ID: <3C11358D.28400117@sympatico.ca>
Date: Fri, 07 Dec 2001 16:33:01 -0500
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: software raid issues -- possible kernel I/O problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just installed some new ata100 hard drives and matching controller
card in a machine running 2.4.16, and have been experimenting with
software raid.  I've run into some interesting issues with regards to
transfer speeds.

I've got md0 as a raid0, and md1 as a raid1.  hda is an older ata33
drive connected as master to the motherboard, while hde and hdg are the
new ata100 drives each connected as master on one of the two channels on
the adapter (but the adapter only has one IRQ, so I don't know how that
will affect things...).

Using hdparm, I get the following results:

md0: 98.46/42.67
md1: 98.46/29.22
hda: 98.46/9.1
hde: 97.71/31.37
hdg: 96.24/30.92

I also tried some simultaneous runs, with results as follows:
hde and hdg:  50.20/23.27  and  53.56/21.77
hde and hda:  50.59/29.09  and  55.90/9.17


So, my observations are as follows:

1) It seems as though I can't get aggregate burst speeds up above about
100MB/s no matter what I do, even when it's on separate interfaces with
separate IRQs.  Is this running into the limitation of the PCI bus?  I'm
also somewhat confused as to how my old ata33 drive managed to score
nearly 100MB/s burst speed, as well as how some people are claiming
scores of 160MB/s on a ata100 drive (and why I'm not getting that on
mine).

2) Similarly, actual read speads appear limited to an agregate of about
45MB/s in both the raid-0 and simultaneous runs. Why am I not getting
twice the throughput of the single drive case?  Could this be due to the
ata100 controller only using a single IRQ?

3) It doesn't appear as though raid-1 reads are being parallelized. 
This surprised me, as I thought that raid-1 was supposed to come close
to raid-0 in terms of read performance.  Anyone have any ideas about why
this isn't happening?

I'd appreciate any comments you have, or if this isn't the right place
to talk about this, then a redirection to the appropriate forum.

Thanks,

Chris
