Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266280AbSIRMDU>; Wed, 18 Sep 2002 08:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266345AbSIRMDU>; Wed, 18 Sep 2002 08:03:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51840 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266280AbSIRMDT> convert rfc822-to-8bit; Wed, 18 Sep 2002 08:03:19 -0400
Date: Wed, 18 Sep 2002 08:06:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
cc: Steve Mickeler <steve@neptune.ca>, linux-kernel@vger.kernel.org
Subject: Re: Virtual to physical address mapping
In-Reply-To: <1032336427.5812.25.camel@zole.jblinux.net>
Message-ID: <Pine.LNX.3.95.1020918075900.3583A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Sep 2002, Ole [ISO-8859-1] André Vadla [ISO-8859-1] Ravnås wrote:

> Thanks, but the address specified there is certainly not the same as the
> base address ifconfig reports. I made a simple program to verify this:

[SNIPPED...]

`ifconfig` reports the base address of a port (I don't know why).
There are other addresses in use.

eth0      Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.100.2.224  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2630005 errors:0 dropped:0 overruns:0 frame:0
          TX packets:307396 errors:0 dropped:0 overruns:0 carrier:0
          collisions:2430 txqueuelen:100 
          Interrupt:10 Base address:0xb800 

[SNIPPED...]

A private version of `lspci` that actually reads the PCI ports
shows:

Device      Vendor                    Type
   0   Intel Corporation              440BX/ZX - 82443BX/ZX Host bridge
[SNIPPED...]
  11   3Com Corporation               3c905B 100BaseTX [Cyclone]         
       IRQ 10 Pin A
       I/O  ports : 0xb800->0xb87e
       I/O memory : 0xdf800000->0xdf80007f

Notice that it has memory-mapped I/O.
That said, neither of these addresses are the virtual addresses.
On an ix86, these are physical addresses which are the same as
the bus addresses. Other machines may not have the same physical
and bus address. The virtual address is whatever mmap() returns
in user-space, and whatever ioremap() returns in kernel space.
Note that in kernel space, the returned value should not be used
as a pointer. There are macros defined to access the I/O addressed
elements. See .../linux/Documentation/IO-mapping.txt.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

