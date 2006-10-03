Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWJCTwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWJCTwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWJCTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:52:41 -0400
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:62904 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030210AbWJCTwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:52:39 -0400
Date: Tue, 3 Oct 2006 21:52:00 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
Message-ID: <20061003215200.0d1047db@localhost>
In-Reply-To: <452188DA.6090000@interia.pl>
References: <20060930141455.29fdadef@localhost>
	<Pine.LNX.4.44L0.0609301131190.7052-100000@netrider.rowland.org>
	<20061001161020.20e941c6@localhost>
	<452188DA.6090000@interia.pl>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 23:47:06 +0200
Arkadiusz Jalowiec <ajalowiec@interia.pl> wrote:

> BUG: unable to handle kernel paging request at virtual address 000f9edf
> printing epip
> *pde=00000000
> Ops: 0002 [#1]
> Modules linked in: ppp_deflate zlib_deflate bsd_comp pppoatm ipv6 
> partport_pc partport snd_pcm_oss snd_mixer_oss via_agp agpgart uagle_atm 
> usbatm uhci_hcd ehci_hcd usbcore i2c_viapro i2c_core snd_via82xx 
> snd_ac97.codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc 
> snd_mpu_401_uart snd_rawmidi ipt_LOG snd_seq_device snd xt_limit 
> soundcore via_rhine mii xt_tcpudp xt_state iptables_filter nls_iso8859-2 
> nls_cp852 ip_contract_irc ip_contract_ftp xt_contract ip_contract 
> iptables x_tables
> CPU: 0
> EIP: 0060: [<d0d18140>] Not tainted VLI
> EFLAGS: 00010083 (2.6.18 #1)
> EIP is at uhci_result_isochronous+0x4f/0x131 [uhci_hcd]
> eax: 000f9edf ebx: cf7b3600 edx:000f9edf edx:ceedfed0
> esi:cf7b3600 edi:cba5c2a0 epb:ceedfed0 esp:c03adef8
> ds:007b es:007b ss:0068
> 
> Process swapper (pid:0,ti=c03ac000 task=c03530a0 task.ti=c03ac000)
> Stack: cf15e3a0 cba5c330 ce2caac0 ceedfed0 cf7b3600 ce2caac0 00000001 
> ceedfed0
> d0d185d1 c03adfa4 ceedfed0 cf7b3600 00000001 c03adfa4 d0d1884b 00000246
> 00000000 00000000 ceedfe00 d0d192ad ceedfed0 c03adfa4 ceedfe00 00000000
> 
> Call Trace:
> [<d0d185d1>] uhci_scan_qh+0x28/0x174 [uhci_hcd]
> [<d0d18846>] uhci_scan_schedule+0x72/0xec [uhci_hcd]
> [<d0d192ad>] uhci_hcd_irq+0x27/0x4e [usbcore]
> [<c012c4c4>] handle_IRQ_event+0x21/0x47
> [<c012c545>]_do_IRQ+0x5b/0xa2
> [<c0104106>] do_IRQ+0x40/04d
> [<c0102c4a>] common_interrupt+0x1a/0x20
> [<c021dfd1>] acpi_processor_idle+0x1c4/0x2c3
> [<c01010c4>] cpu_idle+0x3f/0x5b
> [<c03ae63b>] start_kernel+0x197/0x199
> 
> Code 83 ed 14 39 c2 89 6c 24 04 0f 84 f3 00 00 00 8b 46 3c 8b 54 24 0c 
> 3b 42 70 78 0a b8 8d ff ff ff e9 e0 00 00 00 89 c1 8b 6c 24 0c <00> 20 
> 7b 0f 00 00 00 00 69 7f e0 ff 00 00 00 00 00 20 7b 0f 14
> 
> EIP:[<cd0d18140>] uhci_result_isochronous+0x4f/0x131
> [uhci_hcd] SS:ESP 0068:c03adef8
> <0> Kernel panic - not syncing: Fatal excepition in interrupt
> 
> I run "objdump -d drivers/usb/host/uhci-hcd.o" and post the portion of 
> the output for: uhci_result_isochronous
> 
> 000010f1 <uhci_result_isochronous>:

[CUT]

>     1115:    83 ed 14                 sub    $0x14,%ebp
>     1118:    39 c2                    cmp    %eax,%edx
>     111a:    89 6c 24 04              mov    %ebp,0x4(%esp)
>     111e:    0f 84 f3 00 00 00        je     1217 
> <uhci_result_isochronous+0x126>
>     1124:    8b 46 3c                 mov    0x3c(%esi),%eax
>     1127:    8b 54 24 0c              mov    0xc(%esp),%edx
>     112b:    3b 42 70                 cmp    0x70(%edx),%eax
>     112e:    78 0a                    js     113a 
> <uhci_result_isochronous+0x49>
>     1130:    b8 8d ff ff ff           mov    $0xffffff8d,%eax
>     1135:    e9 e0 00 00 00           jmp    121a 
> <uhci_result_isochronous+0x129>
>     113a:    89 c1                    mov    %eax,%ecx
>     113c:    8b 6c 24 0c              mov    0xc(%esp),%ebp
>     1140:    81 e1 ff 03 00 00        and    $0x3ff,%ecx
               ||
                ----> EIP points here


>     1146:    8b 45 58                 mov    0x58(%ebp),%eax
>     1149:    8b 1c 88                 mov    (%eax,%ecx,4),%ebx
>     114c:    85 db                    test   %ebx,%ebx
>     114e:    74 35                    je     1185 
> <uhci_result_isochronous+0x94>
>     1150:    8b 43 24                 mov    0x24(%ebx),%eax
>     1153:    8b 55 54                 mov    0x54(%ebp),%edx
>     1156:    8b 40 e0                 mov    0xffffffe0(%eax),%eax
>     1159:    89 04 8a                 mov    %eax,(%edx,%ecx,4)



The assembly extracted by the dumped code is:

   0:   83 ed 14                sub    $0x14,%ebp
   3:   39 c2                   cmp    %eax,%edx
   5:   89 6c 24 04             mov    %ebp,0x4(%esp)
   9:   0f 84 f3 00 00 00       je     102 <str+0x102>
   f:   8b 46 3c                mov    0x3c(%esi),%eax
  12:   8b 54 24 0c             mov    0xc(%esp),%edx
  16:   3b 42 70                cmp    0x70(%edx),%eax
  19:   78 0a                   js     25 <str+0x25>
  1b:   b8 8d ff ff ff          mov    $0xffffff8d,%eax
  20:   e9 e0 00 00 00          jmp    105 <str+0x105>
  25:   89 c1                   mov    %eax,%ecx
  27:   8b 6c 24 0c             mov    0xc(%esp),%ebp
  2b:   00 20                   add    %ah,(%eax)
        ||
         ----> EIP points here


  2d:   7b 0f                   jnp    3e <str+0x3e>
  2f:   00 00                   add    %al,(%eax)
  31:   00 00                   add    %al,(%eax)
  33:   69 7f e0 ff 00 00 00    imul   $0xff,0xffffffe0(%edi),%edi
  3a:   00 00                   add    %al,(%eax)
  3c:   20 7b 0f                and    %bh,0xf(%ebx)
  3f:   14



The code dumped from memory matches the original one up to, and not
including, the failing istruction. From that point the code is
different.


The failure is only a natural consequence of:

	add    %ah,(%eax)

with "eax" pointing to 000f9edf, that belongs to the BIOS reserved
memory region...


The real problem is that the code starting from "0xcd0d18140" has been
overwritten by something :(


Another thing: both panics happened in interrupt context and both times
uhci driver is involved.


And this is the data that has overwritten the code:

00 20 7b 0f 00 00 00 00 69 7f e0 ff 00 00 00 00 00 20 7b 0f 14
^^^^^^^^^^^                                     ^^^^^^^^^^^


Maybe someone have an idea of where does this data come from?


To me it looks like a struct with ints / pointers:

{
	0x0f7b2000,
	NULL,
	0xffe07f69,
	NULL,
	0x0f7b2000,
	0x......14
}


Maybe this will ring some bells...

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
