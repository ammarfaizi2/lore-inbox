Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVL1O3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVL1O3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVL1O3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:29:12 -0500
Received: from main.gmane.org ([80.91.229.2]:59291 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964820AbVL1O3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:29:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: oops in kernel 2.6.15-rc6
Date: Wed, 28 Dec 2005 23:28:50 +0900
Message-ID: <43B2A122.7030203@thinrope.net>
References: <20051228135021.GA9777@sidney>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <20051228135021.GA9777@sidney>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Klein wrote:
> Hello all,
> 
> [please CC me on replies, I'm not subscribed to this list]
> 
> I had this following kernel oops while compiling a new kernel. 
> 
> Dec 27 19:02:00 sidney kernel: [14896.995613] Unable to handle kernel paging request at virtual address 76f7104d
> Dec 27 19:02:00 sidney kernel: [14896.995665]  printing eip:
> Dec 27 19:02:00 sidney kernel: [14896.995682] c013a392
> Dec 27 19:02:00 sidney kernel: [14896.995692] *pde = 00000000
> Dec 27 19:02:00 sidney kernel: [14896.995711] Oops: 0002 [#1]

I might be wrong, but that is the second oops for this run, probably the first [#0] is more
interesting...

> Dec 27 19:02:00 sidney kernel: [14896.995726] PREEMPT 
> Dec 27 19:02:00 sidney kernel: [14896.995744] Modules linked in: md5 ipv6 lp capi capifs kernelcapi nls_iso8859_15 nls_cp437 vfat fat parport_pc parport joydev evdev tuner tvaudio msp3400 bttv video_buf firmware_class v4l2_common btcx_risc tveeprom videodev snd_bt87x snd_ens1370 gameport nvidiafb snd_rawmidi snd_seq_device snd_pcm snd_timer snd_page_alloc snd_ak4531_codec rivafb uhci_hcd ide_cd snd 8139too mii i2c_viapro usbcore cdrom soundcore crc32
> Dec 27 19:02:00 sidney kernel: [14896.996038] CPU:    0
> Dec 27 19:02:00 sidney kernel: [14896.996044] EIP:    0060:[shrink_slab+95/315]    Not tainted VLI
> Dec 27 19:02:00 sidney kernel: [14896.996053] EFLAGS: 00010246   (2.6.15-rc6.sidney.10) 
> Dec 27 19:02:00 sidney kernel: [14896.996117] EIP is at shrink_slab+0x5f/0x13b
> Dec 27 19:02:00 sidney kernel: [14896.996141] eax: c1154900   ebx: 00000000   ecx: 00006830   edx: 00000000
> Dec 27 19:02:00 sidney kernel: [14896.996172] esi: 700f0b05   edi: 0000002b   ebp: c125df3f   esp: c125df1c
> Dec 27 19:02:00 sidney kernel: [14896.996200] ds: 007b   es: 007b   ss: 0068
> Dec 27 19:02:00 sidney kernel: [14896.996224] Process kswapd0 (pid: 51, threadinfo=c125c000 task=c1256580)
> Dec 27 19:02:00 sidney kernel: [14896.996248] Stack: 000000d0 0002a300 00000000 0002a300 00000080 00000000 c029f100 c029f100 
> Dec 27 19:02:00 sidney kernel: [14896.996339]        0000000c c125dfac c013b53d 00000000 000000d0 0000682f c029f100 c125df78 
> Dec 27 19:02:00 sidney kernel: [14896.996426]        00000001 00000000 00000000 c125dfd4 00000002 0000682f 00000000 00000020 
> Dec 27 19:02:00 sidney kernel: [14896.996512] Call Trace:
> Dec 27 19:02:00 sidney kernel: [14896.996550]  [show_stack+120/131] show_stack+0x78/0x83
> Dec 27 19:02:00 sidney kernel: [14896.996600]  [show_registers+306/415] show_registers+0x132/0x19f
> Dec 27 19:02:00 sidney kernel: [14896.996646]  [die+202/332] die+0xca/0x14c
> Dec 27 19:02:00 sidney kernel: [14896.996687]  [do_page_fault+910/1211] do_page_fault+0x38e/0x4bb
> Dec 27 19:02:00 sidney kernel: [14896.996748]  [error_code+79/96] error_code+0x4f/0x60
> Dec 27 19:02:00 sidney kernel: [14896.996791]  [phys_startup_32+329596353/-1073741824] 0x13b53dc1
> Dec 27 19:02:00 sidney kernel: [14896.996834] Code: 00 00 00 8b 35 f4 f8 29 c0 c1 e1 02 89 4d ec 83 ee 04 c7 45 f0 00 00 00 00 e9 ba 00 00 00 ff 75 0c 6a 00 ff 16 89 c7 8b 45 ec 31 <d2> 8b 4d 10 f7 76 0c 41 f7 e7 89 45 e0 89 55 e4 89 d3 89 45 e8 
> 
> please let me know if you need more informations/how I can help you solve
> this problem.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

