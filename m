Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUFMRMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUFMRMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUFMRMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:12:05 -0400
Received: from main.gmane.org ([80.91.224.249]:23249 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265222AbUFMRLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:11:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (=?utf-8?b?RGFnZmlubiBJbG1hcmkg?=
	=?utf-8?b?TWFubnPDpWtlcg==?=)
Subject: Re: Ooops in 2.6.7-rc1
Date: Sun, 13 Jun 2004 19:11:43 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8j7jub1iy8.fsf@wirth.ping.uio.no>
References: <1085882129.2248.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: wirth.ping.uio.no
Mail-Copies-To: nobody
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:S19jDHNbcVUEvOqLjkLeja+c4l0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> My laptop just got that (bk clone updated yesterday). 2.6.6-rc1 was stable over
> 3 weeks on this same box. It's a NULL dereference (DAR = 0)
>
> May 30 11:35:27 gaston kernel: Oops: kernel access of bad area, sig: 11 [#1]
> May 30 11:35:27 gaston kernel: NIP: C0046FBC LR: C00470D0 SP: ED6BFCA0 REGS: ed6bfbf0 TRAP: 0300    Not tainted
> May 30 11:35:27 gaston kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> May 30 11:35:27 gaston kernel: DAR: 00000000, DSISR: 42000000
> May 30 11:35:27 gaston kernel: TASK = ef5fa030[1589] 'XFree86' THREAD: ed6be000Last syscall: 3
> May 30 11:35:27 gaston kernel: GPR00: 0000000C ED6BFCA0 EF5FA030 C060F9A0 EFB6E77C E949DE5C E949DE74 00200200
> May 30 11:35:27 gaston kernel: GPR08: 00100100 D3F40A9C 00000000 C8FDA000 ED6BFEAC 101E2FE8 101E0000 101E0000
> May 30 11:35:27 gaston kernel: GPR16: 00000001 00000001 FFFFFFA1 DEFD4620 00000000 00000000 CDE3B3A4 00000040
> May 30 11:35:27 gaston kernel: GPR24: CDE3B494 C060F9BC C0390000 EFFF70C0 0000000C C060F9AC 00000003 C060F9A0
> May 30 11:35:27 gaston kernel: NIP [c0046fbc] free_block+0x78/0x134
> May 30 11:35:27 gaston kernel: LR [c00470d0] cache_flusharray+0x58/0xb0
> May 30 11:35:27 gaston kernel: Call trace:
> May 30 11:35:27 gaston kernel:  [c00470d0] cache_flusharray+0x58/0xb0
> May 30 11:35:27 gaston kernel:  [c0047628] kfree+0x88/0xa4
> May 30 11:35:27 gaston kernel:  [c01e78e0] skb_release_data+0xd4/0xfc
> May 30 11:35:27 gaston kernel:  [c01e7920] kfree_skbmem+0x18/0x3c
> May 30 11:35:27 gaston kernel:  [c01e79f8] __kfree_skb+0xb4/0x12c
> May 30 11:35:27 gaston kernel:  [c023a2e4] unix_stream_recvmsg+0x218/0x48c
> May 30 11:35:27 gaston kernel:  [c01e3da4] sock_aio_read+0xcc/0xe0
> May 30 11:35:27 gaston kernel:  [c005cad4] do_sync_read+0x78/0xbc
> May 30 11:35:27 gaston kernel:  [c005cc28] vfs_read+0x110/0x128
> May 30 11:35:27 gaston kernel:  [c005ce64] sys_read+0x40/0x74
> May 30 11:35:27 gaston kernel:  [c0007c90] ret_from_syscall+0x0/0x4c

I have seen quite a few similar oopses here on my x86 laptop with
2.7.1-rc3-mm1, involving both unix_stream_recvmsg and bt_sock_recvmsg.
Here's one of the latter kind:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c021d454
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: sco hci_usb af_packet prism54 firmware_class nfs lockd sunrpc rfcomm l2cap bluetooth md5 ipv6 smsc_ircc2 ds iptable_nat ipt_state ip_conntrack iptable_mangle iptable_filter ip_tables e100 mii snd_maestro3 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_timer snd soundcore uhci_hcd usbcore yenta_socket pcmcia_core intel_agp agpgart ircomm_tty ircomm irda ide_cd cdrom mousedev joydev evdev psmouse apm i8k unix
CPU:    0
EIP:    0060:[<c021d454>]    Not tainted VLI
EFLAGS: 00210287   (2.6.7-rc3-mm1) 
EIP is at skb_release_data+0x34/0xa0
eax: cffc7cd8   ebx: 00000000   ecx: cffc7cd8   edx: 00000000
esi: c1d26560   edi: cbc9af38   ebp: cc9c57c0   esp: cbc9ae64
ds: 007b   es: 007b   ss: 0068
Process hstest (pid: 1437, threadinfo=cbc9a000 task=cf80f830)
Stack: c1d26560 00000030 c021d4c8 00000000 c021d56c c1d26560 c1d26560 00000030 
       c1d26560 c1d26560 d09d252e 00000030 00000000 00000000 d09fe660 cbc9aed8 
       00000800 c0219f40 00000800 00000000 bfffee30 00000000 00000000 00000000 
Call Trace:
 [<c021d4c8>] kfree_skbmem+0x8/0x20
 [<c021d56c>] __kfree_skb+0x8c/0x120
 [<d09d252e>] bt_sock_recvmsg+0x7e/0xb0 [bluetooth]
 [<c0219f40>] sock_aio_read+0xb0/0xd0
 [<c014e7ed>] do_sync_read+0x6d/0xb0
 [<c016007d>] sys_select+0x24d/0x4b0
 [<c014e917>] vfs_read+0xe7/0x110
 [<c014eb38>] sys_read+0x38/0x60
 [<c0103ef9>] sysenter_past_esp+0x52/0x71

Code: 0f 8b 80 a8 00 00 00 ff 08 0f 94 c2 84 d2 74 7a 8b 8e a8 00 00 00 8b 51 04 89 c8 85 d2 74 38 31 db 39 d3 73 32 89 f6 8b 54 d8 10 <8b> 02 f6 c4 08 75 17 8b 42 04 40 74 48 83 42 04 ff 0f 98 c0 84 


-- 
ilmari

