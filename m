Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVHGN0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVHGN0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 09:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVHGN0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 09:26:12 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:49946 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S1751098AbVHGN0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 09:26:12 -0400
Message-ID: <42F60BE3.6040301@home.se>
Date: Sun, 07 Aug 2005 15:25:55 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
References: <42F38B67.5040308@home.se> <20050805.093208.74729918.davem@davemloft.net> <20050806022435.GB12862@gondor.apana.org.au> <20050806075717.GA18104@gondor.apana.org.au>
In-Reply-To: <20050806075717.GA18104@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone asked if I could try to trigger this assertion again, and I'm 
afraid I probably cannot, I didnt do anything special at the time. But 
I've got something even better for you all, got a BUG from something 
tcp-related. Mind you, I am trying to find a possibly hardware-related 
issue here, so if this bug does not make any sense it might be my hardware!

I would actually want to know it if this is likely hardware-related or 
not, since I have no idea if its RAM, CPU, motherboard or "only" a disk 
that is broken. I know _something_ is broken, due to lockups, and seeing 
a faulty disk indicated in a HDD diag, but only once, the disk is 
apparently fine 99% of the time.

---
John Bäckstrand


[148475.651000] ------------[ cut here ]------------
[148475.651050] kernel BUG at net/ipv4/tcp_output.c:918!
[148475.651078] invalid operand: 0000 [#1]
[148475.651103] Modules linked in: sha256 aes_i586 dm_crypt ipt_state 
ipt_multiport ipt_MASQUERADE iptable_filter netconsole md5 ipv6 
af_packet pdc202xx_new e1000 8139cp de2104x i2c_viapro via686a 
i2c_sensor i2c_core uhci_hcd usbcore 3c59x 8139too mii de4x5 crc32 
parport_pc parport reiserfs dm_mod ip_nat_ftp iptable_nat ip_tables 
ip_conntrack_ftp ip_conntrack rtc unix
[148475.651378] CPU:    0
[148475.651380] EIP:    0060:[<c0286619>]    Not tainted VLI
[148475.651383] EFLAGS: 00010287   (2.6.13-rc5sand4)
[148475.651464] EIP is at tcp_tso_should_defer+0xc9/0xe0
[148475.651494] eax: 0000002b   ebx: ce49a660   ecx: 0000002c   edx: 
ca008d00
[148475.651526] esi: 0000002c   edi: 0000000e   ebp: 99d57104   esp: 
c0865dec
[148475.651556] ds: 007b   es: 007b   ss: 0068
[148475.651582] Process tor (pid: 10849, threadinfo=c0864000 task=c6234530)
[148475.651602] Stack: ce49a660 0000002c ca008d00 99d57104 c02866fc 
ca008d00 ca008d00 ce49a660
[148475.651676]        0000003a 00000102 0000000e 00000001 ca008d00 
ca008d00 ca008d00 c9290034
[148475.651751]        c0286a49 ca008d00 000005b4 00000001 c0254674 
81dd5b2f 81dd5b2f 00000010
[148475.651823] Call Trace:
[148475.651869]  [<c02866fc>] tcp_write_xmit+0xcc/0x3e0
[148475.651910]  [<c0286a49>] __tcp_push_pending_frames+0x39/0xd0
[148475.651947]  [<c0254674>] kfree_skbmem+0x24/0x30
[148475.651988]  [<c0283bbe>] tcp_rcv_established+0x26e/0x840
[148475.652033]  [<c028c935>] tcp_v4_do_rcv+0x115/0x120
[148475.652072]  [<c028cf8f>] tcp_v4_rcv+0x64f/0x890
[148475.652106]  [<c02735b0>] ip_local_deliver_finish+0x0/0x1c0
[148475.652150]  [<c0265a6e>] nf_hook_slow+0x6e/0x100
[148475.652199]  [<c0272f63>] ip_local_deliver+0xe3/0x250
[148475.652234]  [<c02735b0>] ip_local_deliver_finish+0x0/0x1c0
[148475.652272]  [<c0273425>] ip_rcv+0x355/0x4e0
[148475.652309]  [<c0273770>] ip_rcv_finish+0x0/0x290
[148475.652347]  [<c0259f11>] netif_receive_skb+0x1f1/0x270
[148475.652394]  [<c025a00f>] process_backlog+0x7f/0x100
[148475.652431]  [<c025a10a>] net_rx_action+0x7a/0x120
[148475.652467]  [<c011b9bd>] __do_softirq+0x7d/0x90
[148475.652509]  [<c011b9f6>] do_softirq+0x26/0x30
[148475.652544]  [<c010561e>] do_IRQ+0x1e/0x30
[148475.652588]  [<c0103a92>] common_interrupt+0x1a/0x20
[148475.652630] Code: db 74 1d 89 f8 0f af c2 39 f0 0f 46 f0 31 d2 89 f0 
f7 f3 31 d2 39 c1 73 cb ba 01 00 00 00 eb c4 6b c2 03 31 d2 39 c1 77 bb 
eb ee <0f> 0b 96 03 20 2f 2e c0 eb 83 8b ba 7c 02 00 00 eb ee 90 8d 74
[148475.653330]  <0>Kernel panic - not syncing: Fatal exception in interrupt




