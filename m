Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWFOFN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWFOFN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWFOFN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:13:58 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:34526 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750838AbWFOFN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:13:57 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306A5FB51@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Thu, 15 Jun 2006 13:13:52 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:
> > 
> > > This patch contains changes to the serial device driver 
> specific for 
> > > integrated serial port in Tsi108 Host Bridge.
> 
> There's no explaination about why this is required.  What is 
> the problem?
> Which changes relate directly to this problem and which 
> changes are related to fixing some other issue not related to 
> the errata?
> 

More detailed explanation:

This patch addresses two differences in the Tsi108/109 UART behavior from the standard one.

1. Check for UART_IER_UUE bit in the autoconfig routine. This section of autoconfig is excluded for 
Tsi108/109 because bits 7 and 6 are reserved for internal use. They are R/W bits. In addition to incorrect
 identification, changing these bits (from 00) will make Tsi108/109 UART non-functional.  

2. ERRATA. Reading the UART's Interrupt Identification Register (IIR) clears the Transmit 
Holding Register Empty (THRE) and Transmit buffer Empty (TEMP) interrupts even 
if they are not enabled in the Interrupt Enable Register (IER). This leads to loss of the interrupts. 
Interrupts are not cleared when reading UART registers as 32-bit word.
