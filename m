Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262455AbSI3QYe>; Mon, 30 Sep 2002 12:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262456AbSI3QYe>; Mon, 30 Sep 2002 12:24:34 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:28304 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S262455AbSI3QY2>; Mon, 30 Sep 2002 12:24:28 -0400
Date: Tue, 1 Oct 2002 00:29:28 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic "killing interrupt handler" and kernel BUG at sched.c:468
Message-ID: <20020930162928.GB7691@leathercollection.ph>
Mail-Followup-To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020930121323.GA7250@leathercollection.ph>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20020930121323.GA7250@leathercollection.ph>
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

On Mon, Sep 30, 2002 at 08:13:24PM +0800, Federico Sevilla III wrote:
> On our server that had been running for 55 days with this 2.4.19-xfs
> kernel (XFS CVS snapshot 20020809 patched with RML's preempt patches
> for 2.4.19-rc3 and sys-magic 20020314 from Randy Dunlap, built using
> GCC 3.1.1 running Debian GNU/Linux)

And then after approximately 1.5 hours on 2.4.19-xfs (XFS CVS snapshot
20020930 patched only with Randy Dunlap's sys-magic 20020314, built
using gcc 2.95.4 running Debian GNU/Linux).

> I hit a kernel panic in the process running the distributed-net
> client.

Now in the process running syslogd. Attached kernel-panic-3.out is the
oops.

> After copying the oops message, I attempted to sync the disks using
> the (Alt + SysRq + S) key combination and after the sync messages I
> hit a kernel BUG at sched.c:568.

I did this, as well, and hit a kernel BUG at sched.c:566. My sched.c is
now exactly the same as the one in the XFS tree (which I think is the
same as the one in vanilla 2.4.19). Oops is attached as
kernel-bug-2.out.

> Pointers as to what probably caused this are welcome. If this is a
> "new" issue I hope the decoded oops messages will be help. Thank you
> everyone for your time.

System has been up for two hours so far and is thankfully alive. I hope
someone can point me to what the probably cause of this problem is. I
did an xfs_check -- which is from the latest 2.3.1 package -- and all my
XFS partitions are okay. I will be looking for a memory scanning tool
shortly to make sure I don't suddenly have bad RAM, although the problem
doesn't seem to be that.

Thanks again to everyone for your time.

 --> Jijo

-- 
Federico Sevilla III   :  http://jijo.free.net.ph
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-panic-3.out"

ksymoops 2.4.6 on i686 2.4.19-xfs.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-xfs/ (specified)
     -m /boot/System.map-2.4.19-xfs (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000002c
c026d0c9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c026d0c9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000028   ebx: dfccc3a8   ecx: 01800204   edx: 00000001
esi: dfccc3a8   edi: dfc265a0   ebp: 00000000   esp: defe5da8
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 281, stackpage=defe5000)
Stack: c15d957c dfc265a0 c15d9560 00000000 df381018 c01da1dc dfccc3c0 dfc26620
       dfccc3e0 dfccc380 dfc0c1e0 00000000 c026d750 c15d9560 dfc265a0 00000001
       c15d957c c15d9560 00000001 00000000 00000008 c038e600 00000000 c026d9c2
Call Trace:    [<c01da1dc>] [<c026d750>] [<c026d9c2>] [<c010985d>] [<c01099c6>]
  [<c010bbc8>] [<c02707e9>] [<c0271792>] [<c012f3e4>] [<c012f5c3>] [<c012f5de>]
  [<c01408fa>] [<c0140bf8>] [<c027188e>] [<c0271f44>] [<c010856f>]
Code: 8b 2c 90 8b 44 24 28 c1 e9 08 83 e1 0f d3 ed 83 e5 01 c7 44


>>EIP; c026d0c9 <process_transfer+51/2e4>   <=====

>>ebx; dfccc3a8 <_end+1f924484/2050213c>
>>esi; dfccc3a8 <_end+1f924484/2050213c>
>>edi; dfc265a0 <_end+1f87e67c/2050213c>
>>esp; defe5da8 <_end+1ec3de84/2050213c>

Trace; c01da1dc <xlog_assign_tail_lsn+18/74>
Trace; c026d750 <process_urb+54/200>
Trace; c026d9c2 <uhci_interrupt+c6/12c>
Trace; c010985d <handle_IRQ_event+31/5c>
Trace; c01099c6 <do_IRQ+6a/a8>
Trace; c010bbc8 <call_do_IRQ+5/d>
Trace; c02707e9 <sockfd_lookup+1/7c>
Trace; c0271792 <sys_recvfrom+2a/108>
Trace; c012f3e4 <__alloc_pages+40/178>
Trace; c012f5c3 <__free_pages+1b/1c>
Trace; c012f5de <free_pages+1a/1c>
Trace; c01408fa <poll_freewait+3a/44>
Trace; c0140bf8 <do_select+1c4/1dc>
Trace; c027188e <sys_recv+1e/24>
Trace; c0271f44 <sys_socketcall+15c/200>
Trace; c010856f <system_call+33/38>

Code;  c026d0c9 <process_transfer+51/2e4>
00000000 <_EIP>:
Code;  c026d0c9 <process_transfer+51/2e4>   <=====
   0:   8b 2c 90                  mov    (%eax,%edx,4),%ebp   <=====
Code;  c026d0cc <process_transfer+54/2e4>
   3:   8b 44 24 28               mov    0x28(%esp,1),%eax
Code;  c026d0d0 <process_transfer+58/2e4>
   7:   c1 e9 08                  shr    $0x8,%ecx
Code;  c026d0d3 <process_transfer+5b/2e4>
   a:   83 e1 0f                  and    $0xf,%ecx
