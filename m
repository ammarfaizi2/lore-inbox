Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316014AbSEJPFB>; Fri, 10 May 2002 11:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316015AbSEJPFB>; Fri, 10 May 2002 11:05:01 -0400
Received: from [168.159.40.71] ([168.159.40.71]:35083 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S316014AbSEJPFA>; Fri, 10 May 2002 11:05:00 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A43@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Steve Whitehouse'" <Steve@ChyGwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Fri, 10 May 2002 11:02:05 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When the system stucks, I could not get any response from the console or
terminal.
But basically the only network connections on both machine are the nbd
connection
and a couple of telnet sessions. That is what shows on "netstat -t".

/proc/sys/net/ipv4/tcp_[rw]mem are "4096  262144 4096000",
/proc/sys/net/core/*mem_default are 4096000, 
/proc/sys/net/core/*mem_max   are 8192000,
I did not change /proc/sys/net/ipv4/tcp_mem.

The nbd_client get stuck in sock_recvmsg, and one other process stucks
in do_nbd_request (sock_sendmsg). I will try to use kdb to give you
more foot print.

The system was low in memory, I started up 20 to 40 thread to do block
write simultaneously.

The nbd device was not used as swap device.

Thanks,

Xiangping

-----Original Message-----
From: Steven Whitehouse [mailto:steve@gw.chygwyn.com]
Sent: Tuesday, May 07, 2002 4:16 AM
To: chen, xiangping
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


Hi,

I suggest trying 2.4.19-pre8 first. This has the fix for the deadlock that
I'm
aware of in it. If that still doesn't work, then try and send me as much
information as the system will let you extract. What I'm most interested
in is:

 o State of the sockets (netstat -t on both client and server)
 o Values of /proc/sys/net/ipv4/tcp_[rw]mem and tcp_mem
 o Does the nbd client get stuck in the D state before or after any other
   processes doing I/O through nbd? This is useful as it tells me whether
   the problem is on a transmit or receive.
 o Was your system low on memory at the time ?
 o Were you trying to use nbd as a swap device ?

Steve.
 
> 
> Hi,
> 
> I am using 2.4.16 with xfs patch from SGI. It may not be the acenic
> driver problem, I can reproduce the deadlock in a 100 base-T network
> using eepro100 driver. Closing the server did not release the deadlock.
> What else can I try?
> 
> 
[original messages cut here]
