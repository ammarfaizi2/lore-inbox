Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUACP6q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbUACP6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:58:46 -0500
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:39808 "HELO
	mail.nicke.nu") by vger.kernel.org with SMTP id S263539AbUACP6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:58:41 -0500
From: "Nicklas Bondesson" <nicke@nicke.nu>
To: "'Andre Tomt'" <lkml@tomt.net>, <crg@purplefields.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Subject: RE: IDE-RAID Drive Performance
Date: Sat, 3 Jan 2004 16:58:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <1073138426.8863.33.camel@slurv.pasop.tomt.net>
Thread-Index: AcPSAZ0o3u73udG/R0KEJRvJES4KaQAEC5xA
Message-Id: <S263539AbUACP6l/20040103155841Z+21583@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if you have read my latest post regarding this. anyway here it
is :)

It was the PCI latency value that was wrong. It was set to 0 in the BIOS so
I have changed it now to 64. I now get the following figures! :) BTW I'm
running two Western Digital WD800JB-00DUA3 (Special Edition 8 MB cache)
disks connected to a Promise TX2000 (PDC20271) card (RAID1 using ataraid
(pdcraid) drivers).

hdparm:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.12 seconds =114.29 MB/sec
 Timing buffered disk reads:  64 MB in  1.53 seconds = 41.83 MB/sec

bonnie:

Version 1.02b       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
%CP
gollum         800M  4681  98 37827  76 17590  30  4888  95 39400  26 310.4
3
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
%CP
                 16   310  99 +++++ +++ 21319 100   329  99 +++++ +++  1766
96
gollum,800M,4681,98,37827,76,17590,30,4888,95,39400,26,310.4,3,16,310,99,+++
++,+++,21319,100,329,99,+++++,+++,1766,96 

Thanks for the help!

/Nicke 

-----Original Message-----
From: Andre Tomt [mailto:lkml@tomt.net] 
Sent: den 3 januari 2004 15:00
To: Nuno Alexandre
Cc: linux-kernel@vger.kernel.org; Nicklas Bondesson
Subject: Re: IDE-RAID Drive Performance

On Tue, 2003-12-30 at 12:21, Nuno Alexandre wrote:
> /dev/hda:
>  Timing buffer-cache reads:   1320 MB in  2.00 seconds = 659.44 MB/sec
>  Timing buffered disk reads:  140 MB in  3.02 seconds =  46.40 MB/sec
> 
> Using:
> -d1 -u1 -m16 -c3 -W1 -A1 -k1 -X70 -a 8192

Wow, slow down for a minute. Most IDE chipset drivers does a excellent job
at autotuning the max *safe settings* for your drive/chipset combination.
Mucking around with hdparm parameters blindfolded will only cause you grief
in form of data loss and system instability sooner than later.

Usually when one gets into performance problems with IDE in Linux, the
chipset specific driver is not enabled, making the system fallback to the
generic driver - OR the drive and controller combination is considered
unsafe with faster settings.

Without any user intervention at all, my Seagate 7200 120G's does 55MB/s in
the infamious hdparm test, on a VIA KT266 based board, both in
2.6.1-rc1 and 2.4.23.



