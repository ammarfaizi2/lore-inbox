Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVLSQMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVLSQMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVLSQMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:12:08 -0500
Received: from panoramix.softnet.tuc.gr ([147.27.14.5]:6075 "HELO
	softnet.tuc.gr") by vger.kernel.org with SMTP id S964802AbVLSQMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:12:07 -0500
Subject: selfmade serial driver problem with chipset other than VIA
From: giorgos xatzipavlis <gxatzipavlis@softnet.tuc.gr>
Reply-To: gxatzipavlis@softnet.tuc.gr
To: linux-kernel@vger.kernel.org
In-Reply-To: <S964780AbVLSPVy/20051219152154Z+1140@vger.kernel.org>
References: <S964780AbVLSPVy/20051219152154Z+1140@vger.kernel.org>
Content-Type: text/plain
Organization: softnet.tuc.gr
Date: Mon, 19 Dec 2005 18:12:22 +0200
Message-Id: <1135008742.7345.8.camel@someone.somewhere.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello people

this is my first attempt to the linux serial mailling list so i
apologize for my mistakes...

i am a newbie in kernel development.

i have made a serial driver cause i want to communicate with a serial
device ( a microcontroller ). I have programmed the driver in my
computer and everything is working ok. I have an AMD 1000Hz, MSI
motherboard with VIA chipset and kernel 2.4.31. I have found
informations from Linux Deveice Drivers book. Everything is working ok
in my computer but  the driver isn't working in computers with INTEL and
NVIDIA chipsets. The fact that makes me suspicious about that
is that although my driver is registered in /proc/interrupts
and /proc/ioports (irq 4-ioport 0x03f8) when ever i call outb from my
writer bottomhalf routine the interrupt isn't generated from the
hardware(in machines with inter or nvidia chipset). 

the flow chart is somethink like that:

1)user space write      (getting the data from user)

2)kernel space write    (generating the package that i want to send)

3)writer_bottomhalf     (i have the package in writer_buffer indexed by a 
		         bytes_send variable. Call "outb(writer_buffer[bytes_send],MY_UART+UART_TX)" )

4)interrupt handler     (bytes_send++ ,so i can send the next character variable, 
		         call "tasklet_schedule(&writer_bottomhalf)" to go to step 3)

in computers with chipsets other than VIA the 4th step (interrupt handler) is
never executed.

any ideas?

thank

