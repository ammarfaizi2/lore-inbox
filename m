Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRDMVsc>; Fri, 13 Apr 2001 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRDMVsW>; Fri, 13 Apr 2001 17:48:22 -0400
Received: from denise.shiny.it ([194.20.232.1]:26502 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S131953AbRDMVsP>;
	Fri, 13 Apr 2001 17:48:15 -0400
Message-ID: <3AD7745E.1E5C7E99@denise.shiny.it>
Date: Fri, 13 Apr 2001 23:49:18 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx driver problems
In-Reply-To: <200104122036.f3CKa1s70637@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What's the PCI id of the card you are using?

  Bus  1, device   3, function  0:
    Class 0100: PCI device 9004:5078 (rev 3).
      IRQ 24.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
      I/O at 0x1800 [0x18ff].
      Non-prefetchable 32 bit memory at 0x80881000 [0x80881fff].

> >Plain v6.1.11 hangs. It prints scsi0: blah blah scsi1: sdfdfgsg, I hear the cd
> >spinning up and nothing more.
>
> Did you apply a patch, or upgrade using the tar file?  If the latter,
> you're missing some changes to the SCSI layer that make the initial
> bus settle delay implimentation more sane.

Ok, I used the patch and it boots. Now CDROM and MO seem to work fine, but
when I work from the console I get this junk while accessing HD. It happens
much more frequently when the SCSI bus it set at 10MB/s than when it's at
20MB/s (with my small patch).

[...]
Apr 13 22:36:09 Jay kernel: Saw underflow (2048 of 2048 bytes). Treated as
error 
Apr 13 22:36:09 Jay kernel: Saw underflow (4096 of 4096 bytes). Treated as
error 
Apr 13 22:36:09 Jay kernel: Saw underflow (2048 of 2048 bytes). Treated as
error 
Apr 13 22:36:09 Jay kernel: SCSI disk error : host 0 channel 0 id 2 lun 0
return code = 70000 
Apr 13 22:36:09 Jay kernel: Saw underflow (4096 of 4096 bytes). Treated as
error 
Apr 13 22:36:09 Jay kernel:  I/O error: dev 08:09, sector 1654820 
Apr 13 22:36:09 Jay kernel: Saw underflow (4096 of 4096 bytes). Treated as
error 
Apr 13 22:36:09 Jay kernel: SCSI disk error : host 0 channel 0 id 2 lun 0
return code = 70000 
Apr 13 22:36:09 Jay kernel:  I/O error: dev 08:09, sector 1572948 
Apr 13 22:36:19 Jay kernel: Saw underflow (8192 of 8192 bytes). Treated as
error 
Apr 13 22:36:19 Jay last message repeated 3 times
Apr 13 22:36:19 Jay kernel: Saw underflow (7168 of 7168 bytes). Treated as
error 
Apr 13 22:36:20 Jay last message repeated 4 times
Apr 13 22:36:20 Jay kernel: SCSI disk error : host 0 channel 0 id 2 lun 0
return code = 70000 
Apr 13 22:36:20 Jay kernel:  I/O error: dev 08:09, sector 370704 
[...]

One time I got this:

Apr 13 22:44:55 Jay kernel: (scsi0:A:2:0): Locking max tag count at 64

Bye.
