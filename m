Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWEEJjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWEEJjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 05:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWEEJjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 05:39:47 -0400
Received: from bay105-f14.bay105.hotmail.com ([65.54.224.24]:24575 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030346AbWEEJjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 05:39:47 -0400
Message-ID: <BAY105-F14065377CA78E7380B26DCE9B50@phx.gbl>
X-Originating-IP: [208.48.46.1]
X-Originating-Email: [rwm_rietveld@hotmail.com]
In-Reply-To: <445B165D.3000508@draigBrady.com>
From: "Roy Rietveld" <rwm_rietveld@hotmail.com>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
Date: Fri, 05 May 2006 09:39:45 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 05 May 2006 09:39:46.0691 (UTC) FILETIME=[D89E0D30:01C67027]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the platform is a netsilicon NS9360 witch include an 100MBit ethernet 
device.
The driver came with the software(LxNETES) for the development board.
CPU load is 100% when running sender program.

cat /proc/interrupts; sleep 10; cat /proc/interrupts doen't work anymore 
because cpu is to busy.

Does sendto give other processes time when the hardware is transmitting 
data?
Is this bad hardware or is the cost of sendto that high.



>From: Pádraig Brady <P@draigBrady.com>
>To: Roy Rietveld <rwm_rietveld@hotmail.com>
>Subject: Re: TCP/IP send, sendfile, RAW
>Date: Fri, 05 May 2006 10:09:49 +0100
>
>Roy Rietveld wrote:
>
> > Can somebody help me with this.
> >
> > I'am new to Linux normaly i do programming for RTOS.
> >
> > I would like to send ethernet packets with 1400 bytes payload.
> > I wrote a small program witch sends a buffer of 1400 bytes in a
> > endless loop.
> > The problem is that a would like 100Mbits throughtput but when i check
> > this with ethereal.
> > I only get 40 MBits. I tried sending with an UDP socket and RAW
> > socket. I also tried sendfile.
> > The RAW socket gives the best result till now 50 MBits throughtput.
> >
> > Is there something faster then send or am i doing something wrong.
> >
> > I'm running kernel 2.6 on a ARM9 core at 177Mhz 32RAM 32Flash.
>
>Is this the platform for both sender and receiver?
>
>What you have to consider is processing required per packet.
>At 50Mb/s you are getting for following number of packets per second:
>
>$ echo "(50*10^6)/8/(12+8+14+20+8+1400+4)" | bc
>4263
>
>I'm guessing that the receiver or sender is running out of CPU at this 
>rate?
>Also maybe this number of interrupts/s may be an issue on this platform?
>You can check the interrupt rate easilty enough with:
>cat /proc/interrupts; sleep 10; cat /proc/interrupts
>
>Note by default ethereal (libpcap) will use 3 syscalls per packet
>to copy and timestamp each packet. Have a look at PACKET_MMAP
>to alleviate this.
>
>At the interrupt level you could use NAPI or interrupt coalescing etc.
>What driver are you using?
>
>Pádraig.
>


