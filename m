Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTJNMdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTJNMdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:33:10 -0400
Received: from mesa.unizar.es ([155.210.11.66]:21198 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S262444AbTJNMdB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:33:01 -0400
Date: Tue, 14 Oct 2003 14:32:51 +0200
Subject: Re: PCI64 bus vanished in 2.4.23-pre6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
To: "J.A. Magallon" <jamagallon@able.es>
From: "J.A. Magallon" <jamagallon@able.es>
In-Reply-To: <20031010220405.GA2099@werewolf.able.es>
Message-Id: <86A391D9-FE42-11D7-9A20-0003936CA474@able.es>
Content-Transfer-Encoding: 8BIT
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On sábado, octubre 11, 2003, at 12:04  AM, J.A. Magallon wrote:

>
> On 10.10, Marcelo Tosatti wrote:
>>
>>
>> On Tue, 7 Oct 2003, J.A. Magallon wrote:
>>
>>> Hi all...
>>>
>>> With 2.4.23-pre6, my e1000 cards did not work. I was thinking it was 
>>> a driver
>>> problem, but the I realized that they are not even listed in lspci.
>>>
>>> <moilanen:austin.ibm.com>:
>>>   o Workaround PPC64 PCI scan issue
>>
>> This has a high chance of being the problem.
>>
>> Attached patch for you to revert (-R) and retry is attached, please. 
>> :)
>>
>
> Thanks, I can't try it until monday (I need to be in front of the box 
> to
> see the node messages ;)).
>
> Will report about the results.

Still doesn't work. I have tried with several kernels and put the dmesg
and lspci logs here:

http://giga.cps.unizar.es/~magallon/linux/acpi/

Some things I have noticed (diff from -pre5 to -pre6):

-Booting processor 1/1 eip 2000
+Booting processor 1/1 eip 3000
...
-Setting 4 in the phys_id_present_map
-...changing IO-APIC physical APIC ID to 4 ... ok.
-Setting 5 in the phys_id_present_map
-...changing IO-APIC physical APIC ID to 5 ... ok.
  init IO_APIC IRQs
- IO-APIC (apicid-pin) 4-0, 4-10, 4-11, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 
5-6, 5-7, 5-8, 5-9, 5-11, 5-12, 5-13, 5-14 not connected.
+ IO-APIC (apicid-pin) 4-0, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 
5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
...
   NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
...
- 0a 000 00  1    0    0   0   0    0    0    00
- 0b 000 00  1    0    0   0   0    0    0    00
- 0c 003 03  0    0    0   0   0    1    1    79
- 0d 003 03  0    0    0   0   0    1    1    81
- 0e 003 03  0    0    0   0   0    1    1    89
- 0f 003 03  0    0    0   0   0    1    1    91
+ 0a 003 03  0    0    0   0   0    1    1    79
+ 0b 003 03  0    0    0   0   0    1    1    81
+ 0c 003 03  0    0    0   0   0    1    1    89
+ 0d 003 03  0    0    0   0   0    1    1    91
+ 0e 003 03  0    0    0   0   0    1    1    99
+ 0f 003 03  0    0    0   0   0    1    1    A1
...
-.... register #02: 01000000
-.......     : arbitration: 01
+.... register #02: 03000000
+.......     : arbitration: 03
...
  IRQ7 -> 0:7
  IRQ8 -> 0:8
  IRQ9 -> 0:9
+IRQ10 -> 0:10
+IRQ11 -> 0:11
  IRQ12 -> 0:12
  IRQ13 -> 0:13
  IRQ14 -> 0:14
  IRQ15 -> 0:15
-IRQ26 -> 1:10
-IRQ31 -> 1:15

-pre6 does not detect IRQ26-31 (second APIC?). And pre5 used them:

PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B0,I6,P0) -> 31
PCI->APIC IRQ transform: (B1,I2,P0) -> 26

Booting with pci=noacpi just hangs the booting process.

Any ideas ?

--
Juan Antonio Magallon Lacarta       \              Software is like sex:
mailto:magallon()unizar!es           \        It's better when it's free
34-976-762354 - Fax: 34-976-761914    \   -- Linus Torvalds, FSF T-shirt
Grupo de Informatica Grafica Avanzada: http://giga.cps.unizar.es

