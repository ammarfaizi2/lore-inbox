Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbTCTLhy>; Thu, 20 Mar 2003 06:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbTCTLhy>; Thu, 20 Mar 2003 06:37:54 -0500
Received: from smtp02.wxs.nl ([195.121.6.54]:29926 "EHLO smtp02.wxs.nl")
	by vger.kernel.org with ESMTP id <S261380AbTCTLhu> convert rfc822-to-8bit;
	Thu, 20 Mar 2003 06:37:50 -0500
Date: Thu, 20 Mar 2003 12:47:01 +0100
From: Maarten Ghijsen <maarten.ghijsen@planet.nl>
Subject: wake_up call from IRQ handler freezes system (no Oops)
To: linux-kernel@vger.kernel.org
Message-id: <005501c2eed6$6ec71cb0$0400000a@mdomain.local>
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

I am designing a linux driver for a DVB/ASI PCI card. 

One of the IOCTL commands implemented in my driver allows the user to
transfer a buffer to the PCI card (using DMA). While the DMA is in progress
I want to sleep the user process/thread. For the sleeping I use the
wait_event function, which waits for an event that is 'fired' from the DMA
done interrupt (with wake_up call). As soon as the interrupt handler calls
the wake_up my system freezes completely, without any Oops or other
exception message. 

As far as I can gather from the linux device driver book and other sources
from drivers it is common practice to use a wake_up in the interrupt routine
to awaken any sleeping user threads. I am pretty sure that I have
initialised my wait_queue_head_t correctly with a call to
init_waitqueue_head.

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


