Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbTLHBsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 20:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbTLHBsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 20:48:15 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:25351 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265273AbTLHBsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 20:48:12 -0500
Message-ID: <3FD3DCA6.6000109@nishanet.com>
Date: Sun, 07 Dec 2003 21:06:30 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: pcmcia yenta no devices Re: APM Suspend Problem
References: <3FC7F031.5060502@rogers.com> <3FC7F2E3.8080109@rogers.com> <20031129082200.A30476@flint.arm.linux.org.uk> <3FC88277.4090304@rogers.com> <20031201210739.C13621@flint.arm.linux.org.uk> <3FD24E34.3050300@rogers.com> <20031207170638.B20112@flint.arm.linux.org.uk>
In-Reply-To: <20031207170638.B20112@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If cbdump could help me figure out why I
don't have any pcmcia cardbus devices showing
up when I boot or insert or remove storage cards
and a Hawking 10/100 32-bit cardbus ethernet
pcmcia ethernet card, what is a command line
that will gcc -o cbdump cbdump.c ?

linux 2.6.0-test11   pcmcia-cs 3.2.5

-Bob

Russell King wrote:

>On Sat, Dec 06, 2003 at 09:46:28PM +0000, pZa1x wrote:
>  
>
>>Please let me know if there's anything I can do to help.
>>
>>Russell King wrote:
>>    
>>
>>>On Sat, Nov 29, 2003 at 11:26:47AM +0000, pZa1x wrote:
>>>
>>>      
>>>
>>>>(a) with yenta kernel 2.6
>>>>(b) without yenta kernel 2.6
>>>>        
>>>>
>>>Ok, so there aren't any differences between the PCI config space with
>>>the module loaded and unloaded.  I guess we need to start looking at
>>>the devices memory space registers for differences.............
>>>
>>>      
>>>
>
>Ok, if all goes well, you should be able to use the following program:
>
>  http://pcmcia.arm.linux.org.uk/progs/cbdump.c
>
>to dump out many of the cardbus controllers registers.  The idea is the
>same with lspci - you need to dump out the registers...........
>
>Thanks.
>
>  
>
Elan 1420 chip 32-bit cardbus pcmcia chip related to TI4210

cardmgr and utils of pcmcia-cs 3.2.5

yenta in kernel-2.6.0-test11  but no pcmcia ethernet card drivers
in kernel since I don't know which eth chip is on a Hawking pcmcia
PN672TX 32-bit cardbus 10/100 ethernet card.

boot with compact flash Kingston or Sandisk storage card in
pcmcia adapter and Hawking ethernet pcmcia card in second
pcmcia cardbus slot, nothing, try remove and insert, still
nothing, no pcmcia events or devices reported

Dec  4 02:32:43 where kernel: Linux Kernel Card Services
Dec  4 02:32:43 where kernel:   options:  [pci] [cardbus] [pm]
Dec  4 02:32:43 where kernel: Yenta: CardBus bridge found at 
0000:01:0a.0 [414e:454c]
Dec  4 02:32:43 where kernel: Yenta: ISA IRQ list 0000, PCI irq16
Dec  4 02:32:43 where kernel: Socket status: 30000006
Dec  4 02:32:43 where kernel: Yenta: CardBus bridge found at 
0000:01:0a.1 [414e:454c]
Dec  4 02:32:43 where kernel: Yenta: ISA IRQ list 0000, PCI irq16
Dec  4 02:32:43 where kernel: Socket status: 30000006
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0800-0x08ff: clean.
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x290-0x297 0x3c0-0x3df 0x4d0-0x4d7
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0a00-0x0aff: clean.

root       374  0.0  0.0 ?    [pccardd]
root       380  0.0  0.0 ?    [pccardd]
root       388  0.0  0.0 ?    /sbin/cardmgr
bob      25484  0.0  0.0 pts/0grep card

bob@where cat /var/lib/pcmcia/stab
Socket 0: empty
Socket 1: empty

bob@where $(locate gr/pcic_probe | grep "probe$") -v
PCI bridge probe: ENE 1420 found, 2 sockets.

bob@where $(locate gr/pcic_probe | grep "probe$") -v -m
i82365   [means pcmcia-cs would use i82365 mod but knows to
   let yenta be the driver]

