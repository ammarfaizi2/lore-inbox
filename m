Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRCWLsA>; Fri, 23 Mar 2001 06:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRCWLru>; Fri, 23 Mar 2001 06:47:50 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130618AbRCWLrd>;
	Fri, 23 Mar 2001 06:47:33 -0500
Message-ID: <20010323002516.B126@bug.ucw.cz>
Date: Fri, 23 Mar 2001 00:25:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Geir Thomassen <geirt@powertech.no>, linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
Subject: Re: Serial port latency
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no>; from Geir Thomassen on Thu, Mar 22, 2001 at 07:21:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My program controls a device (a programmer for microcontrollers) via the
> serial port. The program sits in a tight loop, writing a few (typical 6)
> bytes to the port, and waits for a few (typ. two) bytes to be returned from
> the programmer. 
> 
> The program works, but it is very slow. I use an oscilloscope to monitor the
> serial lines, and notices that there is a large delay between the returned
> data, and the next new command. I really don't know if the delay is on the
> sending or the receiving side (or both).
> 
> This is what the program does:
> 
>      fd=open("/dev/ttyS0",O_NOCTTY | O_RDWR);
> 
>      tcsetattr(fd,TCSANOW, &tio); /* setting baud, parity, raw mode, etc */
> 
>      while() {
>              write( 6 bytes);   /* send command */
>              read( 2 bytes);    /* wait for reply */
>      }
> 
> 
> The device on the serial port responds in typ. 10 ms, but the software uses
> over 500ms to get the reply and send the next command. Why is this happening ?
> I have a feeling that there is something obvious I am missing (like line
> buffering, but that's a stdio (libc) thing, isn't it ?).

Set HZ=1000 in include/asm/params.h and see if it helps.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
