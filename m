Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRIATMD>; Sat, 1 Sep 2001 15:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIATLx>; Sat, 1 Sep 2001 15:11:53 -0400
Received: from imo-r04.mx.aol.com ([152.163.225.100]:26076 "EHLO
	imo-r04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S271226AbRIATLq>; Sat, 1 Sep 2001 15:11:46 -0400
From: Floydsmith@aol.com
Message-ID: <95.fbc8570.28c28cb3@aol.com>
Date: Sat, 1 Sep 2001 15:10:43 EDT
Subject: Re2: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works
To: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a message dated 9/1/2001 2:08:46 PM Eastern Daylight Time, mikpe@csd.uu.se 
writes:

> Subj:  Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-
> scsi works in 2.4.4
>  Date:    9/1/2001 2:08:46 PM Eastern Daylight Time
>  From:    mikpe@csd.uu.se (Mikael Pettersson)
>  To:  Floydsmith@aol.com
>  CC:  linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org
>  
>  On Sat, 1 Sep 2001 11:03:12 EDT, Floydsmith@aol.com wrote:
>  
> Now, I can get everything (my ide ls-120 and ide HP 8Gig tape) to work in 
> ...
>  If I try not to use SCSI emulation for all 2.4.x kernels (including:
>  Kernel 2.4.9-ac5 on  i686
>  then
>  ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
>  tar: /dev/ht0: Cannot read: Input/output error
>  (writes work OK though)
>  
>  As mentioned above, scsi emulation works for 2.4.4 (reads and writes). But 
> if 
>  turned on in 2.4.9-ac5, then I get
>  /dev/st0: No such device
>  
>  FWIW, my Seagate 4/8 GB ATAPI tape drive works just fine in all
>  2.4.x kernels as /dev/{n,}ht0 -- no SCSI emulation for me.
>  
>  There are two known problem areas, which may or may not explain
>  your problems:
>  - block size: The 2.4 ide-tape driver only works reliably if you
>    write data with the correct block size. If you don't write full
>    blocks the last block of data may not be readable.
>    The driver will log the block size to the kernel log when it's
>    initializing, so you can take that value and pass it to your
>    backup utility (26KB in my case so I pass -b52 to tar).
>  - HP's not-quite ATAPI drives: Don't know about your model, but the
>    HP 14(?)GB model is believed to deviate from ATAPI standards.
>  
>  /Mikael

I can write (and even read OK) as long as use a mode (scsi emu for 2.4.4 or 
less) or kernel 2.2.18 (without scsi emu). For the backups that I am having 
trouble I can not read even the very first block under 2.4.x. If there was a 
block size problem, I don't see how I would be able to do that. Also, If 
there was a tar application block size problem, then I would think the 
problem would occur with all kernels. If you are sure that you can "read" the 
tapes using 2.4.x kernels without scsi emu, then this means something is 
broken in 2.4.x series with regards to my particular model (HP 8 Gig). Maybe 
a fix to make the driver more compatable with the true statandard broke 
something for HP drives.

Floyd,
