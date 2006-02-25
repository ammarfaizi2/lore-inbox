Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWBYT3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWBYT3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWBYT3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:29:23 -0500
Received: from lucidpixels.com ([66.45.37.187]:29609 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1161084AbWBYT3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:29:22 -0500
Date: Sat, 25 Feb 2006 14:29:20 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <liml@rtr.ca>
cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4400A1BF.7020109@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602251427001.7283@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which kernel did you run your patch against?

With 2.6.16-rc4....

First patch looks good..

p34:/usr/src/linux# patch -p1 < /tmp/patch1
patching file drivers/scsi/libata-scsi.c

p34:/usr/src/linux# patch -p1 < /tmp/12_libata_ata_opcode.patch
patching file drivers/scsi/libata-core.c
Hunk #1 succeeded at 245 (offset -8 lines).
Hunk #2 succeeded at 267 (offset -8 lines).
Hunk #3 succeeded at 288 (offset -8 lines).
Hunk #4 succeeded at 310 (offset -8 lines).
Hunk #5 succeeded at 500 (offset -8 lines).
Hunk #6 succeeded at 626 (offset -8 lines).
patching file drivers/scsi/libata-scsi.c
Hunk #1 succeeded at 430 (offset -8 lines).
Hunk #2 succeeded at 509 (offset -8 lines).
Hunk #3 FAILED at 521.
Hunk #4 succeeded at 563 (offset -8 lines).
Hunk #5 succeeded at 638 (offset -8 lines).
Hunk #6 succeeded at 1329 (offset -8 lines).
1 out of 6 hunks FAILED -- saving rejects to file 
drivers/scsi/libata-scsi.c.rej
patching file include/linux/ata.h
patching file include/linux/libata.h
Hunk #1 succeeded at 373 (offset -47 lines).
Hunk #2 succeeded at 463 (offset -49 lines).
p34:/usr/src/linux# ls -ld /usr/src/linux
lrwxrwxrwx  1 root src 16 2006-02-25 14:24 /usr/src/linux -> 
linux-2.6.16-rc4/
p34:/usr/src/linux#

Here is the *.rej file:

# cat libata-scsi.c.rej
***************
*** 521,528 ****
         *ascq = 0x04; /*  "auto-reallocation failed" */

    translate_done:
-       DPRINTK(KERN_ERR "ata%u: translated op=0x%02x ATA stat/err 
0x%02x/%02x to "
-              "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode, drv_stat, 
drv_err,
                *sk, *asc, *ascq);
         return;
   }
--- 521,528 ----
         *ascq = 0x04; /*  "auto-reallocation failed" */

    translate_done:
+       DPRINTK(KERN_ERR "ata%u: translated op=0x%02x cmd=0x%02x ATA 
stat/err 0x%02x/%02x to "
+              "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode, cmd, 
drv_stat, drv_err,
                *sk, *asc, *ascq);
         return;
   }




On Sat, 25 Feb 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> Second patch fails for me.
> ..
>> Should I be using 2.6.16-rcX?
>
> Mmm... that's what I'm using (plus other patches),
> so, yes.. give that a try.  2.6.16 does seem to
> be shaping up to be a nice kernel.
>
> Cheers
>
