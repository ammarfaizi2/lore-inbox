Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbUK3UqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbUK3UqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbUK3UqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:46:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39842 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262301AbUK3UqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:46:15 -0500
Date: Tue, 30 Nov 2004 21:46:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os@analogic.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Walking all the physical memory in an x86 system
In-Reply-To: <Pine.LNX.4.61.0411301519130.4393@chaos.analogic.com>
Message-ID: <Pine.LNX.4.53.0411302141080.31175@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406> 
 <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr>  <41ACADD3.2030206@draigBrady.com>
  <Pine.LNX.4.53.0411301832510.11795@yvahk01.tjqt.qr>
 <1101840619.25609.107.camel@localhost.localdomain>
 <Pine.LNX.4.61.0411301519130.4393@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> 	unsigned short p;
>>> 	fd = open("/dev/mem", O_RDONLY | O_BINARY);
>>> 	lseek(fd, 0x400, SEEK_SET);
>>> 	read(fd, &p, 2);
>>
>> You want ports for that not mem, has always been the case since back
>> before Linux existed.

I want(ed) to find out which I/O port to use for inb() and stuff, and using the
BIOS's provided data. If you are referring to "ports", I could not find a
device node, but "port" maybe:

$ tailhex /dev/port
[...]
0x00000400 | ffff ffff ffff ffff ffff ffff ffff ffff |
[...]

Oh, look what /dev/mem found! (I retried haha)

$ tailhex /dev/mem
...
0x00000400 | f803 0000 0000 0000 7803 0000 0000 c09f |
...

0x3F8 and 0x378... we know those ones :)
BTW: What the BIOS does not seem to recognize is that PCI card that provides
more LPT ports (LPT2 and LPT3) (I literally fried the LPT1)

So, /dev/mem points to "physical" mem in a sense like DOS has. (Where, the
BIOS, is blend into, as you can see)

>At offset 0 in the BIOS segment of 0x40, real address 0x400, are
>the addresses of up to 4 ports for the serial communications
>devices, followed by up to 4 port addresses of any parallel
>communications devices found by the BIOS upon startup. This
>is likely what he meant. The code shown will return the address
>of the first RS-232 device (usually a 8250 UART) found.

Yes, (parallel / serial, I don't care, it's just something to show), or
in DOS-style:
	*(unsigned short far *)0x400


Jan Engelhardt
-- 
ENOSPC
