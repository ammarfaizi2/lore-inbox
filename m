Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279969AbRKDIAo>; Sun, 4 Nov 2001 03:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279971AbRKDIAf>; Sun, 4 Nov 2001 03:00:35 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:56079 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S279969AbRKDIA2>;
	Sun, 4 Nov 2001 03:00:28 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 3 Nov 2001 23:49:51 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Skip Gaede <sgaede@mediaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  driver: ide-floppy.c  kernel >=2.4.7 
In-Reply-To: <200110300458.f9U4w6N17353@chmls05.mediaone.net>
Message-ID: <Pine.LNX.4.21.0111032310570.7850-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip,

 I've just got around to testing this. I didn't have problems with the
current version of ide-floppy, but I thought I'd give it a go anyway. I'm
sorry to say that the performance as standard is atrocious. I was
previously using 2.4.12-ac3 with the preempt patch, for these tests I
tried 2.4.13-ac6. (All tests at the console, no other conscious use of the
box.)

hdparm -Tt /dev/hdd1  cache              disk
2.4.12-ac3-preempt    52.67Mb/s          1.06Mb/s
2.4.13-ac6+your patch 52.89Mb/S        480.43kB/s
(above are worst of three, but there isn't wide variation)

time mke2fs /dev/hdd1   real    user     sys
2.4.12-ac3-preempt    0m4.252s 0m0.010s 0m0.090s
2.4.13-ac6+your patch 0m8.349s 0m0.000s 0m0.070s

Bonnie -s 85 -d /zip
           ---Sequential Output------- --Sequential Input--- Rnd Seek
              Char    Block    Rewrite    Char    Block       /sec
2.4.12-ac3  1246K/s  1504K/s    433K/s    702K/s  958K/s       30.0
2.4.13-ac6+  575K/s   699K/s    211K/s    347K/s  447K/s       20.9

This is on a K6/500, and with your patch the disk feels _so_ slow. I
accept it can be tweaked through the /proc interface, but if this is the
default behaviour, it's dreadful. I do wonder if you've got a flakey 
drive ? Sorry.

Ken

On Tue, 30 Oct 2001, Skip Gaede wrote:

> This patch fixes a lost interrupt problem with the Iomega ATAPI Zip 100 drive 
> on an Asus A7V133 board (uses South Bridge VIA VT82C686 chip). The problem 
> occurs when trying to format the drive using mke2fs /dev/hdx1. The patch 
> introduces an adjustable delay between the time the drive asserts DRQ and 
> deasserts BSY after issuing the packet command and before transferring the 12 
> byte packet.. With delays of 3-5 ticks, the filesystem creation occurs 
> without retries/resets. The delay can be adjusted through the proc interface 
> by adjusting the value assigned to the parameter ticks. (Without the patch, I 
> experienced 111 lost interrupts, resulting in an elapsed time of over 2 hours 
> to format the drive. With the patch, mke2fs completed in <15 seconds.)
> I am looking for testing, by others who have the internal Zip drive and may 
> have experienced the same problem, as well as comments.
> 
> Thanks,
> --Skip

-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net

