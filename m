Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271006AbRIASI1>; Sat, 1 Sep 2001 14:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270999AbRIASIS>; Sat, 1 Sep 2001 14:08:18 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:21725 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S270958AbRIASIJ>;
	Sat, 1 Sep 2001 14:08:09 -0400
Date: Sat, 1 Sep 2001 20:08:21 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109011808.UAA20786@harpo.it.uu.se>
To: Floydsmith@aol.com
Subject: Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
Cc: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001 11:03:12 EDT, Floydsmith@aol.com wrote:

>Now, I can get everything (my ide ls-120 and ide HP 8Gig tape) to work in 
>...
>If I try not to use SCSI emulation for all 2.4.x kernels (including:
>Kernel 2.4.9-ac5 on  i686
>then
>ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
>tar: /dev/ht0: Cannot read: Input/output error
>(writes work OK though)
>
>As mentioned above, scsi emulation works for 2.4.4 (reads and writes). But if 
>turned on in 2.4.9-ac5, then I get
>/dev/st0: No such device

FWIW, my Seagate 4/8 GB ATAPI tape drive works just fine in all
2.4.x kernels as /dev/{n,}ht0 -- no SCSI emulation for me.

There are two known problem areas, which may or may not explain
your problems:
- block size: The 2.4 ide-tape driver only works reliably if you
  write data with the correct block size. If you don't write full
  blocks the last block of data may not be readable.
  The driver will log the block size to the kernel log when it's
  initializing, so you can take that value and pass it to your
  backup utility (26KB in my case so I pass -b52 to tar).
- HP's not-quite ATAPI drives: Don't know about your model, but the
  HP 14(?)GB model is believed to deviate from ATAPI standards.

/Mikael
