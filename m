Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSLUAng>; Fri, 20 Dec 2002 19:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSLUAng>; Fri, 20 Dec 2002 19:43:36 -0500
Received: from H162.C233.tor.velocet.net ([216.138.233.162]:31461 "HELO
	stark.dyndns.tv") by vger.kernel.org with SMTP id <S261376AbSLUAne>;
	Fri, 20 Dec 2002 19:43:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with read blocking for a long time on /dev/scd1
From: Gregory Stark <gsstark@mit.edu>
Date: 20 Dec 2002 19:51:38 -0500
Message-ID: <874r98b3dx.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a problem with ogle that seems to be being caused by the scsi or
ide-scsi driver. The video playback freezes for a second or randomly,
sometimes every few seconds, sometimes not for several minutes. Every such
glitch is correlated perfectly with a read syscall reading on /dev/scd1
blocking for an inordinate amount of time.

Most read syscalls from ogle seem to take between 30us to 100ms depending on
the size of the read. In fact plotting the time taken reported by strace -T vs
the size of the read in gnuplot produces a nice obvious linear correlation.

However occasionally there are outlier samples where the read call blocks for
between 150ms up to 1s or more. I've seen it block for about 10s once.

I've tried this on a machine that was essentially in single-user mode. The
only processes running were X, ogle, an xterm, and not much else. I'll include
my normal lsmod output below but the problem still occurred when playing with
hardly any modules loaded.

There's an FAQ about ogle glitching like this when something tries to probe
the cd drive, but nothing like that is running. And the glitches aren't
periodic like that FAQ describes.

The problem is definitely that the kernel simply doesn't schedule the process
calling read for over a second. 

There are no dmesg messages or other indication of problems in the ide-scsi or scsi
drivers.

Where would I start to track down what is preventing the kernel from
scheduling this process? It's presumably some problem in the ide or ide-scsi
driver, but I'm not sure where to start.

[I'm having trouble sending messages to the list, my ISPs mail server didn't
seem to deliver it the first time. My apologies if it finally makes it through
and this is a duplicate]

--
greg

