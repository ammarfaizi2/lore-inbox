Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSKFBSM>; Tue, 5 Nov 2002 20:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKFBSM>; Tue, 5 Nov 2002 20:18:12 -0500
Received: from tantale.fifi.org ([216.27.190.146]:23695 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265275AbSKFBSK>;
	Tue, 5 Nov 2002 20:18:10 -0500
To: Emmanuel Fuste <e.fuste@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx problem.
References: <1036535689.3349.36.camel@rafale>
From: Philippe Troin <phil@fifi.org>
Date: 05 Nov 2002 17:24:41 -0800
In-Reply-To: <1036535689.3349.36.camel@rafale>
Message-ID: <87bs53qyli.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fuste <e.fuste@wanadoo.fr> writes:

> Hi all,
> 
> I have a problem with an adaptec 2940u2w since ... a long time: I tried
> to get it working since kernel 2.3.9x.
> The board work fine in other computer on Linux.
> When I try on mine (old dual cpu i586 asus board) I got this kind of
> kernel messages at boot and less than five second later, the computer
> lock:
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x7
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x9
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x7
> scsi0: Data Parity Error Detected during address or write data phase
> scsi0: PCI error Interrupt at seqaddr = 0x8
> scsi0: Data Parity Error Detected during address or write data phase

8< snip >8

Which hardware is connected to your SCSI adapter? (hint: cat /proc/scsi/scsi)

I've found out that some IBM hard disks give the above error when too
many tagged commands are queued (firmware bug probably). I definitely
have a DDRS-39130D drive which shows this behavior. The old SCSI
driver (5.x) was not as bold as the 6.x driver which is in 2.4 with
regards to queueing: the 6.x driver use 253 tagged command openings by
default.

For me, passing `aic7xxx=tag_info:{{,,,8}}' to the kernel solved the
problems. The above tells the aic7xxx driver to limit tagged queuing
depth to 8 for the drive at ID 3 on the first aic7xxx adapter, but
YMMV.

Phil.
