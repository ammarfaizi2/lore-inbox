Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbVKBMNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVKBMNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVKBMNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:13:40 -0500
Received: from mail.ncipher.com ([82.108.130.24]:20631 "EHLO mail.ncipher.com")
	by vger.kernel.org with ESMTP id S932650AbVKBMNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:13:39 -0500
Message-ID: <4368AD58.6050809@f0rmula.com>
Date: Wed, 02 Nov 2005 12:13:12 +0000
From: James Hansen <linux-kernel-list@f0rmula.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trouble unloading a module..
References: <43664B31.3000305@f0rmula.com> <1130919119.2826.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1130919119.2826.5.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Being relatively inexperienced at kernel programming, does this point to 
>>anything that might be obvious to any of you, yet not to me? :)   Or are 
>>there any common stumbling blocks in terms of unloading modules on 64bit 
>>linux.
>>    
>>
>
>you
>1) didn't give the oops here
>  
>
Sorry, it looks to be failing within chrdev_open.  Could this be caused 
by not correctly unloading the driver?  Here's the oops:

Nov  1 11:39:06 localhost -- MARK --
Nov  1 11:59:06 localhost -- MARK --
Nov  1 12:09:01 localhost kernel:  <1>Unable to handle kernel paging 
request at ffffffffa0261b80 RIP:
Nov  1 12:09:01 localhost kernel: PML4 103027 PGD 105027 PMD 3e765067 PTE 0
Nov  1 12:09:01 localhost kernel: CPU 0
Nov  1 12:09:01 localhost kernel: Modules linked in: ipv6 hw_random 
shpchp pciehp pci_hotplug c4 b1 kernelcapi psmouse ext3 jbd raid5 xor 
raid1 raid0 md e1000 ds yenta_socket pcmcia_core sd_mod ide_cd cdrom 
ide_disk ide_generic pdc202xx_new aec62xx alim15x3 amd74xx atiixp cmd64x 
cs5520 cs5530 cy82c693 generic hpt34x ns87415 opti621 pdc202xx_old 
rz1000 sc1200 serverworks siimage sis5513 slc90e66 triflex trm290 
via82cxxx floppy usb_storage piix ide_core fbcon vga16fb vgastate 
usbserial usbkbd ehci_hcd uhci_hcd thermal processor fan ata_piix libata 
scsi_mod unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
Nov  1 12:09:01 localhost kernel: Pid: 5612, comm: hardserver Not 
tainted 2.6.8-11-amd64-generic
Nov  1 12:09:01 localhost kernel: RIP: 0010:[cdev_get+14/73] 
<ffffffff80163453>{cdev_get+14}
Nov  1 12:09:01 localhost kernel: RSP: 0018:000001003628de48  EFLAGS: 
00010246
Nov  1 12:09:01 localhost kernel: RAX: 0000000000000000 RBX: 
ffffffffa0261b80 RCX: 0000000000000000
Nov  1 12:09:01 localhost kernel: RDX: 000001003b5b9080 RSI: 
000001003b5b9080 RDI: 0000010002177680
Nov  1 12:09:01 localhost kernel: RBP: 000001003c45bd38 R08: 
000001003ea831a8 R09: 000001003ea831a8
Nov  1 12:09:01 localhost kernel: R10: 000001003b5b9080 R11: 
00000000000000f0 R12: 0000000000000000
Nov  1 12:09:01 localhost kernel: R13: 0000000000000000 R14: 
000001003b5b9080 R15: 0000000000000000
Nov  1 12:09:01 localhost kernel: FS:  0000002a959c2090(0000) 
GS:ffffffff80391580(0000) knlGS:0000000000000000
Nov  1 12:09:01 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Nov  1 12:09:01 localhost kernel: CR2: ffffffffa0261b80 CR3: 
0000000000101000 CR4: 00000000000006e0
Nov  1 12:09:01 localhost kernel: Process hardserver (pid: 5612, 
threadinfo 000001003628c000, task 0000010038bdc230)
Nov  1 12:09:01 localhost kernel: Stack: 0000000000000000 
0000010002177680 000001003c45bd38 ffffffff80163573
Nov  1 12:09:01 localhost kernel:        000001003ea831a8 
000001003ea831a8 000001003b5b9080 000001003c45bd38
Nov  1 12:09:01 localhost kernel:        000001003fbbeec0 0000000000000000
Nov  1 12:09:01 localhost kernel: Call 
Trace:<ffffffff80163573>{chrdev_open+180} 
<ffffffff8015bd2c>{dentry_open+205}
Nov  1 12:09:01 localhost kernel:        
<ffffffff8015be53>{filp_open+62} <ffffffff8023252e>{tcp_listen_start+325}
Nov  1 12:09:01 localhost kernel:        <ffffffff80166c0a>{getname+130} 
<ffffffff8015c04e>{sys_open+57}
Nov  1 12:09:01 localhost kernel:        
<ffffffff8010fc92>{system_call+126}
Nov  1 12:09:01 localhost kernel:
Nov  1 12:09:01 localhost kernel: Code: 83 3b 02 74 32 ff 83 00 01 00 00 
e8 41 38 04 00 48 85 c0 48
Nov  1 12:09:06 localhost kernel:  <6>ACPI: PCI interrupt 
0000:02:03.0[A] -> GSI 24 (level, low) -> IRQ 24
Nov  1 12:09:06 localhost kernel: ACPI: PCI interrupt 0000:07:06.0[A] -> 
GSI 18 (level, low) -> IRQ 18
Nov  1 12:19:06 localhost -- MARK --
Nov  1 12:39:06 localhost -- MARK --

>2) didn't post a URL to the driver source
>  
>
Sorry again.  Here is the source.  Right at the bottom, it appears to be 
calling pci_unregister_driver and unregister_chrdev as it should.

http://www.f0rmula.com/stuff/hostif.c

/var/log/messages says:

Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: entered
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing irq, 18
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing IO BAR, 1
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing MEM BAR, 2
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing pdev
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_pci_remove: entered
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: i21285_destroy: entered
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_outl: addr ec34, data c
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: entered
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing irq, 12
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing IO BAR, 1
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing MEM BAR, 2
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: nfp_dev_destroy: 
freeing pdev
Nov  2 13:11:54 localhost kernel: nfdrv 2.9.25+: cleanup_module: Module 
unloaded

I thought that should prevent the driver from being able to kernel 
oops.  Is there anything else that I should be calling?  Or could it be 
the parameters I'm calling these functions with? (bearing in mind this 
works fine on a similar 32bit kernel).

>so.. how is anyone supposed to help?
>  
>
I was thinking that there may have been a common issue that would allow 
a driver oops the kernel if not unloaded properly.  Obviously not.

Thanks for any advice, it's much appreciated.

James

>
>
>
>  
>
