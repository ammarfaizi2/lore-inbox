Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTG2JGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTG2JGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:06:36 -0400
Received: from catv-50623e3b.bp11catv.broadband.hu ([80.98.62.59]:12301 "EHLO
	balabit.hu") by vger.kernel.org with ESMTP id S271335AbTG2JGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:06:34 -0400
Date: Tue, 29 Jul 2003 10:57:51 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: linux-kernel@vger.rutgers.edu
Subject: Oops in fs code (2.4.21-ac4)
Message-ID: <20030729085751.GA15922@balabit.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our box crashed with the following oops, though it continued to live for a
couple of minutes at the end it freezed completely.

All disk-partitions  contains ext3 with the following mount options:

/dev/ide/host0/bus0/target0/lun0/part1 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
/dev/ide/host0/bus0/target0/lun0/part3 on /home type ext3 (rw)
/dev/ide/host0/bus0/target0/lun0/part4 on /var type ext3 (rw)

The crash seems to be related to a mail loop, the MTA running on the box is
postfix. The box has a single processor.

The kernel is patched with the following patches:

- netfilter submitted patches (those submitted at 2.4.22pre7)
- our tproxy patch (version #18)
- freeswan
- the AIC7xxx driver from people.freebsd.org (it is not used in the box)
- 2.4.21-ac4

----- Forwarded message from Major Csaba <major@balabit.hu> -----

From: Major Csaba <major@balabit.hu>
To: bazsi@balabit.hu
Subject: oops
Date: Tue, 29 Jul 2003 10:18:13 +0200

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0125e4e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0125e4e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1070390   ecx: 010000c4   edx: c1070390
esi: 00000000   edi: 00000000   ebp: c2699184   esp: c2215f10
ds: 0018   es: 0018   ss: 0018
Process smtp (pid: 13916, stackpage=c2215000)
Stack: 00000000 c2215f48 00000000 c2699184 00000000 00000000 00000001 c2215f48
00000000 c0125fdb c26990c0 c397a800 c0257e80 c0798620 00000000 c01464e6
c2699184 00000000 00000000 c0798620 c26990c0 c10b5420 c0144166 c26990c0
Call Trace:    [<c0125fdb>] [<c01464e6>] [<c0144166>] [<c0134744>] [<c0133755>]
[<c01337a3>] [<c0108783>]
Code: 89 28 eb 0d 8b 03 89 68 04 89 45 00 89 5d 04 89 2b c7 44 24
 
 
>>EIP; c0125e4e <truncate_list_pages+86/1d0>   <=====
 
>>ebx; c1070390 <_end+d94f9c/4548c0c>
>>ecx; 010000c4 Before first symbol
>>edx; c1070390 <_end+d94f9c/4548c0c>
>>ebp; c2699184 <_end+23bdd90/4548c0c>
>>esp; c2215f10 <_end+1f3ab1c/4548c0c>
 
Trace; c0125fdb <truncate_inode_pages+43/6c>
Trace; c01464e6 <iput+b6/1c8>
Trace; c0144166 <dput+e6/144>
Trace; c0134744 <fput+bc/e0>
Trace; c0133755 <filp_close+59/64>
Trace; c01337a3 <sys_close+43/54>
Trace; c0108783 <system_call+33/40>
 
Code;  c0125e4e <truncate_list_pages+86/1d0>
00000000 <_EIP>:
Code;  c0125e4e <truncate_list_pages+86/1d0>   <=====
   0:   89 28                     mov    %ebp,(%eax)   <=====
Code;  c0125e50 <truncate_list_pages+88/1d0>
   2:   eb 0d                     jmp    11 <_EIP+0x11> c0125e5f <truncate_list_pages+97/1d0>
Code;  c0125e52 <truncate_list_pages+8a/1d0>
   4:   8b 03                     mov    (%ebx),%eax
Code;  c0125e54 <truncate_list_pages+8c/1d0>
   6:   89 68 04                  mov    %ebp,0x4(%eax)
Code;  c0125e57 <truncate_list_pages+8f/1d0>
   9:   89 45 00                  mov    %eax,0x0(%ebp)
Code;  c0125e5a <truncate_list_pages+92/1d0>
   c:   89 5d 04                  mov    %ebx,0x4(%ebp)
Code;  c0125e5d <truncate_list_pages+95/1d0>
   f:   89 2b                     mov    %ebp,(%ebx)
Code;  c0125e5f <truncate_list_pages+97/1d0>
  11:   c7 44 24 00 00 00 00      movl   $0x0,0x0(%esp,1)
Code;  c0125e66 <truncate_list_pages+9e/1d0>
  18:   00
 
 
2 warnings issued.  Results may not be reliable.


----- End forwarded message -----

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
