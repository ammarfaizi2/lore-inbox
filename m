Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUBBLpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBBLpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:45:34 -0500
Received: from linux-bt.org ([217.160.111.169]:20877 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S265354AbUBBLpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:45:30 -0500
Subject: Re: [Bug 1996] New: Bluetooth stack crashes kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       thomas@koeller.dyndns.org
In-Reply-To: <67350000.1075703548@[10.10.2.4]>
References: <67350000.1075703548@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1075722288.29899.7.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 12:44:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

as already reported to Andrew, this bug was fixed in 2.6.2-rc1.

Regards

Marcel

> http://bugme.osdl.org/show_bug.cgi?id=1996
> 
>            Summary: Bluetooth stack crashes kernel
>     Kernel Version: 2.6.1
>             Status: NEW
>           Severity: normal
>              Owner: other_modules@kernel-bugs.osdl.org
>          Submitter: thomas@koeller.dyndns.org
> 
> 
> Distribution: - 
> Hardware Environment: x86 PC 
> Software Environment: 
> Linux sarkovy.koeller.dyndns.org 2.6.1 #1 Sat Jan 10 01:54:59 CET 2004 i686 
> unknown 
>  
> Gnu C                  3.3.2 
> Gnu make               3.80 
> util-linux             2.11z 
> mount                  2.11z 
> module-init-tools      0.9.15-pre2 
> e2fsprogs              1.33 
> nfs-utils              1.0.3 
> awk: cmd. line:2: (FILENAME=- FNR=1) fatal: attempt to access field -1 
> Dynamic linker (ldd)   2.3.2 
> Procps                 3.1.9 
> Net-tools              1.52 
> Kbd                    1.10 
> Sh-utils               2.0 
> Modules Loaded         snd_dummy snd_via82xx snd_pcm snd_timer snd_ac97_codec 
> snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd hci_usb bluetooth 
> uhci_hcd usbcore cls_fw sch_htb ipt_tos ipt_mark ipt_MARK ipt_TOS 
> iptable_mangle ipt_MASQUERADE iptable_nat ipt_TCPMSS ipt_pkttype ipt_length 
> ipt_multiport ipt_REJECT ipt_LOG ipt_limit ipt_state iptable_filter ip_tables 
> ip_conntrack_ftp ip_conntrack pppoe pppox af_packet ppp_generic slhc epic100 
> mii crc32 
>  
> Problem Description: 
> I am using a bluetooth adapter connected via USB. When uploading data from a 
> bluetooth device the kernel frequently crashes, like so (please note that I 
> wrote this down from the screen and typed it in again, so there may be errors): 
>  
> kernel BUG at include/linux/module.h:296! 
> invalid operand: 0000 [#1] 
> CPU:    0 
> EIP:    0060:[<c8944753>]    Not tainted 
> EFLAGS: 00010246 
> EIP is at l2cap_sock_alloc+0xc3/0xe0 [l2cap] 
> eax: 00000000   ebx: c261c080   ecx: 00000000   edx: c261c080 
> esi: 00000000   edi: c3a85980   ebp: c3a85980   esp: c02ddce0 
> ds: 007b   es: 007b   ss: 0068 
> Process swapper (pid: 0, threadinfo=c02dc000 task=c027fb20) 
> Stack: c894a280 00000000 00000024 00000020 c02dc000 c3f359d4 c89466b8 00000000 
>        00000000 00000020 c8859b4c c3b00028 c3a85200 c88912d5 c3a85200 00000014 
>        c02ddd3c 00000014 c261cbc0 00100030 0000008a 00000000 00000004 c118a81c 
> Call Trace: 
> [<c89466b8>] l2cap_recv_frame+0x518/0xe00 [l2cap] 
> [<c88912d5>] tcp_match+0x75/0x170 [ip_tables] 
> [<c88a206b>] match+0x6b/0xd0 [ip_multiport] 
> [<c889e017>] match+0x17/0x50 [ipt_state] 
> [<c888f292>] ipt_do_table+0x262/0x340 [ipt_tables] 
> [<c021c9c0>] ip_local_deliver_finish+0x0/0x150 
> [<c01ccbd8>] get_device+0x18/0x30 
> [<c88edcf7>] uhci_submit_common+0x1f7/0x2b0 [uhci_hcd] 
> [<c8904d8a>] hcd_submit_urb+0xfa/0x170 [usbcore] 
> [<c8905811>] usb_submit_urb+0x1d1/0x250 [usbcore] 
> [<c88e1255>] hci_usb_rx_complete+0x1a5/0x6e0 [hci_usb] 
> [<c89474e1>] l2cap_recv_acldata+0x181/0x340 [l2cap] 
> [<c892f117>] hci_rx_task+0x1a7/0x340 [bluetooth] 
> [<c011fcb6>] tasklet_action+0x46/0x70 
> [<c011fad0>] do_softirq+0x90/0xa0 
> [<c010b56d>] do_IRQ+0xfd/0x130 
> [<c0105000>] _stext+0x0/0x60 
> [<c01098a4>] common_interrupt+0x18/0x20 
> [<c0105000>] _stext+0x0/0x60 
> [<c0106c13>] default_idle+0x23/0x30 
> [<c0106c7c>] cpu_idle+0x2c/0x40 
> [<c02de707>] start_kernel+0x147/0x160 
> [<c02de480>] unknown_bootoption+0x0/0x100 
>  
> Code: 0f 0b 28 01 6f 79 94 c8 eb 95 0f 0b cb 01 86 79 94 c8 e9 69 
>  <0>Kernel panic: Fatal exception in interrupt 
> In interrupt handler - not syncing 
>  
> Steps to reproduce: 
> /home/thomas $ hcid 
> /home/thomas $ sdpd 
> /home/thomas $ sdptool add --channel=10 OPUSH 
> OBEX Object Push service registered 
>  
> At this point I start uploading images taken with a cellphone camera. The crash 
> usually occurs after uploading 4..5 images.


