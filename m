Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUIMRMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUIMRMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIMRMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:12:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15009 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267815AbUIMRM1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:12:27 -0400
Message-ID: <4145D4ED.6070403@pobox.com>
Date: Mon, 13 Sep 2004 13:12:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
References: <20040913165551.GA24135@gemtek.lt>
In-Reply-To: <20040913165551.GA24135@gemtek.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas wrote:
> [1.] One line summary of the problem: 
>  Applied patch-2.6.9.bz2 on top of linux 2.6.8 tree, reboot - 
>  then suddenly laptop frozes.
>  
> [2.] Full description of the problem/report:
>  It is the same .config used to compile 2.6.9 rc1 and 2.6.9 rc2 
>  (http://www.gemtek.lt/~zilvinas/oops/ for kern.log and .config).
>  Laptop booted as usual, logged in KDE and started up evolution -
>  mouse froze, keyboard seemed dead - although sysrq-s, sysrq-u & 
>  sysrq-b worked just fine. After reboot I found a lot of messages
>  repeated like :
> 
> Sep 13 18:51:24 evo800 kernel: Warning: kfree_skb on hard IRQ 000000d8
> Sep 13 18:51:24 evo800 kernel: bad: scheduling while atomic!
> Sep 13 18:51:24 evo800 kernel:  [schedule+1208/1213] schedule+0x4b8/0x4bd
> Sep 13 18:51:24 evo800 kernel:  [sys_time+22/80] sys_time+0x16/0x50
> Sep 13 18:51:24 evo800 kernel:  [work_resched+5/22] work_resched+0x5/0x16
> 
> or 
> 
> Sep 13 18:51:24 evo800 kernel: Warning: kfree_skb on hard IRQ 000000d8
> Sep 13 18:51:24 evo800 kernel: bad: scheduling while atomic!
> Sep 13 18:51:24 evo800 kernel:  [schedule+1208/1213] schedule+0x4b8/0x4bd
> Sep 13 18:51:24 evo800 kernel:  [schedule_timeout+96/179] schedule_timeout+0x60/0xb3
> Sep 13 18:51:24 evo800 kernel:  [__get_free_pages+31/59] __get_free_pages+0x1f/0x3b
> Sep 13 18:51:24 evo800 kernel:  [process_timeout+0/5] process_timeout+0x0/0x5
> Sep 13 18:51:24 evo800 kernel:  [do_select+394/698] do_select+0x18a/0x2ba
> Sep 13 18:51:24 evo800 kernel:  [__pollwait+0/192] __pollwait+0x0/0xc0
> Sep 13 18:51:24 evo800 kernel:  [print_context_stack+35/93] print_context_stack+0x23/0x5d
> Sep 13 18:51:24 evo800 kernel:  [sys_select+670/1176] sys_select+0x29e/0x498
> Sep 13 18:51:24 evo800 kernel:  [sys_time+22/80] sys_time+0x16/0x50
> Sep 13 18:51:24 evo800 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>  
> 
> [3.] Keywords (i.e., modules, networking, kernel):
>  Modules Loaded         nfs esp4 nfsd exportfs lockd sunrpc nsc_ircc
>  ipt_state iptable_filter iptable_nat crypto_null microcode ehci_hcd
>  ohci_hcd floppy irtty_sir sir_dev irda crc_ccitt 8250_pnp khazad
>  twofish sha512 sha256 sha1 serpent md5 md4 des deflate zlib_deflate
>  zlib_inflate cast6 cast5 blowfish arc4 aes_i586 xfrm_user
>  ip_conntrack_irc ip_conntrack_ftp ip_conntrack ip_tables ide_cd cdrom
>  8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss
>  snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
>  snd_seq_device snd soundcore yenta_socket radeon intel_agp agpgart

I'm totally blind, because I don't see your network driver in that big 
list of modules.

Your network driver should probably be doing dev_kfree_skb_any() 
somewhere, but isn't.

	Jeff



