Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311832AbSCNWVD>; Thu, 14 Mar 2002 17:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311833AbSCNWUz>; Thu, 14 Mar 2002 17:20:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20488 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311832AbSCNWUs>; Thu, 14 Mar 2002 17:20:48 -0500
Message-ID: <3C912227.3080806@zytor.com>
Date: Thu, 14 Mar 2002 14:20:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.3.95.1020314165931.715A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> 
> Yeh?  Then "how do it know?". It doesn't. I/O instructions are ordered,
> however, that's all. There is no bus-interface state machine that exists
> except on the addressed device. The CPU driven interface device just
> makes sure that the data is valid before the address and I/O-read or
> I/O-write are valid after this. The address is decoded by the device
> and is used to enable the device. It either puts its data onto the
> bus in the case of a read, or gets data off the bus, in the case of
> a write. The interface timing is specified and is handled by hardware.
> In the meantime the CPU has not waited because there is nothing to
> wait for. On a READ, if the device cannot put its data on the bus
> fast enough, it puts its finger io IO-chan-ready. This forces the
> CPU (through its bus-interface) to wait.
> 
> Writes to nowhere are just that, writes to nowhere.
> 


On the ISA bus, yes.  The PCI and front side busses will be held in wait 
until the transaction is completed.

The exact requirement is a bit more complicated, something along the 
lines of "an SMI triggered in response to an OUT will be taken before 
the OUT is retired."

	-hpa


