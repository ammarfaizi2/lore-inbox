Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSAXPtD>; Thu, 24 Jan 2002 10:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSAXPsx>; Thu, 24 Jan 2002 10:48:53 -0500
Received: from phantom.abyss.za.org ([24.72.31.206]:8205 "HELO abyss.za.org")
	by vger.kernel.org with SMTP id <S288606AbSAXPsk>;
	Thu, 24 Jan 2002 10:48:40 -0500
Message-ID: <20020124140105.2116.qmail@abyss.za.org>
From: "Lonny Selinger" <lonny@abyss.za.org>
To: linux-kernel@vger.kernel.org
Subject: Oops et all
Date: Thu, 24 Jan 2002 14:01:05 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm not sure if I'm actually sending this to the right address but 
from what I could deduce I should be at least close ;) 

I recieved an error from syslog today after trying to run the newest version 
of LAME (whic I had been running previously with no error). Recent changes 
to the machine include enabling a workaround for AMD processors as well as 
changing vfs to nomount:
<from my lilo.conf line>
append=" hdd=ide-scsi devfs=nomount mem=nopentium quiet" 

After recieving the error I followed the instructions as best as possible to 
report this all properly. The initial part of the following are the lines 
taken from syslog, then the result of ksysmoops and finally some system 
specific information I've included as well as what I traced the EIP output 
to. Please let me know if this is enough information. Also ... the result of 
this was lame would run (or appear in the proc list) but there was no 
output. I use LAME for streaming a couple of different on-the-fly mp3 
streams.  Heres the info I have: 

OUPUT FROM SYSLOG:
# cat Oops.log
swap_free: Unused swap offset entry 0000d400
Unable to handle kernel paging request at virtual address 69d004f8
printing eip:
c0130044
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0130044>]    Not tainted
EFLAGS: 00010202
eax: 0000ff75   ebx: e0750034   ecx: 00000000   edx: 00000002
esi: e0fae000   edi: e07500cc   ebp: e0faff3c   esp: e0faff2c
ds: 0018   es: 0018   ss: 0018
Process liveice (pid: 1854, stackpage=e0faf000)
Stack: 00000000 e0fa0000 00000000 00000000 00000000 e0fae000 e1a5a930 
e1a5a930
      e1a5a92c e07559cc 00001000 e0fae000 c0136224 e07559cc fffffff5 
00000000
      e0feede4 ffffffea 00000000 00001000 c012ec05 e0feede4 bfffd840 
00001000
Call Trace: [<c0136224>] [<c012ec05>] [<c011aaa2>] [<c0106ceb>] 

Code: 10 83 c4 04 5b 89 d0 5e 5f 5d c3 90 56 53 8b 5c 24 0c 8b 74
<1>Unable to handle kernel paging request at virtual address 7fffffff
printing eip:
c0110dbc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110dbc>]    Not tainted
EFLAGS: 00010046
eax: 00000001   ebx: 7fffffff   ecx: fffffffe   edx: 7fffffff
esi: 00000046   edi: 00000001   ebp: e0a23e54   esp: e0a23e3c
ds: 0018   es: 0018   ss: 0018
Process lame (pid: 1855, stackpage=e0a23000)
Stack: 00000282 00000001 e1a5a92c e1a5a92c e07559cc e07559cc e46f34d8 
c0136761
      e62d82f4 c1a0e4bc c01367de e07559cc 00000001 00000001 c012f78d 
e07559cc
      e62d82f4 e1018bfc 00000001 00000000 c1a0f148 e62d82f4 00000000 
00000001
Call Trace: [<c0136761>] [<c01367de>] [<c012f78d>] [<c012e7d2>] [<c01158bc>]
  [<c0115e9b>] [<c0110d01>] [<c011b0fa>] [<c0106b8f>] [<c0136459>] 
[<c0136459>]
  [<c012ed01>] [<c0106d24>] 

Code: 8b 03 89 c2 0f 0d 02 8b 45 f0 83 c0 04 39 c3 75 93 ff 75 e8 

RESULT OF RUNNING KSYSMOOPS 

ksymoops 2.4.3 on i686 2.4.17.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.4.17/ (default)
    -m /usr/src/linux/System.map (default) 

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options. 

Unable to handle kernel paging request at virtual address 69d004f8
c0130044
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0130044>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0000ff75   ebx: e0750034   ecx: 00000000   edx: 00000002
esi: e0fae000   edi: e07500cc   ebp: e0faff3c   esp: e0faff2c
ds: 0018   es: 0018   ss: 0018
Process liveice (pid: 1854, stackpage=e0faf000)
Stack: 00000000 e0fa0000 00000000 00000000 00000000 e0fae000 e1a5a930 
e1a5a930
      e1a5a92c e07559cc 00001000 e0fae000 c0136224 e07559cc fffffff5 
00000000
      e0feede4 ffffffea 00000000 00001000 c012ec05 e0feede4 bfffd840 
00001000
Call Trace: [<c0136224>] [<c012ec05>] [<c011aaa2>] [<c0106ceb>]
Code: 10 83 c4 04 5b 89 d0 5e 5f 5d c3 90 56 53 8b 5c 24 0c 8b 74 

>>EIP; c0130044 <get_hash_table+84/90>   <=====
Trace; c0136224 <pipe_read+b4/210>
Trace; c012ec04 <sys_read+94/d0>
Trace; c011aaa2 <sys_alarm+32/50>
Trace; c0106cea <system_call+32/38>
Code;  c0130044 <get_hash_table+84/90>
00000000 <_EIP>:
Code;  c0130044 <get_hash_table+84/90>   <=====
  0:   10 83 c4 04 5b 89         adc    %al,0x895b04c4(%ebx)   <=====
