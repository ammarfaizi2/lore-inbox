Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVGMXBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVGMXBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVGMW7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:59:01 -0400
Received: from taxbrain.com ([64.162.14.3]:56063 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S262210AbVGMRx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:53:26 -0400
From: "karl malbrain" <karl@petzent.com>
To: <linux-os@analogic.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Wed, 13 Jul 2005 10:53:19 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILAEAICEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0507130850110.18969@chaos.analogic.com>
X-Spam-Processed: petzent.com, Wed, 13 Jul 2005 10:49:33 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Wed, 13 Jul 2005 10:49:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion of setting the modem termio to a copy of the xterm
console state.  Unfortunately, it doesn't help, the system still goes
out-to-lunch on the non-blocking open, and becomes nearly completely
unresponsive at the console and to telnet sessions.

Yesterday evening after testing via a telnet connection, the problem finally
cleared itself up and everything started to work as expected (even from the
console).  This morning, after a re-boot, the problem at the console
reoccurs.  Note that this test is being done through an xterm session.

I've also noticed that the boot sequence probes for modems on the serial
ports.  Is it possible that 8250.c is having a problem servicing an
interrupt from a character/state-change left over from this initialization?

Thanks, karl m

-----Original Message-----
From: Richard B. Johnson
Sent: Wednesday, July 13, 2005 6:04 AM
To: karl malbrain
Cc: Linux-Kernel@Vger. Kernel. Org
Subject: RE: 2.6.9: serial_core: uart_open



The attached code will set the UART to a sane state, then
clear the local flag, then open, waiting for modem control.
It clearly works, executing `ps` from another terminal will
clearly show that the task waiting for modem-control to open,
will be sleeping.

There is nothing wrong with kernel code that calls schedule().
That's how unix-machines work. When they are waiting for something
to happen, they execute schedule() which gives the CPU to other
runable tasks. The call to schedule() returns each time the
run queue is traversed. The driver code again checks for whatever
it was waiting for, then if it hasn't happened, the cycle repeats.
This is called "sleeping". That's what sleeping is. There are some
macros that do the same thing. They have names like "wait_for...".






