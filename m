Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTCFJYF>; Thu, 6 Mar 2003 04:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267934AbTCFJYF>; Thu, 6 Mar 2003 04:24:05 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:44811 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S267368AbTCFJX7>; Thu, 6 Mar 2003 04:23:59 -0500
Subject: Re: [2.4.21-pre5-ac1] Oops and crash
From: Henning Schmiedehausen <hps@intermeta.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1046864514.7605.14.camel@forge.intermeta.de>
References: <1046864514.7605.14.camel@forge.intermeta.de>
Content-Type: multipart/mixed; boundary="=-mTMffauh0pWgGlQgiqUw"
Organization: INTERMETA - Gesellschaft =?ISO-8859-1?Q?f=C3=BCr?= Mehrwertdienste mbH
Message-Id: <1046943259.15620.19.camel@forge.intermeta.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 10:34:19 +0100
X-Spam-Score: -33 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,QUOTE_TWICE_1,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_XIMIAN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mTMffauh0pWgGlQgiqUw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-03-05 at 12:41, Henning Schmiedehausen wrote:
> Hi,
> 
> serial console is my friend. :-) Freshly captured oops from tonight, box
> was frozen after that.

and another oops from tonight. Same configuration, same kernel. This seems
to be TCP network related. I can push hundreds of megabytes over NFS / UDP
and have no problem. But when the nightly backup starts at which does heavy
CPU (gzip), network (well, streaming with 1 MBit/sec) and disk I/O (reading
the data to back up from the disk), the machine seems to freeze.

Am I really the only one seeing this? This might be ancient hardware but
it definitely isn't exotic. :-)

I'll go back to 2.4.18-26.7.x for now. 

> 
> Pentium Pro 200 - Natoma/Triton II Chipset, 192 MBytes RAM. Box is rock
> solid under RedHat 7.3 release and errata kernel.
> 
> Kernel Config and boot messages attached. This is a stock
> 2.4.21-pre5-ac1 kernel compiled for i686. At the crash time, it had
> the following modules loaded:
> 
> % lsmod
> Module                  Size  Used by    Not tainted
> parport_pc             17412   1 (autoclean)
> lp                      8416   0 (autoclean)
> parport                33440   1 (autoclean) [parport_pc lp]
> autofs                 11108   2 (autoclean)
> nfsd                   75584   8 (autoclean)
> lockd                  55424   1 (autoclean) [nfsd]
> sunrpc                 75540   1 (autoclean) [nfsd lockd]
> 3c59x                  28264   1
> ext3                   65088   7
> jbd                    46252   7 [ext3]
> 
> and the following PCI devices are installed
> 
> % lspci -vvt
> -[00]-+-00.0  Intel Corp. 440FX - 82441FX PMC [Natoma]
>       +-07.0  Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II]
>       +-07.1  Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
>       +-0c.0  3Com Corporation 3c900 Combo [Boomerang]
>       \-0e.0  ATI Technologies Inc 215CT [Mach64 CT]

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

--=-mTMffauh0pWgGlQgiqUw
Content-Disposition: attachment; filename=oops3
Content-Type: text/plain; name=oops3; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.4 on i686 2.4.21-pre5-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre5-ac1/ (default)
     -m /boot/System.map-2.4.21-pre5-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/jbd.o for module jbd has changed since load
Unable to handle kernel paging request at virtual address ec11bee8
c012f1be
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012f1be>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: cabc1a40   ebx: c12155d0   ecx: c12155d0   edx: 00000800
esi: 00000246   edi: cabc1a40   ebp: cabc1d00   esp: c07bfd50
ds: 0018   es: 0018   ss: 0018
Process gzip (pid: 3787, stackpage=c07bf000)
Stack: 00000018 00000018 ffffff0b c0211a44 cafc3200 000001f0 00000568 c82c5b9c 
       c01c482c 000006bc 000001f0 cbb614e0 00000000 c01e21b2 00000680 000001f0 
       00000000 00000058 00000016 00000046 00000001 c016fe76 c13ef2e0 00000000 
Call Trace:    [<c0211a44>] [<c01c482c>] [<c01e21b2>] [<c016fe76>] [<c01a1f14>]
  [<c01a7710>] [<c01daab2>] [<c0116b58>] [<c01dae65>] [<c01a7bc7>] [<c01fd1f5>]
  [<c01c18af>] [<cc870344>] [<c016fda1>] [<c01c1ac7>] [<c0120d16>] [<c0137306>]
  [<c011d8cb>] [<c011d7d4>] [<c011d5fb>] [<c0109dec>] [<c010883b>]
