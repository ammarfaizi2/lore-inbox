Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbRBZO2s>; Mon, 26 Feb 2001 09:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbRBZO2l>; Mon, 26 Feb 2001 09:28:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130212AbRBZO21>;
	Mon, 26 Feb 2001 09:28:27 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Mon, 26 Feb 2001 13:13:24 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: unix_ioctl ?
Message-ID: <Pine.LNX.4.21.0102261310400.19569-100000@linux.home>
X-mailer: Pine 4.21
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

i notcied in unix_ioctl at the start of most of its functions is it
possible for the sock->sk to be NULL ?

static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long
arg) {
        struct sock *sk = sock->sk;

as there is no test to see if its null it just jumps in and uses its data
and could i thave caused this ?


ksymoops 2.3.4 on i686 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer dereference at virtual address 000001c4
current->tss.cr3 = 01f00000, %cr3 = 01f00000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01880c3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c18e0684   ebx: 00000000   ecx: 00000168   edx: bfffee9c
esi: c18e0640   edi: bfffee9c   ebp: 0000541b   esp: c1ef3f80
ds: 0018   es: 0018   ss: 0018
Process gnome-terminal (pid: 888, process nr: 47, stackpage=c1ef3000)
Stack: c0162d81 c17614e0 0000541b bfffee9c c1713980 c012d7bd c1761440 c1713980 
       0000541b bfffee9c c1ef2000 00000000 00000000 bfffee58 c18e7e40 c1761440 
       c0109374 00000004 0000541b bfffee9c 00000000 00000000 bfffee58 00000036 
Call Trace: [<c0162d81>] [<c012d7bd>] [<c0109374>] [<c010002b>] 
Code: 8b 59 5c 8b 44 24 14 89 da e8 73 e9 04 00 eb 06 90 b8 ea ff 

>>EIP; c01880c3 <unix_ioctl+57/70>   <=====
Trace; c0162d81 <sock_ioctl+1d/24>
Trace; c012d7bd <sys_ioctl+1a1/1bc>
Trace; c0109374 <system_call+34/38>
Trace; c010002b <startup_32+2b/11e>
Code;  c01880c3 <unix_ioctl+57/70>
00000000 <_EIP>:
Code;  c01880c3 <unix_ioctl+57/70>   <=====
   0:   8b 59 5c                  mov    0x5c(%ecx),%ebx   <=====
Code;  c01880c6 <unix_ioctl+5a/70>
   3:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01880ca <unix_ioctl+5e/70>
   7:   89 da                     mov    %ebx,%edx
Code;  c01880cc <unix_ioctl+60/70>
   9:   e8 73 e9 04 00            call   4e981 <_EIP+0x4e981> c01d6a44 <__put_user_4+0/18>
Code;  c01880d1 <unix_ioctl+65/70>
   e:   eb 06                     jmp    16 <_EIP+0x16> c01880d9 <unix_ioctl+6d/70>
Code;  c01880d3 <unix_ioctl+67/70>
  10:   90                        nop    
Code;  c01880d4 <unix_ioctl+68/70>
  11:   b8 ea ff 00 00            mov    $0xffea,%eax


1 warning issued.  Results may not be reliable.


thanks
	James

-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  1:10pm  up 24 days, 20:55,  7 users,  load average: 2.10, 1.36, 1.09

