Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVBWP4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVBWP4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBWP4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:56:36 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:55249 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261443AbVBWP4W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:56:22 -0500
Message-ID: <421CA794.3070909@emc.com>
Date: Wed, 23 Feb 2005 10:56:04 -0500
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Justin Cormack <justin@street-vision.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: AHCI oops
References: <200502200256.j1K2uKJ23938@tench.street-vision.com> <421BEEE1.5080005@pobox.com>
In-Reply-To: <421BEEE1.5080005@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Can you try this patch?
> 
> If it fixes the oops, I'll forward upstream ASAP.

Jeff,

It fixes the oops (pasted below) for me; please do push it ASAP.

thanks,
BR


xlated vfy cmd LBA 0x14f500 cnt 20
ahci_interrupt: int on port 2
ahci_host_intr: fatal int seen
ahci_intr_error: port 2 irq_stat 0x40000001
struct ata_port *ap = 0xc1bf79bc
ap->ioaddr.error_addr = 0x00000000

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c0279bfd
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: af_packet ipmi_devintf ipmi_msghandler
CPU:    0
EIP:    0060:[<c0279bfd>]    Not tainted VLI
EFLAGS: 00010202   (2.6.11-rc4)
EIP is at ata_to_sense_error+0x22d/0x3a0
eax: 00000000   ebx: ffffffff   ecx: 563ff726   edx: 000007bf
esi: c1bf79bc   edi: c1bf08bc   ebp: 00000000   esp: c03a5ed4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03a4000 task=c0350b20)
Stack: c0329736 00000000 00000282 001f7934 c1bf0800 01000246 c1bf7e78 
c1bf0800
        c1bf7e78 40000001 c1bf7e78 c027a48e c1bf7e78 c1bf79bc c0277fd4 
c0333e88
        00000002 00000002 40000001 00000002 01bf79bc 00000002 c027baa2 
c032995e
Call Trace:
  [<c027a48e>] ata_scsi_qc_complete+0x5e/0x60
  [<c0277fd4>] ata_qc_complete+0x34/0xf0
  [<c027baa2>] ahci_interrupt+0x152/0x1a0
  [<c012b082>] handle_IRQ_event+0x32/0x70
  [<c012b167>] __do_IRQ+0xa7/0x110
  [<c01044a6>] do_IRQ+0x36/0x70
  [<c0102cf2>] common_interrupt+0x1a/0x20
  [<c0100675>] mwait_idle+0x25/0x50
  [<c0100609>] cpu_idle+0x49/0x60
  [<c03a680a>] start_kernel+0x16a/0x1b0
  [<c03a6380>] unknown_bootoption+0x0/0x1e0
Code: e9 ff 8d b6 00 00 00 00 8d bf 00 00 00 00 b8 58 89 41 00 4b e8 e5 
e6 f7 f
  <0>Kernel panic - not syncing: Fatal exception in interrupt
