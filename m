Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSFLU0v>; Wed, 12 Jun 2002 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSFLU0u>; Wed, 12 Jun 2002 16:26:50 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:38849 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316786AbSFLU0r> convert rfc822-to-8bit; Wed, 12 Jun 2002 16:26:47 -0400
Date: Wed, 12 Jun 2002 22:26:35 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: linux-kernel@vger.kernel.org
Subject: [BUG] in page_alloc.c in 2.4.19-pre10aa2
Message-ID: <Pine.LNX.4.44.0206122202110.11557-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some hours under heavy load (=3) I got the following messages in my
logs, here run trough ksymoops. At this time there were running gimp with
xsane, gimp-print and setiathome, which I had forgotten to stop. There
was about 60 MB in swap without much change, swapspace is about 1GB,
memory 512 MB. I am running Debian woody on an Athlon 700. The bug is not
easy reproducable. I have been running 2.4.19-pre10aa2 for several days
without ever seeing it. The real funny thing is: When I stopped X and
tried to reboot, the same thing happened, this time with syslog. Besides
the aa-patches there were no other patches in the kernel but only the
Nvidia-driver, which does not seem to be involved, however.

ksymoops 2.4.5 on i686 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at page_alloc.c:95!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01331e5>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c13e58f0   ecx: c026e620   edx: c026e5a0
esi: c13e58f0   edi: 00000000   ebp: dffd5f18   esp: dffd5eec
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=dffd5000)
Stack: 00000001 c13e58f0 000001d0 dffd5f10 c013b588 c1153704 00000000
c13e58f0
       00000000 c13e58f0 00000004 dffd5f50 c0132743 dffd4000 00000c4e
00004a0e
       000001d0 c026e6ec c10c01ec 00000001 00000000 c10c01dc 00000020
000001d0
Call Trace: [<c013b588>] [<c0132743>] [<c0132be0>] [<c0132c60>]
[<c0132da6>]
   [<c0132e36>] [<c0132f7d>] [<c0108b58>] [<c0132ee0>] [<c0105000>]
[<c0107316>]
   [<c0132ee0>]
Code: 0f 0b 5f 00 93 99 23 c0 89 d8 2b 05 b0 75 2d c0 c1 f8 02 69


>>EIP; c01331e5 <__free_pages_ok+45/2c0>   <=====

>>ebx; c13e58f0 <_end+10e7e54/1870564>
>>ecx; c026e620 <contig_page_data+0/3a0>
>>edx; c026e5a0 <swapper_space+0/40>
>>esi; c13e58f0 <_end+10e7e54/1870564>
>>ebp; dffd5f18 <END_OF_CODE+82e4939/????>
>>esp; dffd5eec <END_OF_CODE+82e490d/????>

Trace; c013b588 <try_to_release_page+28/60>
Trace; c0132743 <shrink_cache+163/3f0>
Trace; c0132be0 <shrink_caches+30/40>
Trace; c0132c60 <try_to_free_pages+70/100>
Trace; c0132da6 <kswapd_balance_pgdat+56/c0>
Trace; c0132e36 <kswapd_balance+26/40>
Trace; c0132f7d <kswapd+9d/c0>
Trace; c0108b58 <ret_from_fork+0/18>
Trace; c0132ee0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107316 <kernel_thread+26/40>
Trace; c0132ee0 <kswapd+0/c0>

Code;  c01331e5 <__free_pages_ok+45/2c0>
00000000 <_EIP>:
Code;  c01331e5 <__free_pages_ok+45/2c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01331e7 <__free_pages_ok+47/2c0>
   2:   5f                        pop    %edi
Code;  c01331e8 <__free_pages_ok+48/2c0>
   3:   00 93 99 23 c0 89         add    %dl,0x89c02399(%ebx)
Code;  c01331ee <__free_pages_ok+4e/2c0>
   9:   d8 2b                     fsubrs (%ebx)
Code;  c01331f0 <__free_pages_ok+50/2c0>
   b:   05 b0 75 2d c0            add    $0xc02d75b0,%eax
Code;  c01331f5 <__free_pages_ok+55/2c0>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c01331f8 <__free_pages_ok+58/2c0>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

 kernel BUG at page_alloc.c:95!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01331e5>]    Tainted: P
