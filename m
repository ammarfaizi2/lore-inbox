Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWAJNVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWAJNVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWAJNVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:21:23 -0500
Received: from sf1.taajama.com ([212.86.0.100]:16891 "EHLO sf1.taajama.com")
	by vger.kernel.org with ESMTP id S932210AbWAJNVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:21:23 -0500
Message-ID: <43C3B4A7.1000501@usr.fi>
Date: Tue, 10 Jan 2006 15:20:39 +0200
From: Miika Keskinen <weeti@usr.fi>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: serial port, custom divisor
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I read from the Documentation/serial/driver that the custom divisor is
only applied to ports that have baud 38400. I'm asking if there is some
reason why custom divisor should not be used for other speeds too? I do
have a MIPS-SoC that does have 16550A-type uart but it needs custom
divisor, no matter what the speed is. The custom divisor is calculated
as follows:

baud = speed of port
system_frequency is in MHz

cdiv = (system_frequency * 5000) / baud;
if ((cdiv % 16)>7) cdiv += 8;
cdiv /= 16;

What I'm doing is to use early_serial_setup with flags containing
ASYNC_SPD_CUST and cdiv as .custom_divisor. However the serial_core
doesn't apply that divisor unless the speed is 38400 (and for example I
mostly need to run it in 9600). I'm now asking if I've misunderstood
something or does the removal of baud==38400 from serial_core cause
problems with other architectures?

btw. I'm not subscribed to the list so please cc me if replying.

yours,
Miika

-- 
All bugs added by me :)

