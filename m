Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267958AbRGVKo4>; Sun, 22 Jul 2001 06:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbRGVKor>; Sun, 22 Jul 2001 06:44:47 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:39103 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267958AbRGVKok>; Sun, 22 Jul 2001 06:44:40 -0400
Message-ID: <016201c1129b$4e459b60$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Jimmie Mayfield" <mayfield+usenet@sackheads.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20010721233313.A15232@sackheads.org>
Subject: Re: Interesting disk throughput performance problem
Date: Sun, 22 Jul 2001 06:44:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Not enough info (plenty for guessing though :-)

First off show "hdparm -i /dev/hd_" and "hdparm /dev/hd_" -- this will
ensure both drives have things like DMA, etc.
Next -- you didn't say what benchmarks you're using locally.
And as the previous poster said provide "cat /proc/interrupts".

----- Original Message -----
From: "Jimmie Mayfield" <mayfield+usenet@sackheads.org>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, July 21, 2001 11:33 PM
Subject: Interesting disk throughput performance problem


> Hi.  I'm running into some disk throughput issues that I can't explain.
> Hopefully someone reading this can offer an explanation.
>
> One of my machines is running 2.4.5 and has 2 hard drives: a 7200 rpm
> ATA100 Maxtor and a 5400 rpm ATA33 IBM.  Each drive is a master on its own
> controller (AMI CMD649 as found on the IWill KT266-R).  Both drives
contain
> reiserfs 3.6x filesystems.
>
> By all local benchmarks, the 7200 rpm drive is the faster drive.  But this
> doesn't seem to be the case for large files originating from remote
clients.
> Witness:
>
> My crude test involves scp'ing a 100MB file from another machine on my
home
> network over 100bT ethernet.
>
> 1)  scp to the 5400rpm drive:  roughly 10MB/sec.
> 2)  scp to the 7200rpm drive:  roughly 2MB/sec.
>
> I've tried 'tail' and 'notail' mount options with no change (as expected
since
> this is a single large file).  I suspect that the machine would become
CPU-bound
> somewhere in the 20MB/sec range (see below for my reasoning).
>
> I see the same sort of behavior using Samba though not nearly as
> pronounced (the 5400rpm drive is merely 2x as fast as the 7200rpm drive).
>
> Okay.  Since the test involved 2 separate drives with different
geometries,
> I figured this might be due to physical block location.  Perhaps the file
> is getting allocated to the fastest cylinders on the 5400 rpm drive and
> the slowest cylinders on the 7200 rpm drive.  Or it could be a
fragmentation
> issue.
>
> So I tried the test locally:  with the file stored on the 5400rpm drive,
> scp it to localhost and write it to the 7200rpm drive.  Results were a
little
> below 10MB/sec (CPU near 100% presumably due to encrypting/decrypting on
> the fly).
>
> Any ideas why the 7200rpm drive performs so poorly for remote clients but
> performs wonderfully well when those same operations are performed
locally?
>
> Jimmie
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

