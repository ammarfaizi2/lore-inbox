Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbUL0Rf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUL0Rf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUL0Rf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:35:29 -0500
Received: from smtp-out3.iol.cz ([194.228.2.91]:35740 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S261933AbUL0RfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:35:17 -0500
Message-ID: <41D047CE.50407@stud.feec.vutbr.cz>
Date: Mon, 27 Dec 2004 18:35:10 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: GPF in ip_tables on linux-2.6.10
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I got a general protection fault when loading iptables rules
with SuSEfirewall2. What I exactly did was:
Boot into kdm on my laptop. Login as myself. While KDE was loading,
I switched to a VGA console with CTRL+ALT+F1, login as root.
KDE was still loading in the background. As root I started OpenVPN:

openvpn --config /etc/openvpn/michich.conf &

This created the interface tun0.
Now I tried to reload my SuSEfirewall2 rules with:

rcSuSEfirewall2 restart

The script hung and this message appeared in syslog:

Dec 26 00:49:25 localhost SuSEfirewall2: Firewall customary rules loaded from /etc/sysconfig/scripts/SuSEfirewall2-custom
Dec 26 00:49:25 localhost kernel: general protection fault: 0000 [#1]
Dec 26 00:49:25 localhost kernel: PREEMPT
Dec 26 00:49:25 localhost kernel: Modules linked in: usbserial parport_pc lp parport snd_intel8x0m snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc cpufreq_powersave speedstep_ich speedstep_lib freq_table video 
battery ibm_acpi fan button thermal processor ac ipt_TCPMSS ipt_TOS ipt_state ipt_LOG ehci_hcd uhci_hcd usbcore e100 mii airo 
ipt_REJECT iptable_mangle iptable_filter ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables tun ide_cd cdrom 
nls_cp437 vfat fat nls_iso8859_1 ntfs nls_base
Dec 26 00:49:25 localhost kernel: CPU:    0
Dec 26 00:49:25 localhost kernel: EIP:    0060:[<c013b4c2>]    Not tainted VLI
Dec 26 00:49:25 localhost kernel: EFLAGS: 00010202   (2.6.10)
Dec 26 00:49:25 localhost kernel: EIP is at __free_pages+0x2/0x40
Dec 26 00:49:25 localhost kernel: eax: ffffffff   ebx: 00000001   ecx: ffffffff   edx: 00000000
Dec 26 00:49:25 localhost kernel: esi: cfb31220   edi: 00000001   ebp: d0a560b0   esp: c9083c0c
Dec 26 00:49:25 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 26 00:49:25 localhost kernel: Process iptables (pid: 7083, threadinfo=c9083000 task=cd6d3020)
Dec 26 00:49:25 localhost kernel: Stack: c014bda2 00000000 00000094 00000001 d096f960 d0a56120 00000070 c9083000
Dec 26 00:49:25 localhost kernel:        d098a66e c9083c54 d098cce0 c9083c84 c9083c98 0805b11c 000070e0 d0a64000
Dec 26 00:49:25 localhost kernel:        d0a4f000 d0b1a000 00000000 746c6966 00007265 00000000 00000000 00000000
Dec 26 00:49:25 localhost kernel: Call Trace:
Dec 26 00:49:25 localhost kernel:  [<c014bda2>] __vunmap+0xb2/0x100
Dec 26 00:49:25 localhost kernel:  [<d098a66e>] do_replace+0x49e/0x5d0 [ip_tables]
Dec 26 00:49:25 localhost kernel:  [<d098a96b>] do_ipt_set_ctl+0x4b/0x60 [ip_tables]
Dec 26 00:49:25 localhost kernel:  [<c0246351>] nf_sockopt+0xd1/0x130
Dec 26 00:49:25 localhost kernel:  [<c02463d0>] nf_setsockopt+0x20/0x30
Dec 26 00:49:25 localhost kernel:  [<c025611e>] ip_setsockopt+0xde/0xa90
Dec 26 00:49:25 localhost kernel:  [<c0246362>] nf_sockopt+0xe2/0x130
Dec 26 00:49:25 localhost kernel:  [<c0256b9b>] ip_getsockopt+0xcb/0x6b0
Dec 26 00:49:25 localhost kernel:  [<c013756c>] generic_file_read+0x9c/0xc0
Dec 26 00:49:25 localhost kernel:  [<c013e25d>] do_page_cache_readahead+0xbd/0x1b0
Dec 26 00:49:25 localhost kernel:  [<c01c4599>] __copy_to_user_ll+0x59/0x70
Dec 26 00:49:25 localhost kernel:  [<c013af8c>] buffered_rmqueue+0xec/0x1d0
Dec 26 00:49:25 localhost kernel:  [<c013b137>] __alloc_pages+0xc7/0x370
Dec 26 00:49:25 localhost kernel:  [<c0145cb5>] do_anonymous_page+0x115/0x190
Dec 26 00:49:25 localhost kernel:  [<c0145d9b>] do_no_page+0x6b/0x350
Dec 26 00:49:25 localhost kernel:  [<c0146309>] handle_mm_fault+0x179/0x1d0
Dec 26 00:49:25 localhost kernel:  [<c0114621>] do_page_fault+0x3b1/0x58f
Dec 26 00:49:25 localhost kernel:  [<c01478d9>] vma_merge+0x149/0x1e0
Dec 26 00:49:25 localhost kernel:  [<c0236566>] sock_common_setsockopt+0x26/0x40
Dec 26 00:49:25 localhost kernel:  [<c02342ed>] sys_setsockopt+0x5d/0xa0
Dec 26 00:49:25 localhost kernel:  [<c02349d2>] sys_socketcall+0x202/0x250
Dec 26 00:49:25 localhost kernel:  [<c0114270>] do_page_fault+0x0/0x58f
Dec 26 00:49:25 localhost kernel:  [<c010305f>] syscall_call+0x7/0xb
Dec 26 00:49:25 localhost kernel: Code: 78 16 8d b4 26 00 00 00 00 8b 44 9e 08 8b 56 04 e8 b4 f8 ff ff 4b 79 f1 5b 5e c3 8d 
b4 26 00 00 00 00 8d bc 27 00 00 00 00 89 c1 <8b> 00 f6 c4 08 75 1c 8b 41 04 40 74 1e 83 41 04 ff 0f 98 c0 84


I was able to sync the disk and reboot.

I've been trying to reproduce but haven't succeeded yet.
My system is IBM ThinkPad R40 with a Cisco Aironet mini-PCI
802.11b card, SuSE 8.2, Linux 2.6.10.

Michal
