Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTAEQoO>; Sun, 5 Jan 2003 11:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTAEQoO>; Sun, 5 Jan 2003 11:44:14 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:6921 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264915AbTAEQoO>; Sun, 5 Jan 2003 11:44:14 -0500
Date: Sun, 05 Jan 2003 09:52:46 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Message-ID: <452090000.1041785566@aslan.scsiguy.com>
In-Reply-To: <013401c2b4d2$d9aab390$2101a8c0@witbe>
References: <013401c2b4d2$d9aab390$2101a8c0@witbe>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
>> > Out of this, two problems :
>> >  - AIC7xxx fails to use DMA, with :
>> > aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
>> > scsi0: PCI error Interrupt at seqaddr = 0x3
>> > scsi0: Signaled a Target Abort
>> 
>> This is because your system is violating the PCI spec.  There 
> Waouh.... It is a quite new MB... I wasn't expecting it to be
> so bad...

There may be options in your BIOS to disable this "feature".  Look
for things like "PCI byte-merging" and/or "PCI read prefetch".  I
haven't had access to one of the new SIS based P4 systems yet, so
I don't know how they are setup or exactly how they are violating
the PCI spec.  The test will fail either if byte-merging or read
prefetch occurs and perhaps if there is an MTTR covering the memory
mapped region of the chip that is set to write combining mode (I
don't think that the mb() we issue after every memory write helps
in this last case).

--
Justin

