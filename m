Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbUK3DCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbUK3DCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUK3DCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:02:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27269 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261820AbUK3DCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:02:34 -0500
Date: Mon, 29 Nov 2004 21:02:12 -0600
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: phase change messages cusing slowdown with sym53c8xx_2 driver
Message-ID: <20041130030212.GB22916@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm having a bit of trouble with a integrated SCSI adapter using the 
sym53c8xx_2 driver on a RS6K-170.  Somewhere during 2.6.9 development I started
seeing a bunch of "phase change" messages generated every time I did any IO on 
the disks attached to the SCSI adapter.

Nov 28 23:05:12 orb kernel: sym0: <896> rev 0x5 at pci 0000:00:0c.0 irq 20
Nov 28 23:05:12 orb kernel: sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
Nov 28 23:05:12 orb kernel: sym0: SCSI BUS has been reset.
Nov 28 23:05:12 orb kernel: scsi0 : sym-2.1.18m
Nov 28 23:05:12 orb kernel: sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
Nov 28 23:05:12 orb kernel:   Vendor: IBM       Model: DGHS09U	Rev: 03E0
Nov 28 23:05:12 orb kernel:   Type:   Direct-Access		ANSI SCSI revision: 03
Nov 28 23:05:12 orb kernel:  target0:0:1: Beginning Domain Validation
Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
Nov 28 23:05:12 orb last message repeated 10 times
Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@1005039c resid=6.
Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@1005039c resid=6.
Nov 28 23:05:12 orb kernel:  target0:0:1: Domain Validation skipping write tests
Nov 28 23:05:12 orb kernel:  target0:0:1: Ending Domain Validation
Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.

When these errors show up, the maximum performance I can get out of the disk is
about 1.3MB/s.  After several hours, the adapters seems to receive some ABORT 
operations and the messages stop showing.  Once this happens, performance for 
the disk goes back to 15MB/s.

Nov 29 06:32:43 orb kernel: sym0:1:0: ABORT operation started.
Nov 29 06:32:43 orb kernel: sym0:1:control msgout: 80 6.
Nov 29 06:32:43 orb kernel: sym0:1:0: ABORT operation complete.
Nov 29 06:32:53 orb kernel: sym0:1:0: ABORT operation started.
Nov 29 06:32:53 orb kernel: sym0:1:0: ABORT operation complete.
Nov 29 06:32:53 orb kernel: sym0:1:0: ABORT operation started.
Nov 29 06:32:53 orb kernel: sym0:1:control msgout: 80 6.
Nov 29 06:32:53 orb kernel: sym0:1:0: ABORT operation complete.
Nov 29 06:32:53 orb kernel: sym0:1:0:phase change 6-7 9@10050b90 resid=6.
Nov 29 06:32:53 orb kernel: sym0:1:0: DEVICE RESET operation started.
Nov 29 06:32:53 orb kernel: sym0:1:0: DEVICE RESET operation complete.
Nov 29 06:32:53 orb kernel: sym0:1:control msgout: c.
Nov 29 06:32:53 orb kernel: sym0: TARGET 1 has been reset.
Nov 29 06:33:03 orb kernel: sym0:1:0: ABORT operation started.
Nov 29 06:33:03 orb kernel: sym0:1:0: ABORT operation complete.
Nov 29 06:33:03 orb kernel: sym0:1:0: BUS RESET operation started.
Nov 29 06:33:03 orb kernel: sym0:1:0: BUS RESET operation complete.
Nov 29 06:33:03 orb kernel: sym0: SCSI BUS reset detected.
Nov 29 06:33:03 orb kernel: sym0: SCSI BUS has been reset.
Nov 29 06:33:14 orb kernel: sym0:1:0:phase change 6-7 9@10050b90 resid=6.
Nov 29 06:33:14 orb kernel: sym0:1:0:phase change 6-7 9@10050b9c resid=6.

The last kernel I tried was a bk pull this Sunday and it still show the 
problem.  I don't know enough about SCSI to figure out whats going on.  Anybody
care to enlighten me as to what the problem is.

Thanks

-JRS
