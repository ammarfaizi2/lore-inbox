Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbQLXDjl>; Sat, 23 Dec 2000 22:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQLXDjc>; Sat, 23 Dec 2000 22:39:32 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:56773 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130393AbQLXDjY>; Sat, 23 Dec 2000 22:39:24 -0500
Date: Sat, 23 Dec 2000 22:08:53 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: test13-pre4 ip defrag oops
Message-ID: <Pine.LNX.4.30.0012232205420.7311-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got an oops uner test13-pre4 when I tried to access a new nfs
export. Looks like the ip defrag monster doesn't want to go away =)

ksymoops 0.7c on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Oops: 0000
CPU:    0
EIP:    0010:[<c01f66de>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0001022s0246
eax: 20202037   ebx: d3a406c0   ecx: cf683024   edx: c734a2a0
esi: 00001720   edi: c880a180   ebp: 00001158   esp: d37fdcb4
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 514, stackpage=d37fd000)
Stack: c734a2a0 00000000 000026bc 0101a8c0 00000014 00000000 c01f6a73 c734a2a0
       c880a180 d2ce9360 c880a180 00000008 d37fddc0 11ac2800 20202037 d58d587f
       c880a180 d58d787c d37fddb0 00000003 d58d4aad c880a180 d58d787c d37fddb0
Call Trace: [<c01f6a73>] [<d58d587f>] [<d58d787c>] [<d58d4aad>] [<d58d787c>] [<c01f8e98>] [<c01f8e98>]
       [<c01f1737>] [<d58d34e0>] [<c01f8e84>] [<c01f14dc>] [<c01f8e84>] [<c01f8e84>] [<c01f1737>] [<c01f8e84>]
       [<d580787c>] [<c01f858f>] [<c01f8e84>] [<c020c1ac>] [<c0142c41>] [<c01f869e>] [<c020c1ac>] [<c0124075>]
       [<c020c605>] [<c020c1ac>] [<c0211436>] [<c01e7c55>] [<d58980a3>] [<d5898535>] [<d5899276>] [<d58bf8a0>]
       [<d5897cd9>] [<d58bf748>] [<d58b0369>] [<d58bf740>] [<c01074cc>]
Code: 8b 40 3c 8b 4c 24 1c 89 41 3c 27 47 18 00 00 00 00 8b 47 5c

>>EIP; c01f66de <ip_frag_queue+206/25c>   <=====
Trace; c01f6a73 <ip_defrag+b3/130>
Trace; d58d587f <END_OF_CODE+155d2b4f/????>
Trace; d58d787c <END_OF_CODE+155d4b4c/????>
Trace; d58d4aad <END_OF_CODE+155d1d7d/????>
Trace; d58d787c <END_OF_CODE+155d4b4c/????>
Trace; c01f8e98 <ip_finish_output2+0/bc>
Trace; c01f8e98 <ip_finish_output2+0/bc>
Trace; c01f1737 <nf_hook_slow+7f/100>
Trace; d58d34e0 <END_OF_CODE+155d07b0/????>
Trace; c01f8e84 <output_maybe_reroute+0/14>
Trace; c01f14dc <nf_iterate+30/8c>
Trace; c01f8e84 <output_maybe_reroute+0/14>
Trace; c01f8e84 <output_maybe_reroute+0/14>
Trace; c01f1737 <nf_hook_slow+7f/100>
Trace; c01f8e84 <output_maybe_reroute+0/14>
Trace; d580787c <END_OF_CODE+15504b4c/????>
Trace; c01f858f <ip_build_xmit_slow+3b7/478>
Trace; c01f8e84 <output_maybe_reroute+0/14>
Trace; c020c1ac <udp_getfrag+0/c4>
Trace; c0142c41 <iget4+45/cc>
Trace; c01f869e <ip_build_xmit+4e/2fc>
Trace; c020c1ac <udp_getfrag+0/c4>
Trace; c0124075 <add_to_page_cache_unique+f5/114>
Trace; c020c605 <udp_sendmsg+351/3cc>
Trace; c020c1ac <udp_getfrag+0/c4>
Trace; c0211436 <inet_sendmsg+3a/40>
Trace; c01e7c55 <sock_sendmsg+69/88>
Trace; d58980a3 <END_OF_CODE+15595373/????>
Trace; d5898535 <END_OF_CODE+15595805/????>
Trace; d5899276 <END_OF_CODE+15596546/????>
Trace; d58bf8a0 <END_OF_CODE+155bcb70/????>
Trace; d5897cd9 <END_OF_CODE+15594fa9/????>
Trace; d58bf748 <END_OF_CODE+155bca18/????>
Trace; d58b0369 <END_OF_CODE+155ad639/????>
Trace; d58bf740 <END_OF_CODE+155bca10/????>
Trace; c01074cc <kernel_thread+28/38>
Code;  c01f66de <ip_frag_queue+206/25c>
00000000 <_EIP>:
Code;  c01f66de <ip_frag_queue+206/25c>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c01f66e1 <ip_frag_queue+209/25c>
   3:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01f66e5 <ip_frag_queue+20d/25c>
   7:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c01f66e8 <ip_frag_queue+210/25c>
   a:   27                        daa
Code;  c01f66e9 <ip_frag_queue+211/25c>
   b:   47                        inc    %edi
Code;  c01f66ea <ip_frag_queue+212/25c>
   c:   18 00                     sbb    %al,(%eax)
Code;  c01f66ec <ip_frag_queue+214/25c>
   e:   00 00                     add    %al,(%eax)
Code;  c01f66ee <ip_frag_queue+216/25c>
  10:   00 8b 47 5c 00 00         add    %cl,0x5c47(%ebx)


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
