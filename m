Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbTCGXIH>; Fri, 7 Mar 2003 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbTCGXIH>; Fri, 7 Mar 2003 18:08:07 -0500
Received: from s383.jpl.nasa.gov ([137.78.170.215]:46473 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S261856AbTCGXHV>; Fri, 7 Mar 2003 18:07:21 -0500
Message-ID: <3E69289F.5070801@jpl.nasa.gov>
Date: Fri, 07 Mar 2003 15:17:51 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: Ed Vance <EdV@macrolink.com>
Cc: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
References: <11E89240C407D311958800A0C9ACF7D1A33DD3@EXCHANGE>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What serial driver initialization messages do you get from dmesg?
> Is the "MANY_PORTS" flag present in the list of enabled options?
> Which distribution and rev level are you using?

My boot messages say this:
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A

It only sets up my built-into-motherboard serial ports. The add on card 
gets ignored.

I would have thought with SERIAL_PCI enabled I would have no problem. 
But it doesn't seem to be so.

doing the quick/dirty setserial stuff with my own mknod's work. but it's 
a big "messy". I'd at least like to get this fixed so next kernel 
version I don't need to do a quick hack todo something as simple as 
getting a serial port working.

I can post my entire dmesg if needed allong with my complete /proc/pci. 
I'm also willing to play with patches. (if this is already fixed in a 
later kernel than 2.4.19 I'd be willing to give it a go).



> Ed
> 
> -----Original Message-----
> From: Bryan Whitehead [mailto:driver@jpl.nasa.gov]
> Sent: Friday, March 07, 2003 2:55 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-newbie@vger.kernel.org
> Subject: Re: devfs + PCI serial card = no extra serial ports
> 
> 
> 
> BTW, this is with 2.4.19 (kernel shipped with distro).... I'm willing to 
> test any patches / rebuild kernel to get this working.....
> 
> 
> Bryan Whitehead wrote:
> 
>>It seems devfsd has an annoying "feature". I bought a PCI card to get a 
>>couple (2) more serial ports. The kernel doesn't seem to set up the 
>>serial ports at boot, so devfs never creates an entry. However, post 
>>boot, since there is no entries, I cannot configure the serial ports 
>>with setserial. So basically devfsd = no PCI based serial add on?
>>
>>03:05.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) 
>>(rev 01) (prog-if 02 [16550])
>>    Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 
>>0002
>>    Flags: medium devsel, IRQ 17
>>    I/O ports at ecf8 [size=8]
>>    I/O ports at ece8 [size=8]
>>    I/O ports at ecd8 [size=8]
>>    I/O ports at ecc8 [size=8]
>>    I/O ports at ecb8 [size=8]
>>    I/O ports at eca0 [size=16]
>>
>>
>>mknod ttyS2 c 4 66
>>mknod ttyS3 c 4 67
>>setserial ttyS2 port 0xecf8 UART 16550A irq 17 Baud_base 9600
>>setserial ttyS3 port 0xece8 UART 16550A irq 17 Baud_base 9600
>>
>>I hoped after "setting up" the serial ports with setserial some magic 
>>would happen and they would apear in /dev/tts... but I was wrong.
>>
>>gets me working serial ports... but it's not in /dev... :O
>>
>>Am I just screwed?
>>
>>If so, what would be a good add on PCI based solution for more serial 
>>ports that WORKS with devfsd? (I don't want to disable devfs as this 
>>opens up a different set of problems)
>>
>>Thanks for any replay!
>>
> 
> 
> 


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

