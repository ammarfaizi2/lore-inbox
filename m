Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSKSHSy>; Tue, 19 Nov 2002 02:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbSKSHSy>; Tue, 19 Nov 2002 02:18:54 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:36992
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267111AbSKSHSv>; Tue, 19 Nov 2002 02:18:51 -0500
Subject: Two Stack Traces  - please respond if you can.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1037690746.4410.10.camel@digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 01:25:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two stack traces in this email. I was curious if they both are
bad output, as the stack may be corrupt, which I feel may be causing
these panics. 

The recent, is from a 2.4.19-aa1 kernel, on my production oracle db
which happened today.
The old, is from a 2.4.19-aa1 kernel, on an identical box, running
oracle, but occurred during stress testing. Any help regarding these two
stacks is extremely welcome, as this is a rather urgent issue. 

TIA.


<recent ksymoops output>

ksymoops 2.4.1 on i686 2.4.19.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Oops:   0000     2.4.19 #1 SMP Wed Oct 16 17:02:35 CDT 2002
CPU:    0
EIP:    0010:[<c01164ee>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: c031e000   ebx: c034d8a8     ecx: 00000000       edx: ffffffd4
esi: c034d880   edi: 00000080     ebp: c031ffc8       esp: c031ff98
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c031f000)
Stack: c034d880 00000019 c031e000 c031e000 ffffffd4 0008e000 00000000
c0100018
       c0100018 c031e000 c0106e60 c0105000 0008e000 c0106ee9 0002080e
00098700
       c03207a5 c031e000 00000000 c02a6da0 00200000 00200000 00200000
00038000
Call Trace:    [<c0106e60>] [<c0105000>] [<c0106ee9>]
Code: 8b 72 58 8b 40 5c 85 f6 89 45 d4 75 35 89 42 5c f0 ff 40 14

>>EIP; c01164ee <schedule+1ae/390>   <=====
Trace; c0106e60 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0106ee9 <cpu_idle+29/30>
Code;  c01164ee <schedule+1ae/390>
00000000 <_EIP>:
Code;  c01164ee <schedule+1ae/390>   <=====
   0:   8b 72 58                  mov    0x58(%edx),%esi   <=====
Code;  c01164f1 <schedule+1b1/390>
   3:   8b 40 5c                  mov    0x5c(%eax),%eax
Code;  c01164f4 <schedule+1b4/390>
   6:   85 f6                     test   %esi,%esi
Code;  c01164f6 <schedule+1b6/390>
   8:   89 45 d4                  mov    %eax,0xffffffd4(%ebp)
Code;  c01164f9 <schedule+1b9/390>
   b:   75 35                     jne    42 <_EIP+0x42> c0116530
<schedule+1f0/390>
Code;  c01164fb <schedule+1bb/390>
   d:   89 42 5c                  mov    %eax,0x5c(%edx)
Code;  c01164fe <schedule+1be/390>
  10:   f0 ff 40 14               lock incl 0x14(%eax)

<0> Kernel panic: Attempted to kill the idle task!


</recent ksymoops output>


<old ksymoops output>

ksymoops 2.4.1 on i686 2.4.19.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Oops: 0000 2.4.19 #1 SMP Mon Oct 7 11:01:05 CDT 2002
CPU:    2
EIP:    0010:[<c01a71b7>]  Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: d6f37b7c   ebx: 00000001     ecx: 00000000       edx: e5c5f280
esi: d6f37b7c   edi: e5c5f280     ebp: c93b2400       esp: c706fcb0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c706f000)
Stack: c01a6c7b e5c5f280 c93b2400 d6f37b7c 00000202 c93b2400 d6f37b7c
00001636
       00004ca8 c93b2400 d6f37b7c 00001636 00004ca8 c01d2f74 d6f37b7c
00000286
       00000286 0000000a c93b2400 d041ceb8 00001636 00004ca8 00000000
00000000
Call Trace:    [<c01a6c7b>] [<c01d2f74>] [<c01d2d00>] [<c01c798e>]
[<d9848583>]
  [<c01c7acb>] [<c01c6804>] [<c01dfc38>] [<c01e0013>] [<c023ad55>]