Code: 8b 44 81 18 0f af fa 89 41 14 01 ef 40 75 23 8b 41 04 8b 11 

>>EIP; c012f1be <kmalloc+ae/120>   <=====
Trace; c0211a44 <csum_partial_copy_generic+a4/100>
Trace; c01c482c <alloc_skb+dc/1a0>
Trace; c01e21b2 <tcp_sendmsg+212/1170>
Trace; c016fe76 <add_blkdev_randomness+46/50>
Trace; c01a1f14 <ide_intr+e4/100>
Trace; c01a7710 <ide_dma_intr+0/b0>
Trace; c01daab2 <ip_local_deliver+f2/180>
Trace; c0116b58 <__wake_up+38/60>
Trace; c01dae65 <ip_rcv+325/3a0>
Trace; c01a7bc7 <ide_build_dmatable+67/1b0>
Trace; c01fd1f5 <inet_sendmsg+35/40>
Trace; c01c18af <sock_sendmsg+6f/90>
Trace; cc870344 <[3c59x]boomerang_rx+2a4/450>
Trace; c016fda1 <add_timer_randomness+d1/e0>
Trace; c01c1ac7 <sock_write+a7/c0>
Trace; c0120d16 <update_wall_time+16/50>
Trace; c0137306 <sys_write+96/f0>
Trace; c011d8cb <bh_action+1b/50>
Trace; c011d7d4 <tasklet_hi_action+44/70>
Trace; c011d5fb <do_softirq+4b/90>
Trace; c0109dec <do_IRQ+9c/b0>
Trace; c010883b <system_call+33/38>
Code;  c012f1be <kmalloc+ae/120>
00000000 <_EIP>:
Code;  c012f1be <kmalloc+ae/120>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012f1c2 <kmalloc+b2/120>
   4:   0f af fa                  imul   %edx,%edi
Code;  c012f1c5 <kmalloc+b5/120>
   7:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012f1c8 <kmalloc+b8/120>
   a:   01 ef                     add    %ebp,%edi
Code;  c012f1ca <kmalloc+ba/120>
   c:   40                        inc    %eax
Code;  c012f1cb <kmalloc+bb/120>
   d:   75 23                     jne    32 <_EIP+0x32> c012f1f0 <kmalloc+e0/120>
Code;  c012f1cd <kmalloc+bd/120>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012f1d0 <kmalloc+c0/120>
  12:   8b 11                     mov    (%ecx),%edx

 <1>Unable to handle kernel paging request at virtual address ec11bee8
c012f1be
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012f1be>]    Not tainted
EFLAGS: 00010087
eax: cabc1a40   ebx: c12155d0   ecx: c12155d0   edx: 00000800
esi: 00000246   edi: cabc1a40   ebp: cabc1d00   esp: c0717d50
ds: 0018   es: 0018   ss: 0018
Process sed (pid: 3792, stackpage=c0717000)
Stack: c0663cc0 c82c51dc c82c51dc c01ec6d8 cbb613a0 000001f0 ffffffe0 c82c51dc 
       c01c482c 000006bc 000001f0 c82c5118 c0717f30 c01e21b2 00000680 000001f0 
       00000082 c8f3d620 00000046 c016fda1 00000615 fc4c8917 0000000b 00000000 
Call Trace:    [<c01ec6d8>] [<c01c482c>] [<c01e21b2>] [<c016fda1>] [<c0116b58>]
  [<c016fda1>] [<c0116b58>] [<c016fda1>] [<c016fe76>] [<c01a2e2b>] [<c01a7781>]
  [<c01fd1f5>] [<c01c18af>] [<c010734b>] [<c0116af7>] [<c01c1ac7>] [<c0137306>]
  [<c0109c3a>] [<c0109db8>] [<c0109ddc>] [<c010883b>]
Code: 8b 44 81 18 0f af fa 89 41 14 01 ef 40 75 23 8b 41 04 8b 11 

