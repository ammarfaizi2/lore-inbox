Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbQLHTrH>; Fri, 8 Dec 2000 14:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbQLHTq5>; Fri, 8 Dec 2000 14:46:57 -0500
Received: from [207.107.233.99] ([207.107.233.99]:39697 "EHLO
	posto.microflex.ca") by vger.kernel.org with ESMTP
	id <S131197AbQLHTqq>; Fri, 8 Dec 2000 14:46:46 -0500
Reply-To: <jna@microflex.ca>
From: "Jean-Francois Nadeau" <jna@microflex.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel oops 2.2.17
Date: Fri, 8 Dec 2000 14:14:31 -0500
Message-ID: <001d01c0614b$1886c1e0$a11410ac@microflex.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We run a heavily accessed Apache 1.3.6 Web server on a Redhat 6.0 distro
over 2.2.17.  We upgraded from 2.2.16 and I now got some kernel oops.

System is :

AMD Athlon 600 Mhz.
512 MB RAM.
gcc version egcs-2.91.66
glibc 2.1.3-21

Kernel tweaks :

echo 1 > /proc/sys/net/ipv4/tcp_syncookies
echo 1 > /proc/sys/net/ipv4/conf/all/hidden
echo 1 > /proc/sys/net/ipv4/conf/lo/hidden
echo 60 > /proc/sys/net/ipv4/tcp_fin_timeout
echo 16384 > /proc/sys/fs/file-max
echo 32768 > /proc/sys/fs/inode-max


I had 5 kernel Oops on the "tar" process every day. (it starts a backup
every morning).  Then,  the master httpsd stops working and could not be
killed (even with kill -9 !).

Something strange is that it crashed at the same virtual address :

Dec  5 06:03:20 trinity kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Dec  6 06:03:01 trinity kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Dec  7 06:03:06 trinity kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Dec  7 17:01:54 trinity kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Dec  8 06:03:02 trinity kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010


Here's the output from ksymoops for the httpsd crash.

-----------------------
No modules in ksyms, skipping objects
Warning, no symbols in lsmod, is /proc/modules a valid lsmod file?
Dec  7 17:01:54 trinity kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Dec  7 17:01:54 trinity kernel: current->tss.cr3 = 03f00000, %%cr3 =
03f00000
Dec  7 17:01:54 trinity kernel: *pde = 00000000
Dec  7 17:01:54 trinity kernel: Oops: 0000
Dec  7 17:01:54 trinity kernel: CPU:    0
Dec  7 17:01:54 trinity kernel: EIP:
0010:[update_vm_cache_conditional+138/328]
Dec  7 17:01:54 trinity kernel: EFLAGS: 00010202
Dec  7 17:01:54 trinity kernel: eax: 00000000   ebx: cb255ed0   ecx:
00000008   edx: 00000008
Dec  7 17:01:54 trinity kernel: esi: 00000000   edi: 0001ffff   ebp:
00000400   esp: c1fb5e9c
Dec  7 17:01:54 trinity kernel: ds: 0018   es: 0018   ss: 0018
Dec  7 17:01:54 trinity kernel: Process httpsd (pid: 21775, process nr: 127,
stackpage=c1fb5000)
Dec  7 17:01:54 trinity kernel: Stack: cb255ed0 cf1d0c00 00000008 0cb255ed
c0138ba1 cb255ed0 0000d000 cf1d0c00
Dec  7 17:01:54 trinity kernel:        00000400 40349000 cf66f660 ffffffea
cb255f1c 00001000 c9bf8300 c9bf8300
Dec  7 17:01:54 trinity kernel:        c9bf8300 c1fb5f08 0000d000 00000000
00000000 00000000 dd6b9a00 00000000
Dec  7 17:01:54 trinity kernel: Call Trace: [ext2_file_write+1045/1572]
[__kfree_skb+161/168] [boomerang_interrupt+700/908] [u
Dec  7 17:01:54 trinity kernel: Code: 39 59 08 75 e1 8b 5c 24 20 39 59 0c 75
d8 ff 41 14 b8 02 00
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 39 59 08 75 e1 8b 5c 24 20 39 59 0c 75 d8 ff 41 14 b8 02 00
'
  Garbage: '  '

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    39 59 08
cmpl   %ebx,0x8(%ecx) <===
Code:  00000003 Before first symbol               3:    75 e1
jne     ffffffe6 <END_OF_CODE+3fdb01be/????>
Code:  00000005 Before first symbol               5:    8b 5c 24 20
movl   0x20(%esp,1),%ebx
Code:  00000009 Before first symbol               9:    39 59 0c
cmpl   %ebx,0xc(%ecx)
Code:  0000000c Before first symbol               c:    75 d8
jne     ffffffe6 <END_OF_CODE+3fdb01be/????>
Code:  0000000e Before first symbol               e:    ff 41 14
incl   0x14(%ecx)
Code:  00000011 Before first symbol              11:    b8 02 00 00 00
movl   $0x2,%eax


5 warnings issued.  Results may not be reliable.

-----------------------



Do you have any idea of the problem ?

Regards,

Jean-Francois Nadeau
Network Administrator at Microflex
(418)694-2300 ext.141

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
