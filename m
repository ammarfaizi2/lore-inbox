Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbULARQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbULARQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 12:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbULARQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 12:16:46 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:9644 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261361AbULARQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 12:16:41 -0500
Subject: Re: phase change messages cusing slowdown with sym53c8xx_2 driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20041201165654.GA32687@rx8.austin.ibm.com>
References: <20041130030212.GB22916@austin.ibm.com> 
	<20041201165654.GA32687@rx8.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Dec 2004 12:16:33 -0500
Message-Id: <1101921398.1930.24.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 11:56, Jose R. Santos wrote:
> > Nov 28 23:05:12 orb kernel: sym0: <896> rev 0x5 at pci 0000:00:0c.0 irq 20
> > Nov 28 23:05:12 orb kernel: sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
> > Nov 28 23:05:12 orb kernel: sym0: SCSI BUS has been reset.
> > Nov 28 23:05:12 orb kernel: scsi0 : sym-2.1.18m
> > Nov 28 23:05:12 orb kernel: sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
> > Nov 28 23:05:12 orb kernel:   Vendor: IBM       Model: DGHS09U	Rev: 03E0
> > Nov 28 23:05:12 orb kernel:   Type:   Direct-Access		ANSI SCSI revision: 03
> > Nov 28 23:05:12 orb kernel:  target0:0:1: Beginning Domain Validation
> > Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
> > Nov 28 23:05:12 orb last message repeated 10 times
> > Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@1005039c resid=6.
> > Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
> > Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
> > Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@1005039c resid=6.
> > Nov 28 23:05:12 orb kernel:  target0:0:1: Domain Validation skipping write tests
> > Nov 28 23:05:12 orb kernel:  target0:0:1: Ending Domain Validation
> > Nov 28 23:05:12 orb kernel: sym0:1:0:phase change 6-7 9@10050390 resid=6.
> > 
> > When these errors show up, the maximum performance I can get out of the disk is
> > about 1.3MB/s.  After several hours, the adapters seems to receive some ABORT 
> > operations and the messages stop showing.  Once this happens, performance for 
> > the disk goes back to 15MB/s.
> 
> I manage to get access to another PPC64 box that has uses this same
> driver and was unable to reproduce this problem here, but I was able to
> reproduce it on another same model machine.  Seem like there could be
> something at initialization that only affects this revision of the SCSI
> adapter.  Since the problem seems to disappear after a BUS RESET I assume
> that something was left out when the driver was initializing the adapter.

Matthew,

does this look like the "drive won't respond properly to PPR if the bus
is SE" problem again?

James


