Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUKGNBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUKGNBP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUKGNBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:01:14 -0500
Received: from imap3.nextra.sk ([195.168.1.92]:31756 "EHLO tic.nextra.sk")
	by vger.kernel.org with ESMTP id S261605AbUKGNBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:01:11 -0500
Message-ID: <418E1CB4.2040805@rainbow-software.org>
Date: Sun, 07 Nov 2004 14:01:40 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?Rams=E9s_Rodr=EDguez_Mart=EDnez?=" <harpago@terra.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic while using netcat since linux-2.6.9
References: <20041106202600.GA1002@debbie>
In-Reply-To: <20041106202600.GA1002@debbie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramsés Rodríguez Martínez wrote:
> Hi,
> Sorry i don't include any dump, but it seems kernel-patch-lkcd for 2.6.9 is
> not available yet. I could handcopy the kernel-oops if you want. I think
> it'll be something related with bind() as it fails with "netcat".
> 
> The problem is only present with 2.6.9 (or at least not with 2.6.8 nor
> 2.6.5)
> 
> ------------------------
> SCRIPT TO REPRODUCE:
>   
> su
> apt-get install nc
> exit
> nc -p2000 127.0.0.1 2000        # kernel panic
> 
> ------------------------

It does the same thing for me. Here's the BUG output from serial console.


------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:277!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: 3c509 snd_sb16 snd_opl3_lib snd_hwdep snd_sb16_dsp 
snd_sb_common
CPU:    0
EIP:    0060:[<c02dd6da>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-pentium)
EIP is at tcp_transmit_skb+0x8ca/0x8e0
eax: c7fb72c0   ebx: c6424210   ecx: 00000020   edx: c727bf60
esi: c6424040   edi: c6424210   ebp: c727b920   esp: c4869dd4
ds: 007b   es: 007b   ss: 0068
Process nc (pid: 2263, threadinfo=c4869000 task=c64cb560)
Stack: ffffff60 c727b880 c727bf60 000000a0 00000246 c727bf60 c727b880 
00000020
        c727bf98 c6424178 c727bf60 c6424040 c6424210 c6424040 c6424040 
c727b920
        c02dc200 00000218 c7fb7478 c727b920 c6424040 c6424210 00000028 
c02dcb25
Call Trace:
  [<c02dc200>] tcp_rcv_synsent_state_process+0x500/0x550
  [<c02dcb25>] tcp_rcv_state_process+0x8d5/0x9d0
  [<c02e4161>] tcp_v4_do_rcv+0x71/0xf0
  [<c02b4ca7>] __release_sock+0x47/0x70
  [<c02b53bc>] release_sock+0x6c/0x70
  [<c02f11fb>] inet_wait_for_connect+0x7b/0xd0
  [<c0111870>] autoremove_wake_function+0x0/0x30
  [<c0111870>] autoremove_wake_function+0x0/0x30
  [<c02f12f3>] inet_stream_connect+0xa3/0x180
  [<c02b320c>] sys_connect+0x5c/0x80
  [<c02b3e79>] sock_setsockopt+0x99/0x510
  [<c02b1e7f>] sock_map_fd+0xff/0x140
  [<c011eabe>] do_sigaction+0x15e/0x1f0
  [<c01173bb>] do_setitimer+0x15b/0x1d0
  [<c02b3a61>] sys_socketcall+0x81/0x1a0
  [<c011e17a>] sys_rt_sigprocmask+0x7a/0xd0
  [<c0103d77>] syscall_call+0x7/0xb
Code: ff 7f e9 44 f8 ff ff 8a 87 2f 01 00 00 84 c0 0f 84 2c f8 ff ff 8b 
54 24 1c 25 ff 00 00 00 8d 54 c2 04 89 54 24 1c e9 16 f8 ff ff <0f> 0b 
15 01 9b e9 33 c0 e9 86
  <0>Kernel panic - not syncing: Fatal exception in interrupt


-- 
Ondrej Zary
