Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbRGVDdW>; Sat, 21 Jul 2001 23:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267877AbRGVDdM>; Sat, 21 Jul 2001 23:33:12 -0400
Received: from haybaler.sackheads.org ([209.133.38.16]:12816 "HELO
	haybaler.sackheads.org") by vger.kernel.org with SMTP
	id <S267876AbRGVDdJ>; Sat, 21 Jul 2001 23:33:09 -0400
Date: Sat, 21 Jul 2001 23:33:13 -0400
From: Jimmie Mayfield <mayfield+usenet@sackheads.org>
To: linux-kernel@vger.kernel.org
Subject: Interesting disk throughput performance problem
Message-ID: <20010721233313.A15232@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi.  I'm running into some disk throughput issues that I can't explain.
Hopefully someone reading this can offer an explanation.

One of my machines is running 2.4.5 and has 2 hard drives: a 7200 rpm
ATA100 Maxtor and a 5400 rpm ATA33 IBM.  Each drive is a master on its own
controller (AMI CMD649 as found on the IWill KT266-R).  Both drives contain
reiserfs 3.6x filesystems.  

By all local benchmarks, the 7200 rpm drive is the faster drive.  But this 
doesn't seem to be the case for large files originating from remote clients.  
Witness:

My crude test involves scp'ing a 100MB file from another machine on my home 
network over 100bT ethernet.

1)  scp to the 5400rpm drive:  roughly 10MB/sec.  
2)  scp to the 7200rpm drive:  roughly 2MB/sec.  

I've tried 'tail' and 'notail' mount options with no change (as expected since 
this is a single large file).  I suspect that the machine would become CPU-bound 
somewhere in the 20MB/sec range (see below for my reasoning).

I see the same sort of behavior using Samba though not nearly as 
pronounced (the 5400rpm drive is merely 2x as fast as the 7200rpm drive).

Okay.  Since the test involved 2 separate drives with different geometries,
I figured this might be due to physical block location.  Perhaps the file
is getting allocated to the fastest cylinders on the 5400 rpm drive and
the slowest cylinders on the 7200 rpm drive.  Or it could be a fragmentation
issue.

So I tried the test locally:  with the file stored on the 5400rpm drive, 
scp it to localhost and write it to the 7200rpm drive.  Results were a little 
below 10MB/sec (CPU near 100% presumably due to encrypting/decrypting on 
the fly).

Any ideas why the 7200rpm drive performs so poorly for remote clients but 
performs wonderfully well when those same operations are performed locally?

Jimmie

