Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVAKTXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVAKTXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVAKTWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:22:45 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:63983 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S262872AbVAKTSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:18:54 -0500
Date: Tue, 11 Jan 2005 13:18:41 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, magnus.damm@gmail.com
Message-id: <41E42691.3060102@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 10 Jan 2005, DHollenbeck wrote:
>  
>
>>However, when I have a "CARDBUS to USB 2.0 Hi-Speed Adapter" installed 
>>at the time of modprobe yenta_socket, I get a problem, shown below. 
>>    
>>
>
>Can you compile the kernel with kallsyms info? That would make the output 
>a whole lot more readable.
>
>  
>
first, load the following two modules

modprobe ehci_hcd, then
modprobe yenta_socket

then a dmesg extract, now with kallsyms:

usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux Kernel Card Services
  options:  [pci] [cardbus]
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:0d.1
Yenta: CardBus bridge found at 0000:00:0d.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0d.0, mfunc 0x00001022, devctl 0x64
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:0d.1
PCI: Sharing IRQ 11 with 0000:00:0d.0
Yenta: CardBus bridge found at 0000:00:0d.1 [0000:0000]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0d.1, mfunc 0x00001022, devctl 0x64
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
Socket status: 30000020
irq 11: nobody cared (try booting with the "irqpoll" option.
 [<c012b752>] __report_bad_irq+0x22/0x90
 [<c012b868>] note_interrupt+0x78/0xc0
 [<c012b11d>] __do_IRQ+0x13d/0x160
 [<c0104aba>] do_IRQ+0x1a/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012007b>] sys_getresgid+0xb/0xa0
 [<c0117750>] __do_softirq+0x30/0xa0
 [<c0120060>] sys_setresgid+0x120/0x130
 [<c01177f5>] do_softirq+0x35/0x40
 [<c012af65>] irq_exit+0x35/0x40
 [<c0104abf>] do_IRQ+0x1f/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c01005b0>] default_idle+0x0/0x40
 [<c038007b>] ic_setup_if+0xcb/0xd0
 [<c01005d3>] default_idle+0x23/0x40
 [<c010064c>] cpu_idle+0x1c/0x50
 [<c036873c>] start_kernel+0x13c/0x160
handlers:
[<c2842930>] (yenta_interrupt+0x0/0x40 [yenta_socket])
[<c2842930>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #11
PCI: Enabling device 0000:05:00.3 (0000 -> 0002)
ehci_hcd 0000:05:00.3: ALi Corporation USB 2.0 Controller
ehci_hcd 0000:05:00.3: irq 11, pci mem 0x10c01000
ehci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:05:00.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected


root@EMBEDDED[~]# cat /proc/interrupts
           CPU0
  0:     263041          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:        163          XT-PIC  serial
  8:          0          XT-PIC  rtc
  9:        584          XT-PIC  eth0
 11:     100000          XT-PIC  yenta, yenta, ehci_hcd
 14:       8631          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
root@EMBEDDED[~]#

>>The same problem occurs if the Adapter is inserted after the yenta
>>module is loaded.  That is, load the yenta_socket module: no problem,
>>then physically insert the Adapter: same problem.
>>    
>>
>
>Can you test with another type of card, just to see if it is specific to 
>that particular driver, or it happens with any card insertion event?
>
>  
>

Yes, a PRISM54 PCMCIA (WL54G) card seems to work in the slot.  With it :

root@SHOEBOX[~]# cat /proc/interrupts
           CPU0
  0:    2890965          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:        925          XT-PIC  serial
  8:          0          XT-PIC  rtc
  9:       3715          XT-PIC  eth0
 10:          5          XT-PIC  eth1
 11:         92          XT-PIC  yenta, yenta, eth2
 12:          0          XT-PIC  ohci_hcd
 14:      11812          XT-PIC  ide0
NMI:          0
ERR:          0

IRQ 11 is showing 92 interrupts, vs. 100000 when the USB 2.0 Adapter 
card is in the slot instead of the Prism54 card.

Here is the USB Adapter card:

http://link-depot.com/pcb-u22.html

>>This same Adapter card works fine in a different pentium shoebox 
>>computer using the same kernel and root file system as the "problem 
>>embedded pentium" system, but with a different CARDBUS chipset.
>>    
>>
>
>It's entirely possible that they have different behaviours for screaming 
>interrupts and/or just different setup.
>
>  
>
>>irq 11: nobody cared (try booting with the "irqpoll" option.
>> [<c0127362>]
>>....
>>handlers:
>>[<c2837930>]
>>[<c2837930>]
>>    
>>
>
>I can't tell what your handlers are, but there are two of them, and they 
>are the same, which makes me strongly suspect that it's just the two 
>"yenta_socket" handlers for the two slots (sharing the same interrupt).
>
>Which implies that when the card was inserted and powered on, it started 
>enabling the interrupt early, before the low-level driver had had a chance 
>to register _its_ interrupt handler.
>
>  
>
>>01:00.0 Class 0c03: 10b9:5237 (rev 03) (prog-if 10)
>>        Subsystem: 10b9:5237
>>        Flags: 66Mhz, medium devsel, IRQ 11
>>        Memory at 10400000 (32-bit, non-prefetchable) [disabled] [size=4K]
>>        Capabilities: [60] Power Management version 2
>>
>>01:00.3 Class 0c03: 10b9:5239 (rev 01) (prog-if 20)
>>        Subsystem: 10b9:5272
>>        Flags: 66Mhz, medium devsel, IRQ 11
>>        Memory at 10401000 (32-bit, non-prefetchable) [disabled] [size=256]
>>        Capabilities: [50] Power Management version 2
>>        Capabilities: [58] #0a [2090]
>>    
>>
>
>Hmm. That would be "PCI_CLASS_SERIAL_USB", but clearly:
>  
>

Yes, in addition to the CARDBUS slots, into which I want to insert this 
card:

    http://link-depot.com/pcb-u22.html

there is also an onboard USB support, but not 2.0 USB.

>  
>
>>root@EMBEDDED[~]# cat /proc/interrupts
>>           CPU0
>> 11:      98681          XT-PIC  yenta, yenta
>>    
>>
>
>No USB driver there, so the driver never even loaded. The problem probably 
>happened immediately on card insertion, and is likely card-indepdendent. 
>But it would be nice to have that confirmed by testing.
>  
>
The console dumps from my original posting were done without first 
loading ehci_hcd.  Today you can see above ehci_hcd was loaded first, 
but this does not fix the problem.

Thank you!