Code;  c013004a <get_hash_table+8a/90>
  6:   d0 5e 5f                  rcrb   0x5f(%esi)
Code;  c013004c <get_hash_table+8c/90>
  9:   5d                        pop    %ebp
Code;  c013004e <get_hash_table+8e/90>
  a:   c3                        ret
Code;  c013004e <get_hash_table+8e/90>
  b:   90                        nop
Code;  c0130050 <buffer_insert_inode_queue+0/40>
  c:   56                        push   %esi
Code;  c0130050 <buffer_insert_inode_queue+0/40>
  d:   53                        push   %ebx
Code;  c0130052 <buffer_insert_inode_queue+2/40>
  e:   8b 5c 24 0c               mov    0xc(%esp,1),%ebx
Code;  c0130056 <buffer_insert_inode_queue+6/40>
 12:   8b 74 00 00               mov    0x0(%eax,%eax,1),%esi 

<1>Unable to handle kernel paging request at virtual address 7fffffff
c0110dbc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110dbc>]    Not tainted
EFLAGS: 00010046
eax: 00000001   ebx: 7fffffff   ecx: fffffffe   edx: 7fffffff
esi: 00000046   edi: 00000001   ebp: e0a23e54   esp: e0a23e3c
ds: 0018   es: 0018   ss: 0018
Process lame (pid: 1855, stackpage=e0a23000)
Stack: 00000282 00000001 e1a5a92c e1a5a92c e07559cc e07559cc e46f34d8 
c0136761
      e62d82f4 c1a0e4bc c01367de e07559cc 00000001 00000001 c012f78d 
e07559cc
      e62d82f4 e1018bfc 00000001 00000000 c1a0f148 e62d82f4 00000000 
00000001
Call Trace: [<c0136761>] [<c01367de>] [<c012f78d>] [<c012e7d2>] [<c01158bc>]
  [<c0115e9b>] [<c0110d01>] [<c011b0fa>] [<c0106b8f>] [<c0136459>] 
[<c0136459>]
  [<c012ed01>] [<c0106d24>]
Code: 8b 03 89 c2 0f 0d 02 8b 45 f0 83 c0 04 39 c3 75 93 ff 75 e8 

>>EIP; c0110dbc <__wake_up+8c/b0>   <=====
Trace; c0136760 <pipe_release+70/90>
Trace; c01367de <pipe_rdwr_release+1e/30>
Trace; c012f78c <fput+4c/d0>
Trace; c012e7d2 <filp_close+52/60>
Trace; c01158bc <put_files_struct+4c/c0>
Trace; c0115e9a <do_exit+aa/1c0>
Trace; c0110d00 <schedule+2e0/310>
Trace; c011b0fa <dequeue_signal+6a/b0>
Trace; c0106b8e <do_signal+22e/2a0>
Trace; c0136458 <pipe_write+d8/280>
Trace; c0136458 <pipe_write+d8/280>
Trace; c012ed00 <sys_write+c0/d0>
Trace; c0106d24 <signal_return+14/18>
Code;  c0110dbc <__wake_up+8c/b0>
00000000 <_EIP>:
Code;  c0110dbc <__wake_up+8c/b0>   <=====
  0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0110dbe <__wake_up+8e/b0>
  2:   89 c2                     mov    %eax,%edx
Code;  c0110dc0 <__wake_up+90/b0>
  4:   0f 0d 02                  prefetch (%edx)
Code;  c0110dc2 <__wake_up+92/b0>
  7:   8b 45 f0                  mov    0xfffffff0(%ebp),%eax
Code;  c0110dc6 <__wake_up+96/b0>
  a:   83 c0 04                  add    $0x4,%eax
Code;  c0110dc8 <__wake_up+98/b0>
  d:   39 c3                     cmp    %eax,%ebx
Code;  c0110dca <__wake_up+9a/b0>
  f:   75 93                     jne    ffffffa4 <_EIP+0xffffffa4> c0110d60 
<__wake_up+30/b0>
Code;  c0110dcc <__wake_up+9c/b0>
 11:   ff 75 e8                  pushl  0xffffffe8(%ebp) 


1 warning issued.  Results may not be reliable. 

COMMANDS AND OTHER INFORMATION REGARDING MACHINE 

/* The Actual EIP lines are stated below.
* The bottom of the report contains
* the closest ranges listed as a result
* of running nm.
* the process that seemed to cause this
* was the newest version of LAME although
* I didn't have a problem until I added
* the boot parameter for the paging issue
* with AMD processors.
* if more data is needed let me know ;)
*/ 

Kernel Info: 

Linux bitch.abyss.za.org 2.4.17 #8 Sun Jan 13 15:19:58 CST 2002 i686 unknown 


:r!nm /usr/src/linux/vmlinux | sort | more | grep c0110d
c0110d30 T __wake_up
c0110de0 T __wake_up_sync 

:r!nm /usr/src/linux/vmlinux | sort | more | grep c01300
c0130050 T buffer_insert_inode_queue
c0130090 T buffer_insert_inode_data_queue
c01300d0 t __remove_inode_queue
c01300f0 T inode_has_buffers 

Any help/information is greatly appreciated :) 


/*-------------------------------------------------------*
* Lonny Selinger LPIC-1           Home:  (306) 924-5739 *
* Midrange Systems                Work:  (306) 525-7100 *
* Network Operational Support     Site:  (306) 657-3854 *
* EDS Canada Ltd.                 Pager: (866) 862-0627 *
* Regina/Saskatoon                Cell:  (306) 539-9857 *
*                                                       *
* Email:              lonny.selinger@eds.com            *
* Site Email:         lonny.selinger@lightsource.ca     *
*-------------------------------------------------------*/ 

