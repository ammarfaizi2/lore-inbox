Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUAUWpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbUAUWpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:45:19 -0500
Received: from gw.linuxforce.net ([207.106.35.93]:2697 "EHLO
	linux00.LinuxForce.net") by vger.kernel.org with ESMTP
	id S266139AbUAUWpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:45:08 -0500
Date: Wed, 21 Jan 2004 17:41:56 -0500
From: Stephen Gran <steve@linuxforce.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel oops report
Message-ID: <20040121224156.GA6243@linux00.LinuxForce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Editor: VIM - Vi IMproved 6.1 
X-OS: Linux linux00 2.4.18-1-686-smp i686
X-Uptime: 42 days
X-Date: Today is Sweetmorn, the 21st day of Chaos in the YOLD 3170
X-DDate: Only 2431586 Shopping Days Left Before X-Day. Kallisti! 
X-Motto: debian/rules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I am sorry if this is not the right place to send this, but this is my
first oops report (shows how good you normally are :)

Background - dual k6 box, with raid array and 1 gb RAM.  Fairly busy
webserver, but not significantly loaded (uptime says >1 for all).

If you need any more information, I will be happy to try to help debug
this.  I'm guessing it's a problem in the k6 smp code, but I can't be
sure.

afradm@www01:~$ ksymoops < oops.txt
ksymoops 2.4.5 on i686 2.4.24-xertus-1-k6-smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24-xertus-1-k6-smp/ (default)
     -m /boot/System.map-2.4.24-xertus-1-k6-smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan 21 16:44:09 www01 kernel: Unable to handle kernel paging request at virtual address 01000100
Jan 21 16:44:09 www01 kernel: c0134446
Jan 21 16:44:09 www01 kernel: *pde = 3454c001
Jan 21 16:44:09 www01 kernel: Oops: 0000
Jan 21 16:44:09 www01 kernel: CPU:    1
Jan 21 16:44:09 www01 kernel: EIP:    0010:[kfree+70/160]    Not tainted
Jan 21 16:44:09 www01 kernel: EFLAGS: 00010006
Jan 21 16:44:09 www01 kernel: eax: 00000004   ebx: 01000100   ecx: c1a5fe00   edx: c1000020
Jan 21 16:44:09 www01 kernel: esi: e80f321c   edi: 00000282   ebp: 00000003   esp: dc553f30
Jan 21 16:44:09 www01 kernel: ds: 0018   es: 0018   ss: 0018
Jan 21 16:44:09 www01 kernel: Process dpkg (pid: 21420, stackpage=dc553000)
Jan 21 16:44:09 www01 kernel: Stack: f6908240 e88f31c0 e88efcc0 e80f321c c01524ee e80f321c ea8dc840 ea8dc840
Jan 21 16:44:09 www01 kernel:        ea929450 ea9293c0 c015280d 0000000f ea8dc840 c014a6b4 ea8dc840 ea8d82d0
Jan 21 16:44:09 www01 kernel:        c014a8b9 ea8dc840 ea8dc840 ea8dc840 dd0ab000 dc553fa4 c014aa60 ea9293c0
Jan 21 16:44:09 www01 kernel: Call Trace:    [prune_dcache+286/384] [shrink_dcache_parent+13/32] [d_unhash+68/128] [vfs_rmdir+457/704] [sys_rmdir+176/256]
Jan 21 16:44:09 www01 kernel: Code: 8b 13 89 d0 3b 43 04 73 08 89 74 83 08 ff 03 eb 39 8b 41 28
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; 01000100 Before first symbol
>>ecx; c1a5fe00 <_end+15b9930/38434b30>
>>edx; c1000020 <_end+b59b50/38434b30>
>>esi; e80f321c <_end+27c4cd4c/38434b30>
>>esp; dc553f30 <_end+1c0ada60/38434b30>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 13                     mov    (%ebx),%edx
Code;  00000002 Before first symbol
   2:   89 d0                     mov    %edx,%eax
Code;  00000004 Before first symbol
   4:   3b 43 04                  cmp    0x4(%ebx),%eax
Code;  00000007 Before first symbol
   7:   73 08                     jae    11 <_EIP+0x11> 00000011 Before first symbol
Code;  00000009 Before first symbol
   9:   89 74 83 08               mov    %esi,0x8(%ebx,%eax,4)
Code;  0000000d Before first symbol
   d:   ff 03                     incl   (%ebx)
Code;  0000000f Before first symbol
   f:   eb 39                     jmp    4a <_EIP+0x4a> 0000004a Before first symbol
Code;  00000011 Before first symbol
  11:   8b 41 28                  mov    0x28(%ecx),%eax


1 warning issued.  Results may not be reliable.


afradm@www01:~$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux www01 2.4.24-xertus-1-k6-smp #1 SMP Thu Jan 8 13:04:42 EST 2004 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.12.90.0.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ipt_limit ipt_state ipt_multiport ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ip_nat_ftp ip_conntrack_ftp iptable_nat ip_conntrack iptable_mangle iptable_filter ip_tables af_packet

Thanks,
-- 
 --------------------------------------------------------------------------
|  Stephen Gran                  | Divorce is a game played by lawyers.    |
|  steve@linuxforce.net          | -- Cary Grant                           |
|  http://www.linuxforce.net     |                                         |
 --------------------------------------------------------------------------