>>EIP; c012f1be <kmalloc+ae/120>   <=====
Trace; c01ec6d8 <tcp_push_one+78/100>
Trace; c01c482c <alloc_skb+dc/1a0>
Trace; c01e21b2 <tcp_sendmsg+212/1170>
Trace; c016fda1 <add_timer_randomness+d1/e0>
Trace; c0116b58 <__wake_up+38/60>
Trace; c016fda1 <add_timer_randomness+d1/e0>
Trace; c0116b58 <__wake_up+38/60>
Trace; c016fda1 <add_timer_randomness+d1/e0>
Trace; c016fe76 <add_blkdev_randomness+46/50>
Trace; c01a2e2b <idedisk_end_request+bb/d0>
Trace; c01a7781 <ide_dma_intr+71/b0>
Trace; c01fd1f5 <inet_sendmsg+35/40>
Trace; c01c18af <sock_sendmsg+6f/90>
Trace; c010734b <__switch_to+2b/100>
Trace; c0116af7 <schedule+217/240>
Trace; c01c1ac7 <sock_write+a7/c0>
Trace; c0137306 <sys_write+96/f0>
Trace; c0109c3a <handle_IRQ_event+3a/70>
Trace; c0109db8 <do_IRQ+68/b0>
Trace; c0109ddc <do_IRQ+8c/b0>
Trace; c010883b <system_call+33/38>
Code;  c012f1be <kmalloc+ae/120>
00000000 <_EIP>:
Code;  c012f1be <kmalloc+ae/120>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012f1c2 <kmalloc+b2/120>
   4:   0f af fa                  imul   %edx,%edi
Code;  c012f1c5 <kmalloc+b5/120>
   7:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012f1c8 <kmalloc+b8/120>
   a:   01 ef                     add    %ebp,%edi
Code;  c012f1ca <kmalloc+ba/120>
   c:   40                        inc    %eax
Code;  c012f1cb <kmalloc+bb/120>
   d:   75 23                     jne    32 <_EIP+0x32> c012f1f0 <kmalloc+e0/120>
Code;  c012f1cd <kmalloc+bd/120>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012f1d0 <kmalloc+c0/120>
  12:   8b 11                     mov    (%ecx),%edx

 <1>Unable to handle kernel paging request at virtual address ec11bee8
c012f1be
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012f1be>]    Not tainted
EFLAGS: 00010083
eax: cabc1a40   ebx: c12155d0   ecx: c12155d0   edx: 00000800
esi: 00000246   edi: cabc1a40   ebp: cabc1d00   esp: c081dd50
ds: 0018   es: 0018   ss: 0018
Process sendbackup (pid: 3785, stackpage=c081d000)
Stack: 00000000 00000000 c9f02ea0 c081ddb4 c0663860 000001f0 ffffffe0 c82c56bc 
       c01c482c 000006bc 000001f0 c82c55f8 c081df30 c01e21b2 00000680 000001f0 
       0001803b c0138cd8 cbb2cb00 00000305 c0138ce9 c135e000 00000000 cbb2cb00 
Call Trace:    [<c01c482c>] [<c01e21b2>] [<c0138cd8>] [<c0138ce9>] [<cc80dc19>]
  [<cc80dc78>] [<cc81fff1>] [<cc820143>] [<cc81ff84>] [<cc81ff95>] [<cc80e571>]
  [<c01fd1f5>] [<c01c18af>] [<c01c1ac7>] [<c0137306>] [<c0109c3a>] [<c011cf2b>]
  [<c010883b>]
Code: 8b 44 81 18 0f af fa 89 41 14 01 ef 40 75 23 8b 41 04 8b 11 

>>EIP; c012f1be <kmalloc+ae/120>   <=====
Trace; c01c482c <alloc_skb+dc/1a0>
Trace; c01e21b2 <tcp_sendmsg+212/1170>
Trace; c0138cd8 <getblk+28/60>
Trace; c0138ce9 <getblk+39/60>
Trace; cc80dc19 <[jbd]do_get_write_access+469/490>
Trace; cc80dc78 <[jbd]journal_get_write_access+38/50>
Trace; cc81fff1 <[ext3]ext3_reserve_inode_write+31/b0>
Trace; cc820143 <[ext3]ext3_dirty_inode+93/d0>
Trace; cc81ff84 <[ext3]ext3_mark_iloc_dirty+24/60>
Trace; cc81ff95 <[ext3]ext3_mark_iloc_dirty+35/60>
Trace; cc80e571 <[jbd]journal_stop+1b1/1c0>
Trace; c01fd1f5 <inet_sendmsg+35/40>
Trace; c01c18af <sock_sendmsg+6f/90>
Trace; c01c1ac7 <sock_write+a7/c0>
Trace; c0137306 <sys_write+96/f0>
Trace; c0109c3a <handle_IRQ_event+3a/70>
Trace; c011cf2b <sys_gettimeofday+1b/90>
Trace; c010883b <system_call+33/38>
Code;  c012f1be <kmalloc+ae/120>
00000000 <_EIP>:
Code;  c012f1be <kmalloc+ae/120>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012f1c2 <kmalloc+b2/120>
   4:   0f af fa                  imul   %edx,%edi
