Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267707AbRGUQW6>; Sat, 21 Jul 2001 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267710AbRGUQWt>; Sat, 21 Jul 2001 12:22:49 -0400
Received: from gear.torque.net ([204.138.244.1]:12814 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S267707AbRGUQWk>;
	Sat, 21 Jul 2001 12:22:40 -0400
Message-ID: <3B59AA91.46A38FD1@torque.net>
Date: Sat, 21 Jul 2001 12:15:13 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
        Detlev Offenbach <detlev@offenbach.fs.uunet.de>
Subject: Re: MO-Drive under 2.4.7 usinf vfat
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Detlev Offenbach <detlev@offenbach.fs.uunet.de> wrote:
> I have just tested the new 2.4.7 kernel to see, whether 
> it now works with a  MO-Drive using the vfat filesystem. 
> Unfortunately it still doesn't. Mounting a disk and 
> writing to it is ok. However, when I try to read a file 
> off the disk, the program crashes with a Segmentation 
> fault and I get a oops in the messages file (see 
> attachment). I tried ksymoops on this file, but either I 
> did something wrong or it couldn't analyse it.
> 
> I hope, this issue will be fixed soon cause I would 
> like to switch over to the 2.4 kernel series without 
> scratching my set of MO-disks.

Detlev,
I can confirm lk 2.4.6 is broken w.r.t. 2048 byte sectored
MO disks with vfat file systems. I have a FUJITSU  
Model: M25-MCC3064AP here (IDE device that uses the ide-scsi
driver) and it works just fine with dd (and through the sg 
interface). So I'm quite confident the failure is not being 
caused by the SCSI subsystem.

I cannot see any code changes in the sd driver between
lk 2.2 and lk 2.4 that impact this problem (as some
have suggested). When it works in lk 2.2 it follows
existing code pathes in the sd driver that exist and
work in the sd driver found in lk 2.4 .

Now the block subsystem might be expecting the sd driver
to play the same tricks as the sr driver in the way it
handles 2048 byte sectors. If so, that logic has never
been added to the sd driver. From memory there was a
thread on this issue that decided there were better ways
to address the block mismatch problem.

Anyway, I'll keep poking around.

Doug Gilbert

