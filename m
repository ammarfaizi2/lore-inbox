Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267946AbRGVJY0>; Sun, 22 Jul 2001 05:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267945AbRGVJYQ>; Sun, 22 Jul 2001 05:24:16 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:51977 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267943AbRGVJYI>; Sun, 22 Jul 2001 05:24:08 -0400
Message-ID: <3B5A9AD8.FADBA3CF@namesys.com>
Date: Sun, 22 Jul 2001 13:20:24 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Jimmie Mayfield <mayfield+usenet@sackheads.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interesting disk throughput performance problem
In-Reply-To: <20010721233313.A15232@sackheads.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm just guessing here, but is write caching active on one but not the other?

Hans


Jimmie Mayfield wrote:
> 
> Hi.  I'm running into some disk throughput issues that I can't explain.
> Hopefully someone reading this can offer an explanation.
> 
> One of my machines is running 2.4.5 and has 2 hard drives: a 7200 rpm
> ATA100 Maxtor and a 5400 rpm ATA33 IBM.  Each drive is a master on its own
> controller (AMI CMD649 as found on the IWill KT266-R).  Both drives contain
> reiserfs 3.6x filesystems.
> 
> By all local benchmarks, the 7200 rpm drive is the faster drive.  But this
> doesn't seem to be the case for large files originating from remote clients.
> Witness:
> 
> My crude test involves scp'ing a 100MB file from another machine on my home
> network over 100bT ethernet.
> 
> 1)  scp to the 5400rpm drive:  roughly 10MB/sec.
> 2)  scp to the 7200rpm drive:  roughly 2MB/sec.
> 
> I've tried 'tail' and 'notail' mount options with no change (as expected since
> this is a single large file).  I suspect that the machine would become CPU-bound
> somewhere in the 20MB/sec range (see below for my reasoning).
> 
> I see the same sort of behavior using Samba though not nearly as
> pronounced (the 5400rpm drive is merely 2x as fast as the 7200rpm drive).
> 
> Okay.  Since the test involved 2 separate drives with different geometries,
> I figured this might be due to physical block location.  Perhaps the file
> is getting allocated to the fastest cylinders on the 5400 rpm drive and
> the slowest cylinders on the 7200 rpm drive.  Or it could be a fragmentation
> issue.
> 
> So I tried the test locally:  with the file stored on the 5400rpm drive,
> scp it to localhost and write it to the 7200rpm drive.  Results were a little
> below 10MB/sec (CPU near 100% presumably due to encrypting/decrypting on
> the fly).
> 
> Any ideas why the 7200rpm drive performs so poorly for remote clients but
> performs wonderfully well when those same operations are performed locally?
> 
> Jimmie
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