[<c023ae87>]
  [<c023b232>] [<d984db87>] [<c024574f>] [<d9854d63>] [<c0234629>]
[<c0234350>]
  [<c011ef8b>] [<c011ee31>] [<c011ebbb>] [<c010a97e>] [<c0106e60>]
[<c010d248>]
  [<c0106e60>] [<c0106e89>] [<c0106ee4>] [<c011a589>]
Code: 8b 41 20 89 42 44 85 c0 75 e0 8b 42 34 85 c0 74 07 c7 42 34

>>EIP; c01a71b7 <xfs_buf_iodone_callbacks+b7/180>   <=====
Trace; c01a6c7b <xfs_buf_item_unlock+8b/a0>
Trace; c01d2f74 <xfs_trans_chunk_committed+1a4/208>
Trace; c01d2d00 <xfs_trans_committed+10/e0>
Trace; c01c798e <xlog_state_do_callback+14e/260>
Trace; d9848583 <END_OF_CODE+11796564/????>
Trace; c01c7acb <xlog_state_done_syncing+2b/70>
Trace; c01c6804 <xlog_iodone+44/a0>
Trace; c01dfc38 <pagebuf_iodone+8/80>
Trace; c01e0013 <_end_pagebuf_page_io_multi+d3/110>
Trace; c023ad55 <scsi_merge_requests_fn_dc+5e5/880>
Trace; c023ae87 <scsi_merge_requests_fn_dc+717/880>
Trace; c023b232 <scsi_init_io_vd+b2/480>
Trace; d984db87 <END_OF_CODE+1179bb68/????>
Trace; c024574f <cdrom_read_block+8f/d0>
Trace; d9854d63 <END_OF_CODE+117a2d44/????>
Trace; c0234629 <scsi_partsize+69/140>
Trace; c0234350 <print_req_sense+0/20>
Trace; c011ef8b <bh_action+4b/80>
Trace; c011ee31 <tasklet_hi_action+61/a0>
Trace; c011ebbb <do_softirq+7b/e0>
Trace; c010a97e <do_IRQ+fe/110>
Trace; c0106e60 <default_idle+0/40>
Trace; c010d248 <call_do_IRQ+5/d>
Trace; c0106e60 <default_idle+0/40>
Trace; c0106e89 <default_idle+29/40>
Trace; c0106ee4 <cpu_idle+24/30>
Trace; c011a589 <printk+119/140>
Code;  c01a71b7 <xfs_buf_iodone_callbacks+b7/180>
00000000 <_EIP>:
Code;  c01a71b7 <xfs_buf_iodone_callbacks+b7/180>   <=====
   0:   8b 41 20                  mov    0x20(%ecx),%eax   <=====
Code;  c01a71ba <xfs_buf_iodone_callbacks+ba/180>
   3:   89 42 44                  mov    %eax,0x44(%edx)
Code;  c01a71bd <xfs_buf_iodone_callbacks+bd/180>
   6:   85 c0                     test   %eax,%eax
Code;  c01a71bf <xfs_buf_iodone_callbacks+bf/180>
   8:   75 e0                     jne    ffffffea <_EIP+0xffffffea>
c01a71a1 <xfs_buf_iodone_callbacks+a1/180>
Code;  c01a71c1 <xfs_buf_iodone_callbacks+c1/180>
   a:   8b 42 34                  mov    0x34(%edx),%eax
Code;  c01a71c4 <xfs_buf_iodone_callbacks+c4/180>
   d:   85 c0                     test   %eax,%eax
Code;  c01a71c6 <xfs_buf_iodone_callbacks+c6/180>
   f:   74 07                     je     18 <_EIP+0x18> c01a71cf
<xfs_buf_iodone_callbacks+cf/180>
Code;  c01a71c8 <xfs_buf_iodone_callbacks+c8/180>
  11:   c7 42 34 00 00 00 00      movl   $0x0,0x34(%edx)

 <0>Kernel panic: Aiee, killing interupt handler!


</old ksymoops output>


--The GrandMaster
