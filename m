Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTL1Oiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 09:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTL1Oip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 09:38:45 -0500
Received: from ms-smtp-01-qfe0.nyroc.rr.com ([24.24.2.55]:51847 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261539AbTL1Oim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 09:38:42 -0500
From: craig duncan <duncan@nycap.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16366.60194.935861.592797@nycap.rr.com>
Date: Sun, 28 Dec 2003 09:39:30 -0500
To: linux-kernel@vger.kernel.org
Subject: CD burn buffer underruns on 2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first attempts at burning on 2.6 resulted in a couple of coasters
(i'm running the "stock" 2.6 Debian kernel: kernel-image-2.6.0-test9-1-386).
Burn speed was 8x (max speed for my PleXwrite 8/4/32A).  With the 2.4
kernel (2.4.22-1-k7 on a 1.3 gig Athlon) i never had a problem burning
at 8x (in fact, when burning completes, it always tells me:
Buffer fill min 93%/max 100%.

At 4x, burns on 2.6 work fine, though.  At 8x, the burn always craps out
shortly after starting.  This is completely consistent... 8x fails, 4x
works (see cdrdao output below).  Nothing else is going on on my system.
Running as root or regular user doesn't matter.

After a few of these failed burns ("cdrdao simulate...", actually) i saw
this in /var/log/kern.log:

Dec 24 08:24:44 cdw kernel: cdrom_newpc_intr: 110 residual after xfer
Dec 24 08:24:57 cdw kernel: cdrom_newpc_intr: 104 residual after xfer
Dec 24 08:25:43 cdw kernel: cdrom_newpc_intr: 110 residual after xfer
Dec 24 08:25:55 cdw kernel: cdrom_newpc_intr: 104 residual after xfer
Dec 24 08:26:52 cdw kernel: cdrom_newpc_intr: 110 residual after xfer
Dec 24 08:27:03 cdw kernel: cdrom_newpc_intr: 104 residual after xfer

As a side note, under 2.6, i see these "resid: 110", "resid: 104", etc.
messages in the cdrdao output (below) which i never saw under 2.4.

Here's my cdrdao output:
-----
Starting write simulation resid: 110
at speed 8...
Pausing 10 seconds - hit CTRL-C to abort.
Process can be aborted with QUIT signal (usually CTRL-\).
resid: 104
Writing CD-TEXT lead-in...
Writing track 01 (mode AUDIO/AUDIO )...
Writing track 02 (mode AUDIO/AUDIO )...
?: Success.  : scsi sendcmd: no error
CDB:  2A 00 00 00 26 80 00 00 1A 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: F0 00 03 00 00 27 18 0A 00 00 00 00 0C 09 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x09 (write error - loss of streaming) Fru 0x0
Sense flags: Blk 10008 (valid) 
resid: 61152
cmd finished after 0.014s timeout 180s
ERROR: Write data failed.
ERROR: Writing failed - buffer under run?
ERROR: Simulation failed.

I looked through the kernel archives and didn't see anyone else
reporting this problem but it seems kind of serious to me.