EFLAGS: 00010286
eax: 00000000   ebx: c13e5370   ecx: c026e620   edx: c026e5a0
esi: c13e5370   edi: 00000000   ebp: cd943d50   esp: cd943d24
ds: 0018   es: 0018   ss: 0018
Process xsane (pid: 3791, stackpage=cd943000)
Stack: 00000001 c13e5370 00000000 d7820004 d7824394 c0130ee2 00000000
c13e5370
       00000000 c13e5370 00000020 cd943d88 c0132743 cd942000 00000c80
00004aab
       000001d2 c026e6ec c10c0060 00000001 00000000 c10c0050 00000020
000001d2
Call Trace: [<c0130ee2>] [<c0132743>] [<c0132be0>] [<c0132c60>]
[<c01336dc>]
   [<c01339cc>] [<c0128de0>] [<d7cbd991>] [<c012901a>] [<c010a1cc>]
[<c01290ef>]
   [<c0131dd6>] [<c0116905>] [<c012c1ca>] [<c012c050>] [<c01392f5>]
[<c0138fb0>]
   [<c0139241>] [<c0116560>] [<c0108c94>]
Code: 0f 0b 5f 00 93 99 23 c0 89 d8 2b 05 b0 75 2d c0 c1 f8 02 69


>>EIP; c01331e5 <__free_pages_ok+45/2c0>   <=====

>>ebx; c13e5370 <_end+10e78d4/1870564>
>>ecx; c026e620 <contig_page_data+0/3a0>
>>edx; c026e5a0 <swapper_space+0/40>
>>esi; c13e5370 <_end+10e78d4/1870564>
>>ebp; cd943d50 <[bsd_comp].data.end+a163e31/144200e1>
>>esp; cd943d24 <[bsd_comp].data.end+a163e05/144200e1>

Trace; c0130ee2 <kmem_cache_alloc+172/1b0>
Trace; c0132743 <shrink_cache+163/3f0>
Trace; c0132be0 <shrink_caches+30/40>
Trace; c0132c60 <try_to_free_pages+70/100>
Trace; c01336dc <balance_classzone+4c/1f0>
Trace; c01339cc <__alloc_pages+14c/270>
Trace; c0128de0 <do_anonymous_page+50/110>
Trace; d7cbd991 <[NVdriver]__nvsym02890+44d/490>
Trace; c012901a <do_no_page+17a/180>
Trace; c010a1cc <do_IRQ+8c/d0>
Trace; c01290ef <handle_mm_fault+cf/e0>
Trace; c0131dd6 <activate_page+86/a0>
Trace; c0116905 <do_page_fault+3a5/640>
Trace; c012c1ca <generic_file_read+10a/130>
Trace; c012c050 <file_read_actor+0/70>
Trace; c01392f5 <sys_read+95/f0>
Trace; c0138fb0 <generic_file_llseek+0/b0>
Trace; c0139241 <sys_llseek+b1/d0>
Trace; c0116560 <do_page_fault+0/640>
Trace; c0108c94 <error_code+34/3c>

Code;  c01331e5 <__free_pages_ok+45/2c0>
00000000 <_EIP>:
Code;  c01331e5 <__free_pages_ok+45/2c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01331e7 <__free_pages_ok+47/2c0>
   2:   5f                        pop    %edi
Code;  c01331e8 <__free_pages_ok+48/2c0>
   3:   00 93 99 23 c0 89         add    %dl,0x89c02399(%ebx)
Code;  c01331ee <__free_pages_ok+4e/2c0>
   9:   d8 2b                     fsubrs (%ebx)
Code;  c01331f0 <__free_pages_ok+50/2c0>
   b:   05 b0 75 2d c0            add    $0xc02d75b0,%eax
Code;  c01331f5 <__free_pages_ok+55/2c0>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c01331f8 <__free_pages_ok+58/2c0>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax


1 warning issued.  Results may not be reliable.


regards

Peter Bornemann

          .         .
          |\_-^^^-_/|
          / (|)_(|) \
         ( === X === )
          \  ._|_.  /
           ^-_   _-^
              °°°

