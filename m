Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRF0O20>; Wed, 27 Jun 2001 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRF0O2K>; Wed, 27 Jun 2001 10:28:10 -0400
Received: from p3EE0E52D.dip.t-dialin.net ([62.224.229.45]:23045 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S262580AbRF0O1x> convert rfc822-to-8bit;
	Wed, 27 Jun 2001 10:27:53 -0400
Message-ID: <3B39ED60.102370B3@baldauf.org>
Date: Wed, 27 Jun 2001 16:27:45 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: VM deadlock
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not sure wether this is a reiserfs bug or a kernel bug,
so I'm posting to both lists...

My linux box suddenly was not availbale using ssh|telnet,
but it responded to pings. On console login, I could type
"root", but after pressing "return", there was no reaction,
and pressing keys did not result in writing them on the
screen.

"Emergency sync" and "Remount R/O" did not have any
response.

That's why I pressed Alt+SysRq+P 5 times and wrote all stack
traces (without registers) onto paper. After that, I pressed
Alt+SysRq+T and also wrote 3 long stack traces (others were
available too, but too short) down.

After that, I wanted to kill processes and accidently
pressed Alt+SysRq+K (I did not want to kill init). After
that, there was sudden disk and screen activity. It seemed
that the system got alive again, but now, every process was
killed. On screen, I also could see many oopses from
reiserfs complaining about calling "journal_begin" on read
only media, but this is from "Remount R/O", I think.

This is what I copied from paper by hand, trying to be in a
suitable format for ksymoops:

---start---
5 stack traces obtained by Alt+SysRq+P

EIP: <c012839c>
Trace:
 <c0128ef5>
 <c012905e>
 <c0129d05>
 <c0129b36>
 <c012a425>
 <c0120198>
 <c01201f5>
 <c0120550>
 <c01113b4>
 <c0111513>
 <c01113b4>
 <c0111fb0>
 <c0129e12>
 <c0129e38>
 <c013c63a>
 <c013c928>
 <c0106be4>
 <c013cd24>
 <c0106ad3>

EIP: <c0128393>
Trace:
 <c0128ef5>
 <c012905e>
 <c0129d05>
 <c0129b36>
 <c012038e>
 <c012042f>
 <c012053f>
 <c01113b4>
 <c0111513>
 <c01113b4>
 <c0148ae9>
 <c01f258a>
 <c01f25cc>
 <c0106be4>
 <c01f1910>
 <c014886d>
 <c012ee26>
 <c0106ad3>

EIP: <c01285f6>
Trace:
 <c0128ef5>
 <c012905e>
 <c0129d05>
 <c0129b36>
 <c012a425>
 <c01201fb>
 <c0120550>
 <c01113b4>
 <c0111513>
 <c01113b4>
 <c0111fb0>
 <c013c63a>
 <c013c928>
 <c013c962>
 <c013cdef>
 <c0106be4>

EIP: <c0128d33>
Trace:
 <c0128b86>
 <c0128ef5>
 <c012905e>
 <c0129d05>
 <c0129b36>
 <c0129dc2>
 <c013c677>
 <c01bb4a0>
 <c01b6b4f>
 <c013c84b>
 <c013ccb2>
 <c0106ad3>

EIP: <c01283c8>
Trace:
 <c0128ef5>
 <c012905e>
 <c0129d05>
 <c0129b36>
 <c012038e>
 <c012042f>
 <c012053f>
 <c01113b4>
 <c0111513>
 <c01113b4>
 <c0148ae9>
 <c01f258a>
 <c01f25cc>
 <c0106be4>
 <c01f1910>
 <c014886d>
 <c012ee26>
 <c0106ad3>

3 chosen stack traces in the output of Alt+SysRq+T

java S 7FFFFFFF 0 4323 4240 (NOTLB) 4322
  Call Trace:
  EIP: <c0111cbf>
  Trace:
  <c01cc1a1>
  <c01bad82>
  <c01bae9e>
  <c01e8845>
  <c01b67d1>
  <c01b755c>
  <c01113b4>
  <c0111513>
  <c01385a4>
  <c011a862>
  <c01b7cab>
  <c0106ad3>

fetchmail R 00000000 0 4881 1 (NOTLB) 4902 4066
  Call Trace:
  EIP: <c0129c3c>
  Trace:
  <c0129b36>
  <c0122378>
  <c0123410>
  <c012044e>
  <c012053f>
  <c01113b4>
  <c0111513>
  <c01113b4>
  <c0117053>
  <c0117148>
  <c012ee53>
  <c0106be4>

mirrordir R 00000000 2672 4907 4894 (NOTLB)
  Call Trace:
  EIP: <c0129c3c>
  Trace:
  <c0129b36>
  <c0132282>
  <c013058f>
  <c013059c>
  <c0130992>
  <c0130b8e>
  <c0171f8b>
  <c016cc2e>
  <c015e189>
  <c0141b09>
  <c0141d46>
  <c015e1fc>
  <c015a958>
  <c013863b>
  <c0138ce1>
  <c01383db>
  <c01392b8>
  <c01361e6>
  <c0106ad3>


Ping over network: response
Emergency sync: no response
Remount R/O: no response
---end---

This is the output from ksymoops with the above file as
input:

---start---
ksymoops 2.4.1 on i586 2.4.6-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-pre5/ (default)
     -m /boot/System.map-2.4.6-pre5 (default)

Warning: You did not tell me where to find symbol
information.  I will
assume that the log matches the kernel and modules that are
running
right now and I'll use the default options above for symbol
resolution.
If the current kernel and/or modules do not match the log,
you can get
more accurate output by telling me the kernel version and
where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat
/boot/System.map-2.4.6-pre5 failed
EIP: <c012839c>
Using defaults from ksymoops -t elf32-i386 -a i386
Trace:
        <c0128ef5>
        <c012905e>
        <c0129d05>
        <c0129b36>
        <c012a425>
        <c0120198>
        <c01201f5>
        <c0120550>
        <c01113b4>
        <c0111513>
        <c01113b4>
        <c0111fb0>
        <c0129e12>
        <c0129e38>
        <c013c63a>
        <c013c928>
        <c0106be4>
        <c013cd24>
        <c0106ad3>
EIP: <c0128393>
Trace:
        <c0128ef5>
        <c012905e>
        <c0129d05>
        <c0129b36>
        <c012038e>
        <c012042f>
        <c012053f>
        <c01113b4>
        <c0111513>
        <c01113b4>
        <c0148ae9>
        <c01f258a>
        <c01f25cc>
        <c0106be4>
        <c01f1910>
        <c014886d>
        <c012ee26>
        <c0106ad3>
EIP: <c01285f6>
Trace:
        <c0128ef5>
        <c012905e>
        <c0129d05>
        <c0129b36>
        <c012a425>
        <c01201fb>
        <c0120550>
        <c01113b4>
        <c0111513>
        <c01113b4>
        <c0111fb0>
        <c013c63a>
        <c013c928>
        <c013c962>
        <c013cdef>
        <c0106be4>
EIP: <c0128d33>
Trace:
        <c0128b86>
        <c0128ef5>
        <c012905e>
        <c0129d05>
        <c0129b36>
        <c0129dc2>
        <c013c677>
        <c01bb4a0>
        <c01b6b4f>
        <c013c84b>
        <c013ccb2>
        <c0106ad3>
EIP: <c01283c8>
Trace:
        <c0128ef5>
        <c012905e>
        <c0129d05>
        <c0129b36>
        <c012038e>
        <c012042f>
        <c012053f>
        <c01113b4>
        <c0111513>
        <c01113b4>
        <c0148ae9>
        <c01f258a>
        <c01f25cc>
        <c0106be4>
        <c01f1910>
        <c014886d>
        <c012ee26>
        <c0106ad3>
               EIP: <c0111cbf>
               Trace:
               <c01cc1a1>
               <c01bad82>
               <c01bae9e>
               <c01e8845>
               <c01b67d1>
               <c01b755c>
               <c01113b4>
               <c0111513>
               <c01385a4>
               <c011a862>
               <c01b7cab>
               <c0106ad3>
               EIP: <c0129c3c>
               Trace:
               <c0129b36>
               <c0122378>
               <c0123410>
               <c012044e>
               <c012053f>
               <c01113b4>
               <c0111513>
               <c01113b4>
               <c0117053>
               <c0117148>
               <c012ee53>
               <c0106be4>
               EIP: <c0129c3c>
               Trace:
               <c0129b36>
               <c0132282>
               <c013058f>
               <c013059c>
               <c0130992>
               <c0130b8e>
               <c0171f8b>
               <c016cc2e>
               <c015e189>
               <c0141b09>
               <c0141d46>
               <c015e1fc>
               <c015a958>
               <c013863b>
               <c0138ce1>
               <c01383db>
               <c01392b8>
               <c01361e6>
               <c0106ad3>
Warning (Oops_read): Code line not seen, dumping what data
is available

>>EIP; c012839c <deactivate_page+e94/2618>   <=====
Trace; c0128ef5 <deactivate_page+19ed/2618>
Trace; c012905e <deactivate_page+1b56/2618>
Trace; c0129d05 <__alloc_pages+1cd/280>
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c012a425 <free_pages+611/1cac>
Trace; c0120198 <vmtruncate+1c4/878>
Trace; c01201f5 <vmtruncate+221/878>
Trace; c0120550 <vmtruncate+57c/878>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111513 <__verify_write+263/784>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111fb0 <schedule+264/394>
Trace; c0129e12 <__free_pages+1a/1c>
Trace; c0129e38 <free_pages+24/1cac>
Trace; c013c63a <poll_freewait+3a/44>
Trace; c013c928 <__pollwait+2e4/ef4>
Trace; c0106be4 <__up_wakeup+1140/2374>
Trace; c013cd24 <__pollwait+6e0/ef4>
Trace; c0106ad3 <__up_wakeup+102f/2374>
>>EIP; c0128393 <deactivate_page+e8b/2618>   <=====
Trace; c0128ef5 <deactivate_page+19ed/2618>
Trace; c012905e <deactivate_page+1b56/2618>
Trace; c0129d05 <__alloc_pages+1cd/280>
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c012038e <vmtruncate+3ba/878>
Trace; c012042f <vmtruncate+45b/878>
Trace; c012053f <vmtruncate+56b/878>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111513 <__verify_write+263/784>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0148ae9 <kiobuf_wait_for_io+5f85/6238>
Trace; c01f258a <vsprintf+25e/35c>
Trace; c01f25cc <vsprintf+2a0/35c>
Trace; c0106be4 <__up_wakeup+1140/2374>
Trace; c01f1910 <csum_partial_copy_generic+114/128>
Trace; c014886d <kiobuf_wait_for_io+5d09/6238>
Trace; c012ee26 <default_llseek+25e/914>
Trace; c0106ad3 <__up_wakeup+102f/2374>
>>EIP; c01285f6 <deactivate_page+10ee/2618>   <=====
Trace; c0128ef5 <deactivate_page+19ed/2618>
Trace; c012905e <deactivate_page+1b56/2618>
Trace; c0129d05 <__alloc_pages+1cd/280>
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c012a425 <free_pages+611/1cac>
Trace; c01201fb <vmtruncate+227/878>
Trace; c0120550 <vmtruncate+57c/878>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111513 <__verify_write+263/784>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111fb0 <schedule+264/394>
Trace; c013c63a <poll_freewait+3a/44>
Trace; c013c928 <__pollwait+2e4/ef4>
Trace; c013c962 <__pollwait+31e/ef4>
Trace; c013cdef <__pollwait+7ab/ef4>
Trace; c0106be4 <__up_wakeup+1140/2374>
>>EIP; c0128d33 <deactivate_page+182b/2618>   <=====
Trace; c0128b86 <deactivate_page+167e/2618>
Trace; c0128ef5 <deactivate_page+19ed/2618>
Trace; c012905e <deactivate_page+1b56/2618>
Trace; c0129d05 <__alloc_pages+1cd/280>
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c0129dc2 <__get_free_pages+a/1c>
Trace; c013c677 <__pollwait+33/ef4>
Trace; c01bb4a0 <datagram_poll+24/17c>
Trace; c01b6b4f <sock_recvmsg+3bb/5e8>
Trace; c013c84b <__pollwait+207/ef4>
Trace; c013ccb2 <__pollwait+66e/ef4>
Trace; c0106ad3 <__up_wakeup+102f/2374>
>>EIP; c01283c8 <deactivate_page+ec0/2618>   <=====
Trace; c0128ef5 <deactivate_page+19ed/2618>
Trace; c012905e <deactivate_page+1b56/2618>
Trace; c0129d05 <__alloc_pages+1cd/280>
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c012038e <vmtruncate+3ba/878>
Trace; c012042f <vmtruncate+45b/878>
Trace; c012053f <vmtruncate+56b/878>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111513 <__verify_write+263/784>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0148ae9 <kiobuf_wait_for_io+5f85/6238>
Trace; c01f258a <vsprintf+25e/35c>
Trace; c01f25cc <vsprintf+2a0/35c>
Trace; c0106be4 <__up_wakeup+1140/2374>
Trace; c01f1910 <csum_partial_copy_generic+114/128>
Trace; c014886d <kiobuf_wait_for_io+5d09/6238>
Trace; c012ee26 <default_llseek+25e/914>
Trace; c0106ad3 <__up_wakeup+102f/2374>
>>EIP; c0111cbf <schedule_timeout+17/a4>   <=====
Trace; c01cc1a1 <ip_options_undo+829/830>
Trace; c01bad82 <csum_partial_copy_fromiovecend+2ca/338>
Trace; c01bae9e <skb_recv_datagram+ae/c4>
Trace; c01e8845 <inet_accept+119/1ac>
Trace; c01b67d1 <sock_recvmsg+3d/5e8>
Trace; c01b755c <sock_create+764/f30>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111513 <__verify_write+263/784>
Trace; c01385a4 <path_release+3c/144>
Trace; c011a862 <del_timer+75a/b88>
Trace; c01b7cab <sock_create+eb3/f30>
Trace; c0106ad3 <__up_wakeup+102f/2374>
>>EIP; c0129c3c <__alloc_pages+104/280>   <=====
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c0122378 <filemap_fdatawait+2a0/30c>
Trace; c0123410 <filemap_nopage+14c/3d8>
Trace; c012044e <vmtruncate+47a/878>
Trace; c012053f <vmtruncate+56b/878>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0111513 <__verify_write+263/784>
Trace; c01113b4 <__verify_write+104/784>
Trace; c0117053 <up_and_exit+61b/890>
Trace; c0117148 <up_and_exit+710/890>
Trace; c012ee53 <default_llseek+28b/914>
Trace; c0106be4 <__up_wakeup+1140/2374>
>>EIP; c0129c3c <__alloc_pages+104/280>   <=====
Trace; c0129b36 <_alloc_pages+16/18>
Trace; c0132282 <block_symlink+14e/570>
Trace; c013058f <set_blocksize+24f/284>
Trace; c013059c <set_blocksize+25c/284>
Trace; c0130992 <getblk+f2/170>
Trace; c0130b8e <bread+1a/90c>
Trace; c0171f8b <load_nls_default+1c9c3/27d64>
Trace; c016cc2e <load_nls_default+17666/27d64>
Trace; c015e189 <load_nls_default+8bc1/27d64>
Trace; c0141b09 <get_empty_inode+141/1e4>
Trace; c0141d46 <iget4+c2/d4>
Trace; c015e1fc <load_nls_default+8c34/27d64>
Trace; c015a958 <load_nls_default+5390/27d64>
Trace; c013863b <path_release+d3/144>
Trace; c0138ce1 <path_walk+529/890>
Trace; c01383db <getname+5b/98>
Trace; c01392b8 <__user_walk+3c/58>
Trace; c01361e6 <cdput+446/890>
Trace; c0106ad3 <__up_wakeup+102f/2374>


2 warnings and 1 error issued.  Results may not be reliable.

---end---

It seems to me that there was a memory low or so and linux
was unable to recover from that problem. Maybe this is a
deadlock where every kernel process tries to allocate
memory, fails, and therefore relinquishes the CPU to the
next kernel process, which in turn fails, and so on...

I had a probably similar|connected problem (but with no
"ping" responding) with linux-2.4.5-pre3, described here:
http://lists.omnipotent.net/reiserfs/200106/msg00214.html

The kernel version and the suspected modules loaded at crash
time:

router|16:13:41|~/temp> uname -a
Linux router 2.4.6-pre5 #3 Tue Jun 26 23:36:26 CEST 2001
i586 unknown
router|16:16:08|~/temp> lsmod
Module                  Size  Used by
ipt_MASQUERADE          2032   1  (autoclean)
ip_nat_ftp              3872   0  (unused)
ip_conntrack_ftp        3856   0  [ip_nat_ftp]
iptable_nat            20912   1  [ipt_MASQUERADE
ip_nat_ftp]
ip_conntrack           21216   2  [ipt_MASQUERADE ip_nat_ftp
ip_conntrack_ftp iptable_nat]
ipt_REJECT              3232   2  (autoclean)
iptable_filter          2048   0  (autoclean) (unused)
serial                 43280   1  (autoclean)
isa-pnp                28272   0  (autoclean) [serial]
ipv6                  129904  -1  (autoclean)
ip_tables              13152   6  [ipt_MASQUERADE
iptable_nat ipt_REJECT iptable_filter]
eepro100               16016   1  (autoclean)
wd                      5232   1  (autoclean)
8390                    6304   0  (autoclean) [wd]
hisax                 133104  30
isdn                  124880  31  [hisax]
slhc                    4912  14  [isdn]
rtc                     5472   0  (autoclean)
floppy                 46064   0  (autoclean)
ide-cd                 26192   0  (autoclean)
cdrom                  27552   0  (autoclean) [ide-cd]
router|16:26:56|~/temp>

Is this kind of problem known?

Xuân.


