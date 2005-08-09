Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVHIJfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVHIJfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVHIJfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:35:19 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:65493 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932487AbVHIJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:35:18 -0400
Message-ID: <42F878D3.80302@bakke.com>
Date: Tue, 09 Aug 2005 11:35:15 +0200
From: Dag Bakke <dag@bakke.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Enabling PCMCIA serial ports without pcmciautils/pcmcia_cs in
 2.6?
References: <42F8715C.4000404@bakke.com> <20050809101842.B4026@flint.arm.linux.org.uk>
In-Reply-To: <20050809101842.B4026@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Tue, Aug 09, 2005 at 11:03:24AM +0200, Dag Bakke wrote:
>  
>
>>Is this really necessary? I'd guess that serial cards are some of the 
>>simpler pcmcia targets to enable? (I could be very wrong..)
>>Anyone got an idea about alternative solutions, or can state the minimum 
>>binaries/files I need to enable this card? (Advantech COMpad-32/85B-4)
>>    
>>
>
>Have you tried just running up a really recent kernel (eg, 2.6.13-rc6)
>with PCMCIA and serial (including PCMCIA serial support) built in,
>plugging the card in, and seeing what happens?
>
>  
>
Yes. I get no message in dmesg indicating that the ports are detected.
Testing on a laptop (not the actual target):

toolbox-2 ~ # uname -a
Linux toolbox-2 2.6.13-rc6 #2 Mon Aug 8 16:05:25 CEST 2005 i686 Pentium 
III (Coppermine) GenuineIntel GNU/Linux

toolbox-2 ~ # zcat /proc/config.gz | egrep -i 'serial|pcmcia|yenta' | 
grep -v ^#
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_YENTA=y
CONFIG_PCMCIA_PROBE=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=y
CONFIG_SERIAL_8250_NR_UARTS=8
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_FOURPORT=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y


toolbox-2 ~ # /etc/init.d/pcmcia start
 * PCMCIA support detected.
 * Starting pcmcia ...
cardmgr[7718]: watching 2 
sockets                                                                                     
[ ok ]
toolbox-2 ~ # dmesg | tail
[ 6992.630199] cs: IO port probe 0x800-0x8ff: clean.
[ 6992.630671] cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
[ 6992.631927] cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
[ 6992.633248] cs: IO port probe 0xa00-0xaff: clean.
[ 6992.633656] cs: IO port probe 0xa00-0xaff: clean.
[ 6992.638071] cs: memory probe 0xa0000000-0xa0ffffff: clean.
[ 6992.692737] ttyS1 at I/O 0x240 (irq = 5) is a 16550A
[ 6992.695578] ttyS2 at I/O 0x248 (irq = 5) is a 16550A
[ 6992.698237] ttyS3 at I/O 0x250 (irq = 5) is a 16550A
[ 6992.700924] ttyS4 at I/O 0x258 (irq = 5) is a 16550A


