Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKHXd4>; Wed, 8 Nov 2000 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKHXdp>; Wed, 8 Nov 2000 18:33:45 -0500
Received: from satyaki.pacific.net.in ([203.123.128.85]:40144 "EHLO
	satyaki.pacific.net.in") by vger.kernel.org with ESMTP
	id <S129094AbQKHXdi>; Wed, 8 Nov 2000 18:33:38 -0500
Date: Wed, 8 Nov 2000 21:59:18 +0530 (IST)
From: Venky <venkats_home@bigfoot.com>
To: Linux Admin <linux-admin@vger.kernel.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops!
In-Reply-To: <3A08FA77.703BCC07@rdstm.ro>
Message-ID: <Pine.LNX.4.21.0011082148090.2005-100000@Spook.HauntedHouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I am getting a whole lot of kernel oops, and I am not able to detect any
> > pattern.  The only thing common is the machine is pretty heavily loaded
> > at that time.  Am I having a hardware problem here, or is it something
> > else?

> looks like a memory problem, but i might be wrong.

Thanks for the tip.  I think it is a memory problem too.  Anyway, I ran
the oops text thru ksymoops (thanks, Tom).  Maybe this will give a
clearer picture.  

[ Am cross-posting this to the linux-kernel list.  Anyone replying from
that list, please include my address in the reply.  I am not on the
list. ]

========================================================================

ksymoops 0.7c on i586 2.2.16-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-3/ (default)
     -m /boot/System.map (specified)

Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c0109f0c <system_call+34/38>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx
Code;  00000004 Before first symbol
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  00000009 Before first symbol
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  0000000d Before first symbol
   d:   75 12                     jne    21 <_EIP+0x21> 00000021 Before first symbol
Code;  0000000f Before first symbol
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> ffff9664 <END_OF_CODE+3779b740/????>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 03e97000, %cr3 = 03e97000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c2a66000
esi: 00000000   edi: bfffeec8   ebp: ffffffff   esp: c2a67f98
ds: 0018   es: 0018   ss: 0018
Process wnlaunch (pid: 12823, process nr: 65, stackpage=c2a67000)
Stack: 00000000 bfffee78 c2a66000 40013ed0 c2a66000 c2a67fb8 c2a67fb8 c2a66000 
       c2a66000 c2a6608c c0109f0c ffffffff bfffeec8 00000000 00000000 00000000 
       bfffee78 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 24 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 24 24               mov    0x24(%esp,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 03920000, %cr3 = 03920000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c2a66000
esi: 00000000   edi: bfffeec8   ebp: ffffffff   esp: c2a67f98
ds: 0018   es: 0018   ss: 0018
Process wnlaunch (pid: 14468, process nr: 65, stackpage=c2a67000)
Stack: 00000000 bfffee78 c2a66000 40013ed0 c2a66000 c2a67fb8 c2a67fb8 c2a66000 
       c2a66000 c2a6608c c0109f0c ffffffff bfffeec8 00000000 00000000 00000000 
       bfffee78 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 02fca000, %cr3 = 02fca000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c2b84000
esi: 00000000   edi: bfffeeb8   ebp: ffffffff   esp: c2b85f98
ds: 0018   es: 0018   ss: 0018
Process wnlaunch (pid: 32164, process nr: 65, stackpage=c2b85000)
Stack: 00000000 bfffee68 c2b84000 40013ed0 c2b84000 c2b85fb8 c2b85fb8 c2b84000 
       c2b84000 c2b8408c c0109f0c ffffffff bfffeeb8 00000000 00000000 00000000 
       bfffee68 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 02fca000, %cr3 = 02fca000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c3cbe000
esi: 00000000   edi: bfffeeb8   ebp: ffffffff   esp: c3cbff98
ds: 0018   es: 0018   ss: 0018
Process wnlaunch (pid: 9060, process nr: 65, stackpage=c3cbf000)
Stack: 00000000 bfffee68 c3cbe000 40013ed0 c3cbe000 c3cbffb8 c3cbffb8 c3cbe000 
       c3cbe000 c3cbe08c c0109f0c ffffffff bfffeeb8 00000000 00000000 00000000 
       bfffee68 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 077c6000, %cr3 = 077c6000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c3cbe000
esi: 00000000   edi: bfffeeb8   ebp: ffffffff   esp: c3cbff98
ds: 0018   es: 0018   ss: 0018
Process wnlaunch (pid: 9240, process nr: 65, stackpage=c3cbf000)
Stack: 00000000 bfffee68 c3cbe000 40013ed0 c3cbe000 c3cbffb8 c3cbffb8 c3cbe000 
       c3cbe000 c3cbe08c c0109f0c ffffffff bfffeeb8 00000000 00000000 00000000 
       bfffee68 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 04016000, %cr3 = 04016000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c3c94000
esi: 00000000   edi: bfffe8a8   ebp: ffffffff   esp: c3c95f98
ds: 0018   es: 0018   ss: 0018
Process word (pid: 18238, process nr: 77, stackpage=c3c95000)
Stack: 00000000 bfffe858 c3c94000 0809dd50 c3c94000 c3c95fb8 c3c95fb8 c3c94000 
       c3c94000 c3c9408c c0109f0c ffffffff bfffe8a8 00000000 00000000 00000000 
       bfffe858 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 06274000, %cr3 = 06274000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c7314000
esi: 00000000   edi: bfffeef8   ebp: ffffffff   esp: c7315f98
ds: 0018   es: 0018   ss: 0018
Process wnlaunch (pid: 672, process nr: 60, stackpage=c7315000)
Stack: 00000000 bfffeea8 c7314000 40013ed0 c7314000 c7315fb8 c7315fb8 c7314000 
       c7314000 c731408c c0109f0c ffffffff bfffeef8 00000000 00000000 00000000 
       bfffeea8 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

Unable to handle kernel NULL pointer dereference at virtual address 00000024
current->tss.cr3 = 06eb3000, %cr3 = 06eb3000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117c48>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c59d8000
esi: 00000000   edi: bfffe30c   ebp: ffffffff   esp: c59d9f98
ds: 0018   es: 0018   ss: 0018
Process word (pid: 9897, process nr: 64, stackpage=c59d9000)
Stack: 00000000 bfffe2bc c59d8000 080a1170 c59d8000 c59d9fb8 c59d9fb8 c59d8000 
       c59d8000 c59d808c c0109f0c ffffffff bfffe30c 00000000 00000000 00000000 
       bfffe2bc 00000072 0000002b 0000002b 00000072 400b28e9 00000023 00000202 
Call Trace: [<c0109f0c>] 
Code: 8b 54 20 24 be 00 fe ff ff 83 7a 08 00 75 12 e8 50 96 ff ff 

>>EIP; c0117c48 <sys_wait4+2ac/304>   <=====
Trace; c0109f0c <system_call+34/38>
Code;  c0117c48 <sys_wait4+2ac/304>
00000000 <_EIP>:
Code;  c0117c48 <sys_wait4+2ac/304>   <=====
   0:   8b 54 20 24               mov    0x24(%eax,1),%edx   <=====
Code;  c0117c4c <sys_wait4+2b0/304>
   4:   be 00 fe ff ff            mov    $0xfffffe00,%esi
Code;  c0117c51 <sys_wait4+2b5/304>
   9:   83 7a 08 00               cmpl   $0x0,0x8(%edx)
Code;  c0117c55 <sys_wait4+2b9/304>
   d:   75 12                     jne    21 <_EIP+0x21> c0117c69 <sys_wait4+2cd/304>
Code;  c0117c57 <sys_wait4+2bb/304>
   f:   e8 50 96 ff ff            call   ffff9664 <_EIP+0xffff9664> c01112ac <schedule+0/280>

======================================================================

Thanks,
Venky.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
