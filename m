Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRAOVAB>; Mon, 15 Jan 2001 16:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRAOU7w>; Mon, 15 Jan 2001 15:59:52 -0500
Received: from heffalump.fnal.gov ([131.225.9.20]:27384 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S131474AbRAOU7f>;
	Mon, 15 Jan 2001 15:59:35 -0500
Date: Mon, 15 Jan 2001 14:59:27 -0600
From: Paul Hubbard <phubbard@fnal.gov>
Subject: 4G SGI quad Xeon - memory-related slowdowns
To: linux-kernel@vger.kernel.org
Cc: "Richard E. Jetton" <rjetton@fnal.gov>
Message-id: <3A6364AF.AC4D4081@fnal.gov>
Organization: Fermilab
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're having some problems with the 2.4.0 kernel on our SGI 1450, and
were hoping for some help.
 The box is a quad Xeon 700/2MB, with 4GB of memory, ServerSet III HE
chipset, RH6.1 (slightly modified for local configuration) distribution.

a) If we compile the kernel with no high memory support, /proc/meminfo
shows 1G of memory and everything works fine.

b) If we compile for 4G of memory, /proc/meminfo shows about 3G, and
overriding the amount at the lilo prompt causes kernel panics at bootup.
However, other than missing a quarter of the memory, it works just fine.

c) If we compile the kernel for 64G high memory (PAE mode), we see all
of the memory but have other problems:
  i) mkefs -m0 on a 72GB Seagate SCSI disk runs very slowly (about
5MB/sec instead of 22-25) and the machine hangs after the format
completes. To be exact, the command prompt returns, but
     ls or any other command will never return, and you have to reset
the box. This is a 
     showstopper for us!

  ii) If I override the amount of memory via lilo, we still get the
hang, but performance 
     actually improves! At 1G, it's slow for a few seconds, and then
runs fine. At 2G, it's 
     slow, and when I tried to boot 3G I got an odd startup crash that
I've not had time to
     replicate.

Other notes: 

1) SCSI is onboard Adaptec 39160 (aic7xxx driver, dual-channel) and
we've tried different drives, cables, terminators, etc. 

2) Other block I/O output (eg dd if=/dev/zero of=/dev/sdi bs=4M) also
run very slowly
3) We are using vmstat 1 to monitor data rates
4) I tried the format with 2.4 prerelease, and the mkfs was very slow,
and I got a SCSI reset at the end of the format. Perhaps this is
related?
5) If necessary, we can easily load a different distribution on the
machine if that might be part of the problem.

If necessary, we can setup a login on the machine, or run whatever test
code is necessary. Other than this, it's a pretty nice box to work on.

Please reply to rjetton and phubbard at fnal.gov, thanks.

-Paul

-- 
Paul Hubbard  phubbard@fnal.gov
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
