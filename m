Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTACPHp>; Fri, 3 Jan 2003 10:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTACPHp>; Fri, 3 Jan 2003 10:07:45 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:9744 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S267541AbTACPHo>;
	Fri, 3 Jan 2003 10:07:44 -0500
Date: Fri, 03 Jan 2003 08:14:06 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: dipankar@in.ibm.com, linux-scsi@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <596830816.1041606846@aslan.scsiguy.com>
In-Reply-To: <20030103101618.GB8582@in.ibm.com>
References: <20030103101618.GB8582@in.ibm.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like the aic7xxx driver in 2.5.53 and 54 are broken on my hardware.

It looks like the driver recovers fine.

...

> aic7xxx: PCI Device 0:1:0 failed memory mapped test.  Using PIO.
> Uhhuh. NMI received for unknown reason 25 on CPU 0.

SERR must be enabled by your BIOS.  I will change the driver so
that, should the memory mapped I/O test fail, an SERR (and thus an
NMI) is not generated.

...

> scsi0: PCI error Interrupt at seqaddr = 0x2
> scsi0: Signaled a Target Abort

These are left over from the failed memory mapped I/O test.  They
should have been cleared by the test, but the behavior must be
different for the 7896/97.  I'll review the documentation for this
chip and see if I can quiet up the failure.

Just out of curiosity, do you have any strange PCI options enabled
in your BIOS?  I remeber seeing memory mapped I/O failures on this
ServerWorks chipset under FreeBSD in the past, but an updated BIOS
resolved the issue for the affected users.  It seemed that the BIOS
incorrectly placed the Adaptec controller in a prefetchable region.

--
Justin

