Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRCHSAp>; Thu, 8 Mar 2001 13:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRCHSAg>; Thu, 8 Mar 2001 13:00:36 -0500
Received: from pcsalo.cern.ch ([137.138.213.103]:46094 "EHLO pcsalo.cern.ch")
	by vger.kernel.org with ESMTP id <S129344AbRCHSAP>;
	Thu, 8 Mar 2001 13:00:15 -0500
Message-ID: <3AA7C88B.78BCFE5E@cern.ch>
Date: Thu, 08 Mar 2001 17:59:39 +0000
From: Fons Rademakers <Fons.Rademakers@cern.ch>
Organization: CERN
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andrea@suse.de
CC: linux-kernel@vger.kernel.org
Subject: Server tuning for maximum I/O performance...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

   we are trying to build Linux disk servers. We have the following setup:

- L440GX+ intel mobo, 133MHz PCI bus
- 2 dual PIII 700 MHz, 512 MB ECC
- 2 system disks 15 GB mirrored in hw
- 20 data disks IBM 75 GB nominal datarate between 20 and 34 MB/s
  (seq accesses) used in 10 mirrored hw file systems
  thus ~ 750 GB available on each system
- Each disk has its own EIDE channel
- 3x 8 port 3ware 6800 boards (total 24 channels)
- 1 GB eth NIC
- kernel 2.2.18

The machines are used to receive large data files. When the local disks
get to full files are migrated to tape via a remote tape server. The
only processes running are several remote file I/O daemons to receive
the data from GB eth and several migration daemons to send the data
over GB eth to the tape servers (no interactive users or other processes
are running on these machines).

Operating in this setup we observe the following behaviour:

# write streams   # read streams     write performance/stream (MB/s)
--------------------------------------------------------------------
1                 0                  25
2                 0                  14.5
3                 0                  9.3
1                 1                  13.6
1                 2                  8.8
1                 3                  6.3
2                 1                  9.3
2                 2                  6.5
2                 3                  5.1

As you can see the write performance is severely reduced as soon as
a process starts reading. All write and read streams are to separate
spindles, never will a single disk server more than one stream.

Aggregate datarate for the whole box is only 30-40 MB/s from disk to
network or vice versa. Although network alone can go up to 60 MB/s (full
duplex) and disk alone goes up to 100 MB/s, combining the two drops to 
max 30-40 MB/s.

Are this numbers you expect from the Linux kernel? Are they compatible
with the current PC hardware architecture? To get better performance
what would you advice changing (software, hardware, tuning)?

Thanks for any suggestions.


Cheers, Fons.

-- 
Org:    CERN, European Laboratory for Particle Physics.
Mail:   1211 Geneve 23, Switzerland
E-Mail: Fons.Rademakers@cern.ch              Phone: +41 22 7679248
WWW:    http://root.cern.ch/~rdm/            Fax:   +41 22 7677910