Code;  c026d0d6 <process_transfer+5e/2e4>
   d:   d3 ed                     shr    %cl,%ebp
Code;  c026d0d8 <process_transfer+60/2e4>
   f:   83 e5 01                  and    $0x1,%ebp
Code;  c026d0db <process_transfer+63/2e4>
  12:   c7 44 00 00 00 00 00      movl   $0x0,0x0(%eax,%eax,1)
Code;  c026d0e2 <process_transfer+6a/2e4>
  19:   00 

 <0>Kernel panic: Aiee, killing interrupt handler!

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-bug-2.out"

ksymoops 2.4.6 on i686 2.4.19-xfs.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-xfs/ (specified)
     -m /boot/System.map-2.4.19-xfs (specified)

kernel BUG at sched.c:566!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0116879>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000018   ebx: defe5be0   ecx: def9c000   edx: 00000001
esi: def4c3e0   edi: defe4000   ebp: defe5bcc   esp: defe5ba8
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 281, stackpage=defe5000)
Stack: c02ca05e defe5be0 def4c3e0 defe4000 dfe24a18 defe5be0 00000000 defe4000
       dfe24a74 00000808 c0134a5a def4c3e0 00000005 def4c9e0 00000000 defe4000
       def4c42c def4c42c c0134c8b def4c3e0 00000808 00000001 00000001 0000000b
Call Trace:    [<c0134a5a>] [<c0134c8b>] [<c0134cd0>] [<c0134d17>] [<c0134dd7>]
  [<c02203ca>] [<c0220428>] [<c0118da3>] [<c011baf0>] [<c0115e54>] [<c0108b36>]
  [<c01161a7>] [<c0115e5f>] [<c0116af6>] [<c0134a70>] [<c013552d>] [<c0108660>]
  [<c026d0c9>] [<c01da1dc>] [<c012d750>] [<c026d9c2>] [<c010985d>] [<c01099c6>]
  [<c010bbc8>] [<c02707e9>] [<c0271792>] [<c012f3e4>] [<c012f5c3>] [<c012f5de>]
  [<c01408fa>] [<c0140bf8>] [<c027188e>] [<c0271f44>] [<c010856f>]
Code: 0f 0b 36 02 56 a0 2c c0 83 c4 04 8b 4d f4 c1 e1 05 81 c1 40


>>EIP; c0116879 <schedule+4d/2f4>   <=====

>>ebx; defe5be0 <_end+1ec3dcbc/2050213c>
>>ecx; def9c000 <_end+1ebf40dc/2050213c>
>>esi; def4c3e0 <_end+1eba44bc/2050213c>
>>edi; defe4000 <_end+1ec3c0dc/2050213c>
>>ebp; defe5bcc <_end+1ec3dca8/2050213c>
>>esp; defe5ba8 <_end+1ec3dc84/2050213c>

Trace; c0134a5a <__wait_on_buffer+6e/90>
Trace; c0134c8b <wait_for_buffers+63/90>
Trace; c0134cd0 <wait_for_locked_buffers+18/28>
Trace; c0134d17 <sync_buffers+37/44>
Trace; c0134dd7 <fsync_dev+2b/30>
Trace; c02203ca <go_sync+126/140>
Trace; c0220428 <do_emergency_sync+44/b0>
Trace; c0118da3 <panic+e3/e8>
Trace; c011baf0 <do_exit+28/240>
Trace; c0115e54 <do_page_fault+0/490>
Trace; c0108b36 <die+56/58>
Trace; c01161a7 <do_page_fault+353/490>
Trace; c0115e5f <do_page_fault+b/490>
Trace; c0116af6 <schedule+2ca/2f4>
Trace; c0134a70 <__wait_on_buffer+84/90>
Trace; c013552d <fsync_buffers_list+135/14c>
Trace; c0108660 <error_code+34/3c>
Trace; c026d0c9 <process_transfer+51/2e4>
Trace; c01da1dc <xlog_assign_tail_lsn+18/74>
Trace; c012d750 <kmem_cache_grow+1b4/1d4>
Trace; c026d9c2 <uhci_interrupt+c6/12c>
Trace; c010985d <handle_IRQ_event+31/5c>
Trace; c01099c6 <do_IRQ+6a/a8>
Trace; c010bbc8 <call_do_IRQ+5/d>
Trace; c02707e9 <sockfd_lookup+1/7c>
Trace; c0271792 <sys_recvfrom+2a/108>
Trace; c012f3e4 <__alloc_pages+40/178>
Trace; c012f5c3 <__free_pages+1b/1c>
Trace; c012f5de <free_pages+1a/1c>
Trace; c01408fa <poll_freewait+3a/44>
Trace; c0140bf8 <do_select+1c4/1dc>
Trace; c027188e <sys_recv+1e/24>
Trace; c0271f44 <sys_socketcall+15c/200>
Trace; c010856f <system_call+33/38>

Code;  c0116879 <schedule+4d/2f4>
00000000 <_EIP>:
Code;  c0116879 <schedule+4d/2f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011687b <schedule+4f/2f4>
   2:   36 02 56 a0               add    %ss:0xffffffa0(%esi),%dl
Code;  c011687f <schedule+53/2f4>
   6:   2c c0                     sub    $0xc0,%al
Code;  c0116881 <schedule+55/2f4>
   8:   83 c4 04                  add    $0x4,%esp
Code;  c0116884 <schedule+58/2f4>
   b:   8b 4d f4                  mov    0xfffffff4(%ebp),%ecx
Code;  c0116887 <schedule+5b/2f4>
   e:   c1 e1 05                  shl    $0x5,%ecx
Code;  c011688a <schedule+5e/2f4>
  11:   81 c1 40 00 00 00         add    $0x40,%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

--d6Gm4EdcadzBjdND--
