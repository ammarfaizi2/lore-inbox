Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVCaMFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVCaMFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCaMFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:05:50 -0500
Received: from general.keba.co.at ([193.154.24.243]:16317 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261381AbVCaMF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:05:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory stick
Date: Thu, 31 Mar 2005 14:05:25 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231D0@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory stick
Thread-Index: AcU1QFF38iOlLOROTf6+HZoNAW+U2wAorcsA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Latency is the subject of a separate email.  Does this 
> increase in latency 
> occur only when you see the errors, or whenever you do a large data 
> transfer?  In fact, I would suspect the errors to _decrease_ 
> the latency 
> with respect to a normal transfer.

I observe from <1 to 2 ms on successful transfers, and around 15 ms
latency when things go wrong.

I do not know what the kernel does internally, but I tried block
sizes from 512b to 8192kb with dd, and it did not make any
difference, neither w.r.t. timing nor w.r.t. errors.

> This indicates that the problem lies in the computer, or its USB 
> connectors and their electromagnetic environment.

Hmmm, hard to believe. It happens on all USB ports, on two
different controllers. The box is an industrial-grade
embedded control system, in a robust steel case. There is
no external USB cable involved, the stick is plugged directly
into the box. 

The USB ports of these boxes work fine in vxWorks
(don't know about Windows).

> > I suspect some kind of timing / bus / interrupt trouble, 
> either due to
> > the interrupt shared between uhci and e100, or due to the 
> extremely slow
> > PIO transfers (which seem to block interrupts).
> 
> Timing or interrupt trouble wouldn't cause the problems you see.  Bus
> utilization can cause problems, but they would be reported 
> differently.  
> I think your problem is due either to faulty hardware or to bad signal
> propagation.

If it's not caused by bus utilization or shared or lost irqs,
I think it is some kind of software problem, maybe in the driver,
maybe elsewhere: 
The dd command *always* runs fine for some time, up to now
the transfer never had any problems for the first 30 MB or so,
sometimes even for 500 MB on my 1 GB stick.

Is there any possibility for integer overflow?
Is there any data which may accumulate over time?

> > What can I do to solve or further analyze the problem?
> 
> Replace the USB cable.  Use a separate PCI USB controller 
> card, preferably 
> one with a high-speed USB controller

A cable is not involved, 
and the embedded system doesn't offer PCI slots.

> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: *** thread
> > awakened.
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: 
> Command READ_10
> > (10 bytes)
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:  28 
> 00 00 01 bd c0
> > 00 00 f0 00
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Bulk Command S
> > 0x43425355 T 0x38e L 122880 F 128 Trg 0 LUN 0 CL 10
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
> > usb_stor_bulk_transfer_buf: xfer 31 bytes
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Status code 0;
> > transferred 31/31
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: -- transfer
> > complete
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Bulk command
> > transfer result=0
> > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
> > usb_stor_bulk_transfer_sglist: xfer 122880 bytes, 30 entries
> > Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: 
> Status code -75;
> > transferred 19840/122880
> > Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: -- babble
> 
> This is not a "short read"; as the log says, it's a "babble". 
>  That means
> the computer's USB controller believed the device continued 
> transmitting
> past the time when it was supposed to stop.  Assuming the device is
> functioning correctly, either the USB controller is bad or 
> the signal was
> degraded.

But doesn't it say 19840 of 122880 transferred?
In all cases of trouble, the first number is smaller than the second.

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com

