Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161358AbWALWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161358AbWALWjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWALWjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:39:39 -0500
Received: from mail4.zigzag.pl ([217.11.136.106]:25241 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S1161358AbWALWji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:39:38 -0500
X-Mail-Scanner: Scanned by qSheff 1.0-r3 (http://www.enderunix.org/qsheff/)
Message-ID: <43C6DA9D.4060300@mieszczak.com.pl>
Date: Thu, 12 Jan 2006 23:39:25 +0100
From: Miroslaw Mieszczak <mirek@mieszczak.com.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051120)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6] Problem with PDC20265 on system with I865 chipset and PIV HT
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with PDC20265 controller.
On 2.6 kernel I can use it only if set kernel parameters ide2=serialize 
ide3=serialize.
In other case simultaneous R/W operation from both channels lead into 
data corruption and system crash.

Today I tried 2.6.15 kernel, and few times saved Oops data:


Oops: 0002 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c0110471>]    Not tainted VLI
EFLAGS: 00010003   (2.6.15)
EIP is at smp_invalidate_interrupt+0x2d/0x6f
eax: 00579000   ebx: f7c22000   ecx: f7302300   edx: 00000001
esi: c0575380   edi: c0575300   ebp: f7c22000   esp: f7c23f70
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7c22000 task=f7c1c530)
Stack: c010386c f7c22000 c170e2e0 f7c22000 c0575380 c0575300 f7c22000 
00000000
       0000007b 0000007b fffffffd c0100d7c 00000060 00000246 c0100e19 
01020809
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
Call Trace:
 [<c010386c>] invalidate_interrupt+0x1c/0x24
 [<c0100d7c>] default_idle+0x2e/0x52
 [<c0100e19>] cpu_idle+0x65/0x73
Code: e0 ff ff 21 e0 8b 50 10 0f a3 15 38 d6 57 c0 19 c0 85 c0 74 28 b8 
00 59 57 c0 03 04 95 04 b0 57 c0 8b 08 3b 0d 3c d6 57 c0 74 13 <c7> 05 
b0 d0 ff ff 00 00 00 00 f0 0f b3 15 38 d6 57 c0 c3 83 78


-----------------------------------------------------------------------------------------------

Oops: 0002 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    0
EIP:    0060:[<c01121fb>]    Not tainted VLI
EFLAGS: 00010006   (2.6.15)
EIP is at smp_apic_timer_interrupt+0x34/0x100
eax: c17062e0   ebx: c057598c   ecx: 00000000   edx: c053e000
esi: c0575380   edi: c053ff98   ebp: c053e000   esp: c053ff7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c053e000 task=c04c9b20)
Stack: ffffffff f6ba5a30 c053e000 c0575380 c0575300 c053e000 c01038b4 
c053e000
       c17062e0 c053e000 c0575380 c0575300 c053e000 00000000 0000007b 
0000007b
       ffffffef c0100d7c 00000060 00000246 c0100e19 00020809 0009c300 
c0532800



----------------------------------------------------------------------------------------------------


Oops: 0000 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c011039d>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15)
EIP is at send_IPI_mask_bitmask+0x2a/0x86
eax: fffffffc   ebx: 00000001   ecx: f7315900   edx: 00000001
esi: 000000fd   edi: 00000292   ebp: 0000000b   esp: f62c1df4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 12551, threadinfo=f62c0000 task=f75ff530)
Stack: bfda5fff c170e900 00000000 bfda6000 f7315900 f6a8fd2c f7315900 
c0110536
       00000001 000000fd bfd91000 bfda6000 c170e900 c0110622 00000001 
f7315900
       ffffffff 00000001 c015339a f7315900 f6a8fd2c 00000000 00000000 
f62c1e5c
Call Trace:
Unable to handle kernel paging request at virtual address ffffd1e0
 printing eip:
c0113603
*pde = 00003067
*pte = 50387744
 [<c0110536>] flush_tlb_others+0x83/0xdb
 [<c0110622>] flush_tlb_mm+0x48/0x8e
 [<c015339a>] exit_mmap+0xf4/0x11e
 [<c011a7b1>] mmput+0x38/0x98
 [<c011f597>] do_exit+0xf9/0x3dc
 [<c011f8e5>] do_group_exit+0x3c/0xa2
 [<c0128e45>] get_signal_to_deliver+0x22c/0x340
 [<c0102c4e>] do_signal+0x6a/0x13d
 [<c01038b4>] apic_timer_interrupt+0x1c/0x24
 [<c0121d93>] __do_softirq+0x6b/0xd8
 [<c0186f3e>] inotify_dentry_parent_queue_event+0x4c/0xc7
 [<c0114e32>] do_page_fault+0x0/0x5a6
 [<c01150de>] do_page_fault+0x2ac/0x5a6

