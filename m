Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUCWKIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUCWKIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:08:43 -0500
Received: from rootsrv.net ([217.160.131.12]:22681 "HELO rootsrv.net")
	by vger.kernel.org with SMTP id S262427AbUCWKIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:08:41 -0500
Message-ID: <40600CDD.5050807@pop2wap.net>
Date: Tue, 23 Mar 2004 11:09:33 +0100
From: Christof <mail@pop2wap.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: synchronous serial port communication (16550A)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a possible problem with the 8250 serial port driver in linux (2.6.2).
I communicate with a graphic controller with LCD-Display via ttyS0. This
controller has a small buffer: 20 bytes. When the buffer is full it
asserts the CTS line. When it can receive data again, the CTS line is
cleared.
My software checks the CTS line each time before sending a byte. If it
is asserted, it waits until its cleared and goes on. When data is sent
although CTS is asserted, the graphic controller will be confused and
garbage will appear on the LCD screen.

To make the story short: I see a lot of garbage on the LCD.
It looks like output would be buffered and all data would be sent at
once without giving me the possibility to check if everything's
allright. Sometimes I can send >400 Bytes and ioctl says that CTS is not
asserted, altough it certainly is. What I need is totally synchronous
I/O. I want all bytes to be sent physically before I check for CTS, but
I can't find a possibility to actually achieve this. I tried to hack the
driver not to use the FIFO (My Linux box has a 16550A UART) and to set
the size of the circ buffer to 1, but nothing helped.
I compiled my software for cygwin for my Windows-machine and it worked,
the only thing is that I don't know what UART is build in, but i suppose
that it also has a FIFO since it is a quite new machine. (The FIFO is
also enabled in windows too).

Do you have any idea what I could do?

Thanks in advance and sorry for the messy english =)

Regards,
  Christof Krueger


