Return-Path: <linux-kernel-owner+w=401wt.eu-S1751258AbXAUHJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbXAUHJF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 02:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbXAUHJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 02:09:04 -0500
Received: from terminus.zytor.com ([192.83.249.54]:43662 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbXAUHJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 02:09:03 -0500
Message-ID: <45B31174.9060804@zytor.com>
Date: Sat, 20 Jan 2007 23:08:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Joe Barr <joe@pjprimer.com>
CC: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
References: <1169242654.20402.154.camel@warthawg-desktop>
In-Reply-To: <1169242654.20402.154.camel@warthawg-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Barr wrote:
> I'm forwarding this post by the author of a great little program for
> digital amateur radio on Linux, because I'm curious whether or not the
> problem he is seeing can be resolved outside the kernel.
> 
> All comments welcome on/off list.
>
> Thanks,
> Joe Barr
> K1GPL

[...]

> 
> I've spent the last day staring at the oscilloscope and pins RTS and DTR 
> on the serial output for 4 different computers running 4 different 
> versions of Linux.  Also have exhausted the search on the internet for 
> information regarding both the latency and jitter associated with ioctl 
> calls to the serial driver (both ttyS and ttyUSB).  I'm sure it is out 
> there somewhere, I just cannot find it.
> 
> I am now convinced that the current serial port drivers available to us 
> on the Linux platform WILL NOT support CW and/or RTTY that is software 
> generated in a satisfactory manner.
> 
> To test the latency and jitter of the ioctl calls to set or clear RTS 
> and / or DTR I built a basic square wave generator with microsecond 
> timing precision.  The timing could be derived either from the select 
> system call or by controlled i/o to the sound card.  Both provide very 
> precise timing of the program loop.  Each time through the loop either 
> the RTS/DTR was set or cleared.  The timing jitter for each 1/2 cycle 
> was from 0 to +4 msec.  This varied between systems as each had 
> different cpu clock rates.  The jitter is caused by the asynchronous 
> response of the kernel to the request to control the port.  ioctl 
> requests apparantly do not have a very high priority for the kernel.  
> They are probably just serviced by a first-in first-out interrupt 
> service request loop.  That type of jitter is tolerable up to about 20 
> wpm CW.  It totally wipes out the ability to generate an FSK signal on 
> the DTR or RTS pin.

Okay, here he's using bit-banging of the DTR and RTS pins to generate a 
fairly high precision output wave.  These bits are being used as GPIOs, 
and would need very precise control.  This is much worse for USB serial 
ports than for ordinary serial ports.

> Direct access to the serial port(s) is a kernel perogative in Linux.  
> Only kernel level drivers are allowed such port access.

So write a kernel driver.  It's not like we're locking anybody out. 
There is certainly enough Amateur Radio/Linux crossover that a kernel 
enhancement to support Amateur Radio is going to get frowned upon.

> So ... bottom line is that all of my attempts over the past couple of 
> months to provide CW and / or FSK output signal have been to fraught 
> with pitfalls.  The CW seems OK for slow speed keying, but the FSK seems 
> impossible to achieve.
> 
> The FSK using the UART is also limited by the Linux operating system and 
> the current drivers.  That limitation excludes the use of 45 or 56 baud 
> BAUDOT.

That is true at the moment (due to unfortunate design choices made early 
on), but this is already in the process of being changed:

http://lkml.org/lkml/2006/10/18/280

> Until such time as new information becomes available I am going to 
> comment out all references to CW and / or FSK via RTS/DTR.  I also 
> question how useful the FSK on TxD (UART derived) might be to most users 
> since the 45.45 baudrate is not available in the serial port driver.  
> That function will also be commented out.
> 
> All this should not really come as a surprise since Linux is not a 
> real-time operating system. By the way, I did try the tests with the 
> test program running with nice -20.  Not much difference.

See again how he should be using real-time priority rather than nice -20.

> Sorry folks, but we win some and lose some.
> 
> 73, Dave, W1HKJ

	-hpa

