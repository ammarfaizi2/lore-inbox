Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318748AbSHNNyz>; Wed, 14 Aug 2002 09:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSHNNyz>; Wed, 14 Aug 2002 09:54:55 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:34246 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S318748AbSHNNyy> convert rfc822-to-8bit;
	Wed, 14 Aug 2002 09:54:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "Ph. Marek" <marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: OOPS in proc_get_inode
Date: Wed, 14 Aug 2002 15:59:17 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208141559.17079.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I get an OOPS in proc_get_inode.
It shows with the sa (sadc) processes hanging in D state and the /proc/net 
directory inaccessible - every ls in there hangs in D too.

This is a dual P III 1GHz. Linux 2.4.19pre1 SMP.


I can't say for sure just now but it seem to happen on load OR unload of 
modules - which links this oops to 
	http://lkml.org/archive/2000/10/2/110/index.html
Does anybody can tell me about this oops or what informations are needed?


To track the problem down I already did a 
	while true
	do
		ls -la  ; cat dev ;	cat sockstat
	done
in one console and
	modprobe -a -k \* ; rmmod -a
in another.
But this problem does not always show up.
It MAY be the 8390 module as this is the last in syslog before the oops.

Every help is appreciated!


Regards,

Phil



ksymoops 2.4.2 on i686 2.4.19pre1.  Options used
     -v /tmp/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address f91ac010
c01541a0
*pde = 37b05067
Oops: 0002
CPU:    0
EIP:    0010:[<c01541a0>]    Not tainted
EFLAGS: 00010286
eax: f91ac000   ebx: c3372da0   ecx: 00000001   edx: 00000003
esi: f48a5800   edi: c3372df3   ebp: f48a59e0   esp: dbe0ff00
ds: 0018   es: 0018   ss: 0018
Process find (pid: 26529, stackpage=dbe0f000)
Stack: c2b92a20 c2b92a83 c0155e0c c201f400 00001233 c3372da0 fffffff4 f48a59e0
       dbe0e000 c2b92a20 ffffffea c0140ff2 f48a59e0 c2b92a20 dbe0ff74 00000000
       dbe0ffa4 00000008 c0141728 c2b92aa0 dbe0ff74 00000000 f408d000 00000000
Call Trace: [<c0155e0c>] [<c0140ff2>] [<c0141728>] [<c014198a>] [<c0141e01>]
   [<c013e8d9>] [<c0136d2f>] [<c010708f>]
Code: f0 ff 40 10 8b 43 24 80 48 14 18 8b 43 18 85 c0 74 06 89 86

>>EIP; c01541a0 <proc_get_inode+9c/110>   <=====
Trace; c0155e0c <proc_lookup+70/94>
Trace; c0140ff2 <real_lookup+7a/108>
Trace; c0141728 <link_path_walk+590/7d8>
Trace; c014198a <path_walk+1a/1c>
Trace; c0141e00 <__user_walk+34/50>
Trace; c013e8d8 <sys_lstat64+18/70>
Trace; c0136d2e <sys_close+5a/70>
Trace; c010708e <system_call+32/38>
Code;  c01541a0 <proc_get_inode+9c/110>
00000000 <_EIP>:
Code;  c01541a0 <proc_get_inode+9c/110>   <=====
   0:   f0 ff 40 10               lock incl 0x10(%eax)   <=====
Code;  c01541a4 <proc_get_inode+a0/110>
   4:   8b 43 24                  mov    0x24(%ebx),%eax
Code;  c01541a6 <proc_get_inode+a2/110>
   7:   80 48 14 18               orb    $0x18,0x14(%eax)
Code;  c01541aa <proc_get_inode+a6/110>
   b:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c01541ae <proc_get_inode+aa/110>
   e:   85 c0                     test   %eax,%eax
Code;  c01541b0 <proc_get_inode+ac/110>
  10:   74 06                     je     18 <_EIP+0x18> c01541b8 
<proc_get_inode+b4/110>
Code;  c01541b2 <proc_get_inode+ae/110>
  12:   89 86 00 00 00 00         mov    %eax,0x0(%esi)