-----------------------------------------------------------------------------------------
Oops: 0003 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    0
EIP:    0060:[<c0110957>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15)
EIP is at smp_reschedule_interrupt+0x0/0xb
eax: c053ff98   ebx: c053e000   ecx: c17062e0   edx: 0000007b
esi: c0575380   edi: c0575300   ebp: c053e000   esp: c053ff94
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c053e000 task=c04c9b20)
Stack: c0103848 c053e000 c17062e0 c053e000 c0575380 c0575300 c053e000 
00000000
       0000007b 0000007b fffffffc c0100d7c 00000060 00000246 c0100e19 
00020809
       0009c300 c0532800 005cb007 c054091c 00038000 c057c220 c04c6abc 
0000006d


----------------------------------------------------------------------------------------------

Oops: 0002 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c0110957>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15)
EIP is at smp_reschedule_interrupt+0x0/0xb
eax: f7c23f74   ebx: f7c22000   ecx: c170e2e0   edx: 0000007b
esi: c0575380   edi: c0575300   ebp: f7c22000   esp: f7c23f70
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7c22000 task=f7c1c530)
Stack: c0103848 f7c22000 c170e2e0 f7c22000 c0575380 c0575300 f7c22000 
00000000
       0000007b 0000007b fffffffc c0100d7c 00000060 00000246 c0100e19 
01020809
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
Call Trace:
 [<c0103848>] reschedule_interrupt+0x1c/0x24
 [<c0100d7c>] default_idle+0x2e/0x52
 [<c0100e19>] cpu_idle+0x65/0x73
Code: 00 00 00 00 c7 44 24 08 01 00 00 00 c7 44 24 04 00 00 00 00 c7 04 
24 f8 08 11 c0 e8 74 fe ff ff fa e8 a7 12 00 00 fb 83 c4 10 c3 <c7> 05 
b0 d0 ff ff 00 00 00 00 c3 53 83 ec 04 a1 44 d6 57 c0 8b
 <1>Unable to handle kernel paging request at virtual address ffffd300
 printing eip:
c011039d
*pde = 00003067
*pte = 0d89645e
Oops: 0000 [#2]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c011039d>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15)
EIP is at send_IPI_mask_bitmask+0x2a/0x86
eax: fffffffc   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: 000000fc   edi: 00000096   ebp: f7c23da4   esp: f7c23d18
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7c22000 task=f7c1c530)
Stack: 84113b45 84113b45 00000013 f7c23d44 00000000 f76d2530 c1707520 
c01107a9
       00000001 000000fc 00000000 f7c23da4 c0116bc9 00000000 c1707520 
00000000
       01190f60 000000b7


------------------------------------------------------------------------------------

Oops: 0002 [#1]
SMP <1>Unable to handle kernel paging request at virtual address ffffc000
 printing eip:
c0112b48
*pde = 00003067
*pte = 00000000

Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c01121fb>]    Not tainted VLI
EFLAGS: 00010006   (2.6.15)
EIP is at smp_apic_timer_interrupt+0x34/0x100
eax: c170e2e0   ebx: c057598c   ecx: 00000001   edx: f7c22000
esi: c0575380   edi: f7c23f74   ebp: f7c22000   esp: f7c23f58
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7c22000 task=f7c1c530)
Stack: f7c23f74 f7c22000 f7c22000 c0575380 c0575300 f7c22000 c01038b4 
f7c22000
       c170e2e0 f7c22000 c0575380 c0575300 f7c22000 00000000 0000007b 
0000007b
       ffffffef c0100d7c


------------------------------------------------------------------------------------


Oops: 0002 [#1]
SMP
Modules linked in: netconsole<1>Unable to handle kernel paging request 
at virtual address ffffd300
 printing eip:
c011039d
*pde = 00003067
*pte = 67d19e54
 yenta_socket rsrc_nonstatic pcmcia_core
CPU:    0
EIP:    0060:[<c01121fb>]    Not tainted VLI
EFLAGS: 00010002   (2.6.15)
EIP is at smp_apic_timer_interrupt+0x34/0x100
eax: c17062e0   ebx: c057598c   ecx: 00000000   edx: c053e000
esi: c0575380   edi: c053ff98   ebp: c053e000   esp: c053ff7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c053e000 task=c04c9b20)
Stack: c053ff98 c053e000 c053e000 c0575380 c0575300 c053e000 c01038b4 
c053e000
       c17062e0 c053e000 c0575380 c0575300 c053e000 00000000 0000007b 
