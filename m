Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSJPMwJ>; Wed, 16 Oct 2002 08:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbSJPMwJ>; Wed, 16 Oct 2002 08:52:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53120 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261177AbSJPMwI>; Wed, 16 Oct 2002 08:52:08 -0400
Date: Wed, 16 Oct 2002 08:59:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Vadim Lebedev <vadim@7chips.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fast data acquisition
In-Reply-To: <030701c274b5$ad424820$0200000a@LAP>
Message-ID: <Pine.LNX.3.95.1021016083034.3145A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Vadim Lebedev wrote:

> Hello,
> 
> I'm designing a solution for high speed data acquisition. The solution will
> be based on a Pentium class processor running Linux 2.4.x
> The data will be acquired over ISA bus using DMA at the rate of 52Mbit per
> second and then sent over TCP/IP on Ethernet 100MB connecttion to host
> computer.
> 

You are not serious. the ISA bus cannot transfer data at this rate. You
need to use the PCI bus. The ISA bus transfers data at about 1.5 megabytes
per second. The GP bus (ISA without any slots, using a bridge), transfers
data at up to 3.0 megabytes per second. You can purchase standard PCI
interface chips for a dollar or so. You don't need to design your own.
You also need a serial EEPROM to load its required info upon power-up.
This is all standard, inexpensive stuff.

Search 'PCI bus interface' on your Web-Crawler.
http://www.interfacebus.com/Design_Connector_PCI.html documents some
'cores' and interface chips.

> 
> I wonder how to design a driver for the data acquistion bord that will
> minimize data copying.
> I have 2 ideas:
> 

Data gets copied very quickly on 400 MHz or greater Pentium-Class
machines (about 1,500 megabytes per second). This should not be your
concern.

> 1) the application will open the driver and use a sendfile(devicefd,
> socketfd, ....) call

This works if you correctly implement read() in your driver.

> 2) To have the driver DMA data into the kernel buffer and then calling
> sock_sendpage directly from the driver.
> 
> 

If the hardware can do Bus Mastering, by all means use it. You need
to use a TCP/IP "connection" to guarantee that the receiver gets your
data. Using a piece of kernel code may send a packet, but there's
a lot more to networking than that. 

> 
> Do i need to implement some special functionality in the driver to realize
> 1) or a sendfile will work with an fd to any character device as source?
>

If the driver properly impliments read(). It should work with sendfile.
 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

