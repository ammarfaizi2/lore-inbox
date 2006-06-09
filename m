Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWFISB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWFISB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWFISB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:01:56 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:28649 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S1030336AbWFISBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:01:55 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: serial_core: verify_port() in wrong spot?
Date: Fri, 9 Jun 2006 13:59:13 -0400
Organization: Connect Tech Inc.
Message-ID: <093501c68bee$6aef1ad0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20060609162320.GA11997@flint.arm.linux.org.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King [rmk@arm.linux.org.uk]
> I'd rather verify_port didn't get used for that - it's purpose is to
> validate changes the admin makes to the port.

I did figure out that's what it's currently used as, but I didn't want
to introduce a whole new call just to verify that the UART has 9bit
capability.

Why aren't user changes validated?

> I don't know why you think that setting 9bit mode should be done this
> way rather than through the usual termios methods - the 
> termios methods
> already have a way to control the length of each character, 
> so it would
> seem logical to put the control in there.

9bit mode is much more than just words of 9 bit length. Parity is
gone, replaced by the 9th bit; reads and writes have to treat the
buffers driver-side buffers as 16 bit-wide instead of 8-bit; reads and
writes to the hardware are correspondingly different; there are new
interrupts; software flow control is gone; there's special address
matching and a new ioctl to set that up.

It seemed easier to create a new mode of operation based on the
UPF_9BIT flag; using the CS9 flag doesn't imply any of the above
except for 9 bit length.

However, I'm open to having my mind changed.

..Stu

