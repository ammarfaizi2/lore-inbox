Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVCAXJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVCAXJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCAXJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:09:54 -0500
Received: from hell.org.pl ([62.233.239.4]:34314 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262109AbVCAXJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:09:44 -0500
Date: Wed, 2 Mar 2005 00:09:46 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: kernel BUG at drivers/serial/8250.c:1256!
Message-ID: <20050301230946.GA30841@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've finally got around to test latest kernels and managed to find a bug in 
the serial subsystem, which happens during suspend.

I use a 3Com PC Card Bluetooth adapter that needs serial_cs and hci_uart
modules. Whenever I try to suspend using 2.6.10 or a newer kernel, the
following bug appears. Note that 2.6.9 works perfectly.

#v+ handwritten, 2.6.11-rc5
kernel BUG at drivers/serial/8250.c:1256!
invalid operand: 0000 [#1]
PREEMPT
[...]
EIP is at serial_unlink_irq_chain+0x4b/0x60 [8250]
[...]
Call Trace:
uart_suspend_port [serial_core]
serial_suspend [serial_cs]
serial_event [serial_cs]
send_event_callback [pcmcia]
__bus_for_each_dev
bus_for_each_dev
send_event_callback [pcmcia]
send_event [pcmcia]
send_event_callback [pcmcia]
handle_event [pcmcia]
ds_event [pcmcia]
send_event [pcmcia_core]
socket_suspend [pcmcia_core]
#v-

Photos are available here (sorry for the quality):
http://hell.org.pl/~sziwan/bug_8250-1.jpg
http://hell.org.pl/~sziwan/bug_8250-2.jpg
http://hell.org.pl/~sziwan/bug_8250-3.jpg

I'll be happy to provide whatever information is needed.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
