Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992590AbWJTIU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992590AbWJTIU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992591AbWJTIU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:20:27 -0400
Received: from smtpd1.aruba.it ([62.149.128.206]:37326 "HELO smtp4.aruba.it")
	by vger.kernel.org with SMTP id S2992590AbWJTIU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:20:26 -0400
Message-ID: <453886C7.1010309@koansoftware.com>
Date: Fri, 20 Oct 2006 10:20:23 +0200
From: Marco Cavallini <wx1@koansoftware.com>
Reply-To: wx1@koansoftware.com
Organization: Koan sas - Bergamo - ITALIA
User-Agent: Mozilla Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with 8250 suspend/resume
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtp4.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am testing suspend/resume using ttyS ports,
but I am facing to problems with 8250 based ports.
Linux kernel is 2.6.17-rc4 (but I've noticed no changes in 2.6.18)

Serial ports are 16C2852 but are identified as XR16850.

If I send the board to sleep and I try to wake it with chars from ttyS3 
( or ttyS*) the system go in suspend mode ans NEVER wakes up using 
serial ports:
# cat /dev/ttyS3 &
# echo standby > /sys/power/state

I tried also putting a function  enable_irq_wake(port->irq)
at the end of uart_suspend_port() [file drivers/serial/serial_core.c]
and in that case when I do the suspend command
# echo standby > /sys/power/state
immediately wakes up with no events and no interrupts rised from UART 
chip, with no cable connected to any port except console ttyAT0

I have been working on this problem for almost a week without success,
using printk and trying to understand what is going wrong.

If anybody has been experienced with 8250 suspend/resume problems or 
knows if there is something bad into the driver, I 'd like a hint to 
understand what to do.

Any hint will be greatly appreciated
Thanks
-- 
Marco Cavallini
Koan s.a.s. - Bergamo - ITALIA
Embedded and Real-Time Software Engineering
  - Atmel Third Party Consultant
Tel. +39-(0)35-255.235 - Fax +39-178-223.9748
www.KoanSoftware.com   |    www.KaeilOS.com
