Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbTCROMw>; Tue, 18 Mar 2003 09:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbTCROMw>; Tue, 18 Mar 2003 09:12:52 -0500
Received: from smtp09.wxs.nl ([195.121.6.38]:38647 "EHLO smtp09.wxs.nl")
	by vger.kernel.org with ESMTP id <S262423AbTCROMv> convert rfc822-to-8bit;
	Tue, 18 Mar 2003 09:12:51 -0500
Date: Tue, 18 Mar 2003 15:25:24 +0100
From: Maarten Ghijsen <maarten.ghijsen@planet.nl>
Subject: system hangs on wake_up call from IRQ handler
To: linux-kernel@vger.kernel.org
Message-id: <001301c2ed5a$37133380$0400000a@mdomain.local>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook, Build 10.0.4510
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am busy on writing a driver for a PCI Card. Amongst others my driver
includes an IOCTL command for starting a DMA transfer (user-->PCI card or
PCI card-->user). In my handler for this command I instruct the PciCard to
start a DMA transfer and than wait (sleep) for the DMA to complete. I wait
using the wait_event function, which waits for an event that is 'fired'
(wake_up) from the DMA done interrupt handler. As soon as I make the call to
wake_up, from the DMA done interrupt handler, my system hangs completely. 

Does anyone have any idea why the system hangs on the wake-up from the
interrupt handler?

Below you will find some pseudo code for with the wait_event and the
wake_up:

// wait from DMA IOCTL handler
void Dta1xxTxIoCtlDma()
{
	startdma();

	wait_event(my_wait_queue, ( 1==dma_done_flag) );

	return;
}

// wake_up from interrupt handler
void Dta1xxIRQ()
{
	if ( IsDmaDoneInterruptSet() ) {
		dma_done_flag = 1;
		wake_up(&my_wait_queue);
	}
}

I am using linux kernel version 2.4.18.

Regards,
 
Maarten


