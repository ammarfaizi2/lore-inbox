Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136970AbRA1MN0>; Sun, 28 Jan 2001 07:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136682AbRA1MNQ>; Sun, 28 Jan 2001 07:13:16 -0500
Received: from front4m.grolier.fr ([195.36.216.54]:35009 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S136168AbRA1MNJ> convert rfc822-to-8bit; Sun, 28 Jan 2001 07:13:09 -0500
Date: Sun, 28 Jan 2001 12:12:17 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: paradox3 <paradox3@maine.rr.com>
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar>
Message-ID: <Pine.LNX.4.10.10101281157220.1110-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, paradox3 wrote:

> I have an SMP machine (dual PII 400s) running 2.2.16 with one 10,000 RPM IBM
> 10 GB SCSI drive
> (AIC 7890 on motherboard, using aic7xxx.o), and four various IDE drives. The
> SCSI drive
> performs the worst. In tests of writing 100 MB and sync'ing, one of my IDE
> drives takes 31 seconds. The SCSI drive (while doing nothing else) took
> 2 minutes, 10 seconds. This is extremely noticable in file transfers that
> completely
> monopolize the SCSI drive, and are much slower than when involving the IDE
> drives.
> After a large data operation on the SCSI drive, the system will hang for
> several minutes.
> Anyone know what could be causing this? Thanks.
> 
> Attached are some data to help.

You didn't provide enough information for anybody to have a single idea
about the cause of the problem you report, in my opinion.

Just any not too old 10,000 RPM disk is able to sustain more that 25 MB/s
sequential data transfer, but cannot do better than 5 milli-seconds
latency with random IO patterns. So, result for 100 MB transfer can be
less than 4 seconds in the best case but greater than (25000*5)/1000=125
seconds for random 4K IO pattern, for example.

What you want to do, in my opinion, could be:

- Check in the syslog the actual transfer speed that has been negotiated
  for your SCSI disk.
- Also check if error messages related to disk IOs have been reported by 
  the kernel.
- Run some benchmark to check, at least, sequential IO performance (iozone
  for example will fit)

Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
