Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291087AbSBGCym>; Wed, 6 Feb 2002 21:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291088AbSBGCyc>; Wed, 6 Feb 2002 21:54:32 -0500
Received: from 202-77-223-26.outblaze.com ([202.77.223.26]:35593 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S291087AbSBGCyY>; Wed, 6 Feb 2002 21:54:24 -0500
Date: Thu, 7 Feb 2002 10:54:19 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: Oops from a 2.4.18pre2aa2 kernel 
Message-ID: <20020207025419.GA7640@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.18pre2aa2 with a RH 7.0 distribution

Hi  Attached is a decoded oops from a SMP 2GB RAM box being used
as a webserver [Apache] fronted by Squid and having lots of UW-IMAP
processes reading mailboxes over NFS. The box typically has a load
average of 70 with very few runnable processes [most of them are in D
state waiting for relatively slow NFS IO]

There are similar FreeBSD 4.4-stable boxes and they seem to have much
fewer processes stuck in disk wait state [similar amount of web traffic]
and NFS seems much speedier there compared to 2.4.18pre2aa2

I/O subsystem, 2 IDE disks connected to Promise ATA-100 card in software
RAID-1 configuration

If there is any other information, I can provide. please let me know


Regards, Yusuf

-- 
Yusuf Goolamabbas
yusufg@outblaze.com

ksymoops 2.3.4 on i686 2.4.18pre2aa2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18pre2aa2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01c61b0, System.map says c0156060.  Ignoring ksyms_base entry
Status: RO
Unable to handle kernel paging request at virtual address 5a5a5a76
c01f8133      
*pde = 00000000
Oops: 0002     
CPU:    0 
EIP:    0010:[<c01f8133>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206                        
eax: 5a5a5a5a   ebx: d7fc6d24   ecx: 5a5a5a5a   edx: 5a5a5a5a
esi: c36c3490   edi: d8ab2a0d   ebp: f5ab98d8   esp: c026fc90
ds: 0018   es: 0018   ss: 0018                               
Process swapper (pid: 0, stackpage=c026f000)
Stack: d7fc6d24 d8ab29dc c01f82c8 d7fc6d24 d7fc6d24 e399e084 c3bfc484
c37a6800 
       00000000 c3bfc484 c01d8694 c3bfc484 c026fe20 c026fe20 c026fe40
d7dd2b34 
       00000000 c37a6800 c37a6800 c01d241e c37a6800 00000000 00000001
d1925df0 
Call Trace: [<c01f82c8>] [<c01d8694>] [<c01d241e>] [<c01e1aa2>]
[<c01e270b>]   
   [<c01e1e24>] [<c01d26dc>] [<c01cee9c>] [<c01cefd7>] [<c01edad4>]
[<c01ec8a4>] 
   [<c01ea268>] [<c01ce929>] [<c01f94fd>] [<c01cfe84>] [<c01f683d>]
[<c01f6e00>] 
   [<c01df417>] [<c01df794>] [<c01a1571>] [<c01d2b1b>] [<c011b71b>]
[<c01089bd>] 
   [<c01051e0>] [<c01051e0>] [<c010ac98>] [<c01051e0>] [<c01051e0>]
[<c010520c>] 
   [<c0105292>] [<c0105000>] 
Code: 89 42 1c 8b 53 18 8b 43 1c 89 10 c7 43 4c 00 00 00 00 8b 41 

>>EIP; c01f8133 <tcp_timewait_kill+83/e0>   <=====
Trace; c01f82c8 <tcp_timewait_state_process+138/360>
Trace; c01d8694 <qdisc_restart+14/170>
Trace; c01d241e <dev_queue_xmit+14e/320>
Trace; c01e1aa2 <ip_output+e2/130>
Trace; c01e270b <ip_build_xmit+2bb/350>
Trace; c01e1e24 <ip_queue_xmit+334/470>
Trace; c01d26dc <netif_rx+8c/100>
Trace; c01cee9c <kfree_skbmem+c/70>
Trace; c01cefd7 <__kfree_skb+d7/e0>
Trace; c01edad4 <tcp_data_queue+424/ab0>
Trace; c01ec8a4 <tcp_ack+a4/330>
Trace; c01ea268 <tcp_init_buffer_space+38/100>
Trace; c01ce929 <sock_def_readable+39/70>
Trace; c01f94fd <tcp_child_process+4d/a0>
Trace; c01cfe84 <skb_checksum+54/2d0>
Trace; c01f683d <tcp_v4_do_rcv+bd/120>
Trace; c01f6e00 <tcp_v4_rcv+560/650>
Trace; c01df417 <ip_local_deliver+e7/160>
Trace; c01df794 <ip_rcv+304/380>
Trace; c01a1571 <speedo_rx+2f1/310>
Trace; c01d2b1b <net_rx_action+17b/290>
Trace; c011b71b <do_softirq+7b/e0>
Trace; c01089bd <do_IRQ+dd/f0>
Trace; c01051e0 <default_idle+0/40>
Trace; c01051e0 <default_idle+0/40>
Trace; c010ac98 <call_do_IRQ+5/d>
Trace; c01051e0 <default_idle+0/40>
Trace; c01051e0 <default_idle+0/40>
Trace; c010520c <default_idle+2c/40>
Trace; c0105292 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c01f8133 <tcp_timewait_kill+83/e0>
00000000 <_EIP>:
Code;  c01f8133 <tcp_timewait_kill+83/e0>   <=====
   0:   89 42 1c                  mov    %eax,0x1c(%edx)   <=====
Code;  c01f8136 <tcp_timewait_kill+86/e0>
   3:   8b 53 18                  mov    0x18(%ebx),%edx
Code;  c01f8139 <tcp_timewait_kill+89/e0>
   6:   8b 43 1c                  mov    0x1c(%ebx),%eax
Code;  c01f813c <tcp_timewait_kill+8c/e0>
   9:   89 10                     mov    %edx,(%eax)
Code;  c01f813e <tcp_timewait_kill+8e/e0>
   b:   c7 43 4c 00 00 00 00      movl   $0x0,0x4c(%ebx)
Code;  c01f8145 <tcp_timewait_kill+95/e0>
  12:   8b 41 00                  mov    0x0(%ecx),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!                

3 warnings issued.  Results may not be reliable.


----- End forwarded message -----

-- 
Yusuf Goolamabbas
yusufg@outblaze.com
