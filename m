Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132124AbRCVSYh>; Thu, 22 Mar 2001 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132139AbRCVSYV>; Thu, 22 Mar 2001 13:24:21 -0500
Received: from netel-gw.online.no ([193.215.46.129]:47372 "EHLO
	InterJet.networkgroup.no") by vger.kernel.org with ESMTP
	id <S132140AbRCVSXo>; Thu, 22 Mar 2001 13:23:44 -0500
Message-ID: <3ABA42A8.A806D0E7@powertech.no>
Date: Thu, 22 Mar 2001 19:21:28 +0100
From: Geir Thomassen <geirt@powertech.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tytso@mit.edu
Subject: Serial port latency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. 

My program controls a device (a programmer for microcontrollers) via the
serial port. The program sits in a tight loop, writing a few (typical 6)
bytes to the port, and waits for a few (typ. two) bytes to be returned from
the programmer. 

The program works, but it is very slow. I use an oscilloscope to monitor the
serial lines, and notices that there is a large delay between the returned
data, and the next new command. I really don't know if the delay is on the
sending or the receiving side (or both).

This is what the program does:

     fd=open("/dev/ttyS0",O_NOCTTY | O_RDWR);

     tcsetattr(fd,TCSANOW, &tio); /* setting baud, parity, raw mode, etc */

     while() {
             write( 6 bytes);   /* send command */
             read( 2 bytes);    /* wait for reply */
     }


The device on the serial port responds in typ. 10 ms, but the software uses
over 500ms to get the reply and send the next command. Why is this happening ?
I have a feeling that there is something obvious I am missing (like line
buffering, but that's a stdio (libc) thing, isn't it ?).

BTW, I am running a 2.2 kernel ....

Geir, geirt@powertech.no
