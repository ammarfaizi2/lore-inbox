Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWI2Mtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWI2Mtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWI2Mtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:49:31 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:14738 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932347AbWI2Mt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:49:29 -0400
Date: Fri, 29 Sep 2006 14:38:06 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: PROBLEM: Kernel 2.6.x freeze
Message-ID: <20060929143806.0d6a9162@localhost>
In-Reply-To: <451B7ACA.1000504@interia.pl>
References: <451B7ACA.1000504@interia.pl>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 07:33:30 +0000
Arkadiusz Jalowiec <ajalowiec@interia.pl> wrote:

> OOps:
> 
> ivalid opcode: 0000 [#1]
> Modules linked in ppp_deflate zlib_deflate bsd_comp pppoatm ipv6 
> partport_pc partport snd_pcm_oss snd_mixer oss via_agp agpgart 
> ueagle_atm usbatm uhci_hcd ehci_hcd usbcore i2c_viapro 12c_core 
> snd_via82xx snd_ac97_code snd_mpu401_uart snd_rawmidi opt_LOG 
> snd_seq_device xt limit snd soundcore via_rhine mill xt_tcpudp xt_state 
> iptables_filter nls_iso8859-2 nls_cp852 ip_contract_irc ip_contract_ftp 
> xt_contract ip_contract ip_tables x_tables
> 
> CPU: 0
> EIP: 0060: [<d0d184dc>] Not tainted VLI
> EFLAGS: 00010003 (2.6.18#1)
> EIP is at uhci_giveback_urb+0x59/0x126 [uhci_hcd]
> eax: cefeeed1 ebx: cf3935a0 ecx: ce2a9bc0 edx: cf3935a0
> esi: ce2a9bc0 edi: 00000000 epb: ce4933bc esp: c6b79f00
> ds: 007b es: 007b ss:0068
> 
> Process removepkg (pid: 11084, ti=c6b78000 task=c126e560 task.ti=c6b78000)
> 
> Stack:    00000046 c9936060 cf3935a0 ce4933bc d0d17e17 00000000 cefeeed0 
> cf3935a0
>     ce2a9bc0 00000000 cefeeed0 d0d18627 c6b79fbc c6b79fbc cefeeed0 cf3935a0
>     00000009 c6b79fbc d0d18846 00000246 00000000 00000000 cefeed00 d0d192ad
> 
> Call Trace:
> 
> [<d0d17e17>] uhci_result_common+0xb7/0x146 [uhci_hcd]
> [<d0d18627>] uhci_scan_qh+0x7e/0x174 [uhci_hcd]
> [<d0d18846>] uhci_scan_schedule+0x72/0xec [uhci_hcd]
> [<d0d192ad>] uhci_irq+0xe8/0xf8 [uhci_hcd]
> [<d0d365f8>] udb_hcd_irq+0x27/0x4e [usbcore]
> [<c012c4c4>] handle_IRQ_event+0x21/0x47
> [<c012c545>] do_IRQ+0x5b/0xa2
> [<c0104106>] do_IRQ+0x40/0x4d
> [<c0102c4a>] common_interrupt+0x1a/0x20
> 
> Code:     5c 89 57 2c 8b 40 44 c7 47 40 00 00 00 00 89
>                 47 3c 8b 45 00 8b 55 04 89 02 89 50 04 89
>                 6d 00 8d 47 18 89 6d 04 39 47 18 75
>                 4b 0f <b6> 47 50 a8 02 88 44 24 08 74 3f 0f b6
>                 46 20 8b 4e 20 ba fe ff
> 
> EIP:    [<d0d184dc>] uhci_giveback_urb+0x59/0x126
>     [uhci_hcd] SS: ESP 0068: c6b79f00
> <0> Kernel panic - not syncing: Fatal exception in interrupt


Do you have copied the Oops by hand, right?

Can you send the ".config" for this 2.6.18?


I'm not an expert but...

This is how the code should look like (I've compiled 2.6.18 with gcc
3.3.6 + gentoo patches):

c02dd6a2:       74 5c                   je     c02dd700 <uhci_giveback_urb+0xa0>
c02dd6a4:       0f b6 46 20             movzbl 0x20(%esi),%eax
c02dd6a8:       8b 4e 20                mov    0x20(%esi),%ecx
c02dd6ab:       c7 04 24 fe ff ff ff    movl   $0xfffffffe,(%esp)


But we have:

  500894:       74 3f                   je     5008d5 <_end+0x2d>
  500896:       0f b6 46 20             movzbl 0x20(%rsi),%eax
  50089a:       8b 4e 20                mov    0x20(%rsi),%ecx
  50089d:       ba                      .byte 0xba
  50089e:       fe                      (bad)
  50089f:       ff                      .byte 0xff


So "c7 04 24" turned into
   "ba fe ff"


The funny thing is that "fe ff" comes just after "24" in the original
code...


Questions for LKML:

1) Isn't the kernel code write-protected at page level?
   Or maybe is it only protected when "CONFIG_DEBUG_RODATA=y"?

2) In this case the "corrupted" memory is in a module, is/can also this
code be write-protected?

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
