Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCSH3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCSH3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:29:47 -0500
Received: from [202.38.53.221] ([202.38.53.221]:41455 "EHLO and-or.com")
	by vger.kernel.org with ESMTP id S261418AbUCSH3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:29:45 -0500
Message-ID: <004501c40d83$0b07e480$d054ca86@siran>
From: "Muhammad Mutahir Latif" <mutahir@and-or.com>
To: <linuxsa@linuxsa.org.au>, <linux-list@ssc.com>,
       <linux-smp@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: problem with Local-PCI interrupts in drivers on xeon systems IBX Xseries server
Date: Fri, 19 Mar 2004 12:23:14 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-Spam-Processed: and-or.com, Fri, 19 Mar 2004 12:30:04 +0500
	(not processed: message from valid local sender)
X-Return-Path: mutahir@and-or.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Ive written a driver for a PCI-PLX board with a DSP on it. In order to
perform operations on the board the Host must send to it a PCI to Local
interrupt. On receiving the interrupt the On board DSP processes data and
sends the interrupt back to the Host via the Local-PCI interrupt which is
detected by our driver. All of this is working fine in systems with single
processor intel pentiums.

However when we tried to use the board and driver on a IBM Xseries 345
server, with dual motherboard architecture and a XEON processor, the driver
did not detect the Local-PCI interrupt. In the init_module of the driver
code we are using "request_irq" function to listen to interrupts from the
board. The driver was able to get the irq (3) for that board. We checked the
PCI configuration registered and confirmed that the board was assigned IRQ3.
We used an oscilloscope to check if our board was sending the interrupt on
the INT A line of the PCI bus and we found that it was .

When we used "Jungos" Windriver application for Linux it was able to detect
the interrupt. When we analysed the /proc/interrupts file we saw that the
even though our board was given the irq 3, the jungo driver was operating on
irq 24.
Another difference between our driver and jungo was that our driver was
associated with a "XT-PIC" interrupt controller while the Jungo driver was
associated with a "APIC-Level triggered" interrupt controller. We checked
the /proc/interrupts file on other systems and found that our driver was
associated with "XT-PIC" interrupt controller

Is there any way we can make our driver choose the type of interrupt
controller with which to associate itself when requesting an IRQ
Is there a different way of requesting an IRQ on XEON based processors and
handling interrupts on these IRQs.
why was jungo driver showing irq 24 in /proc/interrupts file and not our
driver
Is there a different way of handling interrupts for 64 bit processors

This problem has really bogged us down and we'd be grateful for any help or
suggestion

Regards
Muhammad Mutahir Latif,
And Or Logic (Pvt.) Ltd.,

H# 220, St# 33, F-10/1,
Islamabad, Pakistan.
Phone: +92-51-2212976 -Ext 202
Cell:  +92-300-5216570
Email: mutahir@and-or.com, mutahirlatif@yahoo.com

