Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282889AbRK0JO0>; Tue, 27 Nov 2001 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282891AbRK0JOR>; Tue, 27 Nov 2001 04:14:17 -0500
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:22422 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id <S282889AbRK0JOG>; Tue, 27 Nov 2001 04:14:06 -0500
From: "Ahmed Masud" <masud@googgun.com>
To: "'Nicolas Pitre'" <nico@cam.org>, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Nathan G. Grennan'" <ngrennan@okcforum.org>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: Unresponiveness of 2.4.16
Date: Tue, 27 Nov 2001 04:12:59 -0500
Message-ID: <000901c17723$b641c990$8604a8c0@googgun.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Nicolas
> Pitre Sent: Monday, November 26, 2001 6:34 PM
> To: Alan Cox
> Cc: Nathan G. Grennan; lkml
> Subject: Re: Unresponiveness of 2.4.16
> 
> 
> On Mon, 26 Nov 2001, Alan Cox wrote:
> 
> > > 2.4.16 becomes very unresponsive for 30 seconds or so at a time
> > >  during large unarchiving of tarballs, like tar -zxf 
> > > mozilla-src.tar.gz. The file is about 36mb. I run top in 
> one window, 
> > > run free repeatedly in
> > 
> > This seems to be one of the small as yet unresolved 
> problems with the 
> > newer VM code in 2.4.16. I've not managed to prove its the 
> VM or the 
> > differing I/O scheduling rules however.
> 
> FWIW...
> 
> I experienced quite the same unresponsiveness but more in the 
> order of 4-5 seconds since I started to use ext3 with RH 7.2 
> (i.e. kernel 2.4.7 based).  
> I'm currently running 2.4.15-pre7 and the same momentary 
> stalls are there just like with 2.4.7. It is much more 
> visible when applying large patches to a kernel source tree 
> as the patch output stops scrolling from time to time for 
> about 5 secs.  I never saw such thing while previously using 
> reiserfs.  
> I've yet to try reiserfs on a 2.4.16 tree to see if this is 
> actually an ext3 problem.
> 
> 

Just to add to the above something I've experienced:

2.4.12 - 2.4.14 on a number of AMD Athelon 900 with 256 MB 
RAM doing serial I/O would miss data while any DISK writes would
occure. 

Reads would be okay but writes of any significance like untarring a 
relatively large tar ball ( > 10 megs ).  

While turning on UDMA for PROMISE PDC20265 chipset significantly
reduced the
Slugishness (by an order of magnitude)  the problem would still crop
up
Whenever there were more than three processing doing disk writing.


CPU: 				AMD 900 Athelon 
Chipset: 			VIA
IDE Controller:		PROMISE PDC20265
Disks:			IBM ATA100 IC35L020AVER07-0

I tried the same operations on  Reiserfs, ext2 and ext3; on direct
partitions 
on software raid 1 devices and on LVM  ( 1.0.1-rc4 patches from
sistina ).  

All permutations with all kernels 2.4.12 thru to 2.4.14 yield
identical results
... Loss of data while selecting on serial ports while there are
heavy writes to 
the file system.

Doing the same operation on same hardware with 2.2.16 yields no loss
of data.

Perhaps if I can get some guidance as to what else to try to resolve
whether this is
a VM related problem or an IO subsystem related problem, I'll be more
than happy to 
experiment and relay the results.

Ahmed

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBPANZG+A+WVFT6/r4EQL7PgCg3dWSrBDxsxqCF6OY1YiKDiEd34sAnA4W
S6Zb2wfzBj6bXETTFNoYzTlW
=HFWs
-----END PGP SIGNATURE-----