Code;  c012f1c5 <kmalloc+b5/120>
   7:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012f1c8 <kmalloc+b8/120>
   a:   01 ef                     add    %ebp,%edi
Code;  c012f1ca <kmalloc+ba/120>
   c:   40                        inc    %eax
Code;  c012f1cb <kmalloc+bb/120>
   d:   75 23                     jne    32 <_EIP+0x32> c012f1f0 <kmalloc+e0/120>
Code;  c012f1cd <kmalloc+bd/120>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012f1d0 <kmalloc+c0/120>
  12:   8b 11                     mov    (%ecx),%edx

 <1>Unable to handle kernel paging request at virtual address ec11bee8
c012f1be
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012f1be>]    Not tainted
EFLAGS: 00010087
eax: cabc1a40   ebx: c12155d0   ecx: c12155d0   edx: 00000800
esi: 00000246   edi: cabc1a40   ebp: cabc1d00   esp: c028de84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c028d000)
Stack: c019a74b c01a820b 00000001 cbb61760 cba6b760 00000020 cbe7b400 00000109 
       c01c482c 0000065c 00000020 0000008c cbe7b400 cc8703d6 00000620 00000020 
       0000001f 00000000 00009400 0000001f cbe7b560 00000001 00000096 cb266000 
Call Trace:    [<c019a74b>] [<c01a820b>] [<c01c482c>] [<cc8703d6>] [<c011644b>]
  [<c01ef5bb>] [<cc86fabf>] [<c012124d>] [<c0109c3a>] [<c0109db8>] [<c0106de0>]
  [<c0105000>] [<c010c1c8>] [<c0106de0>] [<c0106de0>] [<c0105000>] [<c0106e03>]
  [<c0106e54>]
Code: 8b 44 81 18 0f af fa 89 41 14 01 ef 40 75 23 8b 41 04 8b 11 

>>EIP; c012f1be <kmalloc+ae/120>   <=====
Trace; c019a74b <ide_execute_command+6b/80>
Trace; c01a820b <__ide_dma_begin+2b/40>
Trace; c01c482c <alloc_skb+dc/1a0>
Trace; cc8703d6 <[3c59x]boomerang_rx+336/450>
Trace; c011644b <wake_up_process+b/10>
Trace; c01ef5bb <tcp_write_timer+2b/e0>
Trace; cc86fabf <[3c59x]boomerang_interrupt+12f/3a0>
Trace; c012124d <do_timer+3d/70>
Trace; c0109c3a <handle_IRQ_event+3a/70>
Trace; c0109db8 <do_IRQ+68/b0>
Trace; c0106de0 <default_idle+0/30>
Trace; c0105000 <_stext+0/0>
Trace; c010c1c8 <call_do_IRQ+5/d>
Trace; c0106de0 <default_idle+0/30>
Trace; c0106de0 <default_idle+0/30>
Trace; c0105000 <_stext+0/0>
Trace; c0106e03 <default_idle+23/30>
Trace; c0106e54 <cpu_idle+24/30>
Code;  c012f1be <kmalloc+ae/120>
00000000 <_EIP>:
Code;  c012f1be <kmalloc+ae/120>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012f1c2 <kmalloc+b2/120>
   4:   0f af fa                  imul   %edx,%edi
Code;  c012f1c5 <kmalloc+b5/120>
   7:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012f1c8 <kmalloc+b8/120>
   a:   01 ef                     add    %ebp,%edi
Code;  c012f1ca <kmalloc+ba/120>
   c:   40                        inc    %eax
Code;  c012f1cb <kmalloc+bb/120>
   d:   75 23                     jne    32 <_EIP+0x32> c012f1f0 <kmalloc+e0/120>
Code;  c012f1cd <kmalloc+bd/120>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012f1d0 <kmalloc+c0/120>
  12:   8b 11                     mov    (%ecx),%edx

 <0>Kernel panic: Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.

--=-mTMffauh0pWgGlQgiqUw--

