Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbVIOSk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbVIOSk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbVIOSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:40:57 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:24530 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030568AbVIOSk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:40:56 -0400
Message-ID: <4329BD8F.8030407@linuxtv.org>
Date: Thu, 15 Sep 2005 22:29:35 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <200509151148.57779@bilbo.math.uni-mannheim.de> <4329877A.4090809@linuxtv.org> <200509151658.01793@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509151658.01793@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: manu@kromtek.com
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:

>Manu Abraham wrote:
>
>  
>
>>So it now looks like this but i have another problem now, after
>>consecutive, load/unload, i get an oops ..
>>    
>>
Ah, one more thing i noticed, in the probe function, whatever i do to 
generate interrupts, the interrupt handler does not receive any 
interrupts, which makes me to think whether request_irq() really yielded 
me an IRQ.

One more thing after a module load unload cycle, i did a cat 
/proc/interrupts, which led to another oops..
Which makes me to think that request_irq did not work out as expected or 
something like that. Any clues .. ?


Regards,
Manu


[ 4001.876841] mantis_pci_probe: <1:>IRQ=23
[ 4001.877014] mantis_pci_probe: <2:>IRQ=23
[ 4001.877176] mantis_pci_probe: Got a device
[ 4001.877356] mantis_pci_probe: We got an IRQ
[ 4001.877514] mantis_pci_probe: We finally enabled the device
[ 4001.877730] Mantis Rev 1, irq: 23, latency: 32   
[ 4001.877836] memory: 0xefeff000, mmio: f9218000
[ 4009.156947] mantis_pci_remove: Removing -->Mantis irq: 23,         
latency: 32
[ 4009.156949]  memory: 0xefeff000, mmio: 0xf9218000
[ 4009.157391] Trying to free free IRQ23
[ 4516.358401] Unable to handle kernel paging request at virtual address 
f92bd7e2
[ 4516.360543]  printing eip:
[ 4516.362599] c02086fe
[ 4516.364574] *pde = 37ecf067
[ 4516.366591] *pte = 00000000
[ 4516.368554] Oops: 0000 [#1]
[ 4516.370304] SMP
[ 4516.372372] Modules linked in: i2c_core mb86a15 dvb_core 3c59x piix 
sd_mod
[ 4516.374903] CPU:    0
[ 4516.374904] EIP:    0060:[<c02086fe>]    Not tainted VLI
[ 4516.374906] EFLAGS: 00010097   (2.6.13)
[ 4516.382874] EIP is at vsnprintf+0x35e/0x4f0
[ 4516.385638] eax: f92bd7e2   ebx: 0000000a   ecx: f92bd7e2   edx: fffffffe
[ 4516.388683] esi: f4322122   edi: 00000000   ebp: f4322fff   esp: f2b0fec0
[ 4516.391978] ds: 007b   es: 007b   ss: 0068
[ 4516.395387] Process cat (pid: 3375, threadinfo=f2b0f000 task=f3c61020)
[ 4516.395641] Stack: f2b0ff04 f4322fff 00000000 00000000 0000000a 
0000000a 00000000 00000000
[ 4516.399463]        ffffffff ffffffff f2e328c0 f5f5dfa0 00000017 
f2e328c0 c01801d7 f4322120
[ 4516.403230]        00000ee0 c0369c81 f2b0ff20 00000008 c0105a4c 
f2e328c0 c0369c7e f92bd7e2
[ 4516.407497] Call Trace:
[ 4516.415981]  [<c01801d7>] seq_printf+0x37/0x60
[ 4516.420212]  [<c0105a4c>] show_interrupts+0x2bc/0x3b0
[ 4516.424905]  [<c017fcd6>] seq_read+0x1d6/0x2d0
[ 4516.429671]  [<c015e186>] vfs_read+0xb6/0x180
[ 4516.434507]  [<c015e531>] sys_read+0x51/0x80
[ 4516.439056]  [<c0102f5f>] sysenter_past_esp+0x54/0x75
[ 4516.444082] Code: 00 83 cf 01 89 44 24 24 eb bb 8b 44 24 48 8b 54 24 
20 83 44 24 48 04 8b 08 b8 3c 95 36 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 
eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 20
[ 4516.456263] 
