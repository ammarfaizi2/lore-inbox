Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVEIK6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVEIK6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 06:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVEIK6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 06:58:38 -0400
Received: from general.keba.co.at ([193.154.24.243]:54743 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261216AbVEIK6g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 06:58:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Real-Time Preemption: Magic Sysrq p doesn't work
Date: Mon, 9 May 2005 12:58:34 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323203@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Real-Time Preemption: Magic Sysrq p doesn't work
Thread-Index: AcVUd/147/EWgvWnQiax74qDHXJcJwAC5w8w
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <dwalker@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While testing, I noticed that Sysrq p is silently ignored on current RT
kernels with RT preemption: The syslog contains a message that Sysrq p
was pressed, but no registers are printed. 

A vanilla 2.6.11 with the same config (except for the RT-specific
settings) on the same hardware (i386) gives correct Sysrq p output.

The keyboard is connected via USB.

I checked the code: The sysrq p function is passed a "struct pt_regs *"
arg, and only produces output if this pointer is non-NULL. For RT
kernels, it is always NULL (I added a printk).

This "struct pt_regs *" travels all the way from the actual keyboard
interrupt handler (it is passed as an arg to "usb_kbd_irq"), but I was
not able to trace it back any further in the source.

Is this a known problem?

Is there any workaround? (Sysrq p would be very helpful for debugging!)

Thanks in advance for any hints!

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