0000007b
       ffffffef c0100d7c 00000060


---------------------------------------------------------------------------------------


Oops: 0002 [#1]
SMP <1>Unable to handle kernel paging request at virtual address ffffd1e0
 printing eip:
c0113603
*pde = 00003067
*pte = 4e4e0000

Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c0113509>]    Not tainted VLI
EFLAGS: 00010097   (2.6.15)
EIP is at ack_edge_ioapic_irq+0x3c/0xe7
eax: 00000000   ebx: 00000000   ecx: f7c22000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: f7c22000   esp: f7c23f20
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7c22000 task=f7c1c530)
Stack: c170f520 00000001 f7c1c530 f7c22000 00000000 c0534f80 00000000 
f7c22000
       c013e0ac 00000000 00000001 c0121d93 c0534d08 c0534f9c f7c23f74 
f7c22000
       c0575380 c0575300 f7c22000 


-------------------------------------------------------------------------------------------


Oops: 0002 [#1]
SMP <1>Unable to handle kernel paging request at virtual address ffffd1e0
 printing eip:
c0113603
*pde = 00003067
*pte = 32202020

Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c0113509>]    Not tainted VLI
EFLAGS: 00010097   (2.6.15)
EIP is at ack_edge_ioapic_irq+0x3c/0xe7
eax: 00000000   ebx: 00000000   ecx: f5da0000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: bfde9e00   esp: f5da1d88
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 13070, threadinfo=f5da0000 task=f6857030)
Stack: 00000000 c04cf2a8 00000044 00000000 00000000 c0534f80 00000000 
bfde9e00
       c013e0ac 00000000 00000202 f733b7a8 c014fe4b c0534f9c f5da1ddc 
bfde9dfc
       f6857494 c0114e32 bfde9e00


--------------------------------------------------------------------------------------------

Oops: 0002 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
CPU:    1
EIP:    0060:[<c01121fb>]    Not tainted VLI
EFLAGS: 00010006   (2.6.15)
EIP is at smp_apic_timer_interrupt+0x34/0x100
eax: c170e2e0   ebx: c057598c   ecx: 00000001   edx: f595c000
esi: 00000008   edi: f595df2c   ebp: ffffe400   esp: f595df10
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 12992, threadinfo=f595c000 task=f6c39a30)
<1>Unable to handle kernel paging request at virtual address ffffd1e0
 printing eip:
c0113603
*pde = 00003067
*pte = 20203732

Stack: 00000000 bfd32f70 0000000b 00000008 c0114e32 ffffe400 c01038b4 
0000000b
       0000007b 00000000 00000008 c0114e32 ffffe400 f595dfbc 0001007b 
f73b007b
       ffffffef c0114ea0 00000060 00000206 c057b5ec 0000000d f595df88 
f6c39a30
Call Trace:
 [<c0114e32>] do_page_fault+0x0/0x5a6
 [<c01038b4>] apic_timer_interrupt+0x1c/0x24
 [<c0114e32>] do_page_fault+0x0/0x5a6


--------------------------------------------------------------------------------------------------

Oops: 0003 [#1]
SMP
Modules linked in: netconsole yenta_socket rsrc_nonstatic 
pcmcia_core<1>Unable to handle kernel paging request at virtual address 
ffffd0b0
 printing eip:
c0113509
*pde = 00003067
*pte = 2a07cc19

CPU:    0
EIP:    0060:[<c01121fb>]    Not tainted VLI
EFLAGS: 00010002   (2.6.15)
EIP is at smp_apic_timer_interrupt+0x34/0x100
eax: c17062e0   ebx: c057598c   ecx: 00000000   edx: c053e000
esi: c0575380   edi: c053ff98   ebp: c053e000   esp: c053ff7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c053e000 task=c04c9b20)
Stack: ffffffff f79d3030 c053e000 c0575380 c0575300 c053e000 c01038b4 
c053e000
       c17062e0 c053e000 c0575380 c0575300 c053e000 00000000 0000007b 
0000007b
       ffffffef c0100d7c 00000060






I don't know what I can do else to find the reason of the problem.
It is more detailed description in bugzilla: bug 4309

Best regards
Mirek
