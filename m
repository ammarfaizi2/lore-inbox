Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271188AbTHLWKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 18:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHLWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 18:10:45 -0400
Received: from [205.200.104.254] ([205.200.104.254]:10266 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S271188AbTHLWKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 18:10:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3611E.90027EE8"
Subject: uinput oops and panic
Date: Tue, 12 Aug 2003 17:10:38 -0500
Message-ID: <18DFD6B776308241A200853F3F83D507169C68@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: uinput oops and panic
Thread-Index: AcNhHpBEg70/F7HdRVaw2l2KqwZSgg==
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3611E.90027EE8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Whenever I try to use the uinput sample program, I get an oops followed =
by a panic.  The problem also exists in 2.6.0-test3-mm1, but it's a =
little difficult for me to get the oops reports on my laptop without a =
serial port, so a report from 2.6.0-test1-ac3 is all I have.  I'm using =
uinput as a module, and preemptable or not, it still crashes.

ksymoops 2.4.9 on i686 2.6.0-test1-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test1-ac3/ (default)
     -m /proc/kallsyms (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address c642d000
c88488bf
*pde =3D 00019067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c88488bf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000246
eax: c642c004   ebx: c61fb004   ecx: ffffffea   edx: 40045565
esi: 00007f00   edi: 00000000   ebp: c551ff80   esp: c551ff70
ds: 007b   es: 007b   ss: 0068
Stack: 0000007b c55ef004 40045565 c8848830 c551ffbc c01946d5 c55280c4 =
c55ef004=20
       40045565 00007f00 bffffe24 c551e000 00000036 ffffffe7 00000001 =
c03621e0=20
       00000003 400098bc bffffe24 c551e000 c010afff 00000003 40045565 =
00007f00=20
Call Trace:
 [<c8848830>] uinput_ioctl+0x0/0x120 [uinput]
 [<c01946d5>] sys_ioctl+0x205/0x3f0
 [<c010afff>] syscall_call+0x7/0xb
Code: 0f ab 70 1c eb cd 8b 03 0f ab 70 18 eb c5 89 1c 24 e8 db f8=20


>>EIP; c88488bf <[uinput]uinput_ioctl+8f/120>   <=3D=3D=3D=3D=3D

>>eax; c642c004 <[ds]proc_bus+60067d4/83e67d0>
>>ebx; c61fb004 <[ds]proc_bus+5dd57d4/83e67d0>
>>ebp; c551ff80 <[ds]proc_bus+50fa750/83e67d0>
>>esp; c551ff70 <[ds]proc_bus+50fa740/83e67d0>

Trace; c8848830 <[uinput]uinput_ioctl+0/120>
Trace; c01946d5 <sys_ioctl+205/3f0>
Trace; c010afff <syscall_call+7/b>

Code;  c88488bf <[uinput]uinput_ioctl+8f/120>
00000000 <_EIP>:
Code;  c88488bf <[uinput]uinput_ioctl+8f/120>   <=3D=3D=3D=3D=3D
   0:   0f ab 70 1c               bts    %esi,0x1c(%eax)   =
<=3D=3D=3D=3D=3D
Code;  c88488c3 <[uinput]uinput_ioctl+93/120>
   4:   eb cd                     jmp    ffffffd3 <_EIP+0xffffffd3>
Code;  c88488c5 <[uinput]uinput_ioctl+95/120>
   6:   8b 03                     mov    (%ebx),%eax
Code;  c88488c7 <[uinput]uinput_ioctl+97/120>
   8:   0f ab 70 18               bts    %esi,0x18(%eax)
Code;  c88488cb <[uinput]uinput_ioctl+9b/120>
   c:   eb c5                     jmp    ffffffd3 <_EIP+0xffffffd3>
Code;  c88488cd <[uinput]uinput_ioctl+9d/120>
   e:   89 1c 24                  mov    %ebx,(%esp,1)
Code;  c88488d0 <[uinput]uinput_ioctl+a0/120>
  11:   e8 db f8 00 00            call   f8f1 <_EIP+0xf8f1>

CPU:    0
EIP:    0060:[<c8842351>]    Not tainted
EFLAGS: 00000216
eax: 0000003c   ebx: c65cc000   ecx: 0000000f   edx: 00000002
esi: ffffffff   edi: c63a6016   ebp: c563bea4   esp: c563be80
ds: 007b   es: 007b   ss: 0068
Stack: 0000004e 00000020 c013338d 0000003c c5ab1004 00000002 c72188e8 =
c65cc000=20
       00000000 c563bef0 c8841f81 c65cb004 00000000 000004b0 00000001 =
c0364328=20
       c563bef0 c03621e0 20000001 00000000 000004f3 00000000 0000004f =
00000000=20
Call Trace:
 [<c013338d>] update_wall_time+0xd/0x40
 [<c8841f81>] pcnet32_interrupt+0x3a1/0x580 [pcnet32]
 [<c010d37b>] handle_IRQ_event+0x3b/0x70
 [<c010d990>] do_IRQ+0x140/0x3a0
 [<c0133843>] run_timer_softirq+0x303/0x430
 [<c010b96c>] common_interrupt+0x18/0x20
 [<c010b96c>] common_interrupt+0x18/0x20
 [<c0194730>] sys_ioctl+0x260/0x3f0
 [<c010afff>] syscall_call+0x7/0xb
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 4d ec 8b 41 64 01=20


>>EIP; c8842351 <[pcnet32]pcnet32_rx+1f1/350>   <=3D=3D=3D=3D=3D

>>ebx; c65cc000 <[ds]proc_bus+61a67d0/83e67d0>
>>edi; c63a6016 <[ds]proc_bus+5f807e6/83e67d0>
>>ebp; c563bea4 <[ds]proc_bus+5216674/83e67d0>
>>esp; c563be80 <[ds]proc_bus+5216650/83e67d0>

Trace; c013338d <update_wall_time+d/40>
Trace; c8841f81 <[pcnet32]pcnet32_interrupt+3a1/580>
Trace; c010d37b <handle_IRQ_event+3b/70>
Trace; c010d990 <do_IRQ+140/3a0>
Trace; c0133843 <run_timer_softirq+303/430>
Trace; c010b96c <common_interrupt+18/20>
Trace; c010b96c <common_interrupt+18/20>
Trace; c0194730 <sys_ioctl+260/3f0>
Trace; c010afff <syscall_call+7/b>

Code;  c8842351 <[pcnet32]pcnet32_rx+1f1/350>
00000000 <_EIP>:
Code;  c8842351 <[pcnet32]pcnet32_rx+1f1/350>   <=3D=3D=3D=3D=3D
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   =
<=3D=3D=3D=3D=3D
Code;  c8842353 <[pcnet32]pcnet32_rx+1f3/350>
   2:   a8 02                     test   $0x2,%al
Code;  c8842355 <[pcnet32]pcnet32_rx+1f5/350>
   4:   74 02                     je     8 <_EIP+0x8>
Code;  c8842357 <[pcnet32]pcnet32_rx+1f7/350>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c8842359 <[pcnet32]pcnet32_rx+1f9/350>
   8:   a8 01                     test   $0x1,%al
Code;  c884235b <[pcnet32]pcnet32_rx+1fb/350>
   a:   74 01                     je     d <_EIP+0xd>
Code;  c884235d <[pcnet32]pcnet32_rx+1fd/350>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c884235e <[pcnet32]pcnet32_rx+1fe/350>
   d:   8b 4d ec                  mov    0xffffffec(%ebp),%ecx
Code;  c8842361 <[pcnet32]pcnet32_rx+201/350>
  10:   8b 41 64                  mov    0x64(%ecx),%eax
Code;  c8842364 <[pcnet32]pcnet32_rx+204/350>
  13:   01 00                     add    %eax,(%eax)

 <0>Kernel panic: Fatal exception in interrupt

1 error issued.  Results may not be reliable.

------_=_NextPart_001_01C3611E.90027EE8
Content-Type: application/octet-stream;
	name="uinput_sample.c"
Content-Transfer-Encoding: base64
Content-Description: uinput_sample.c
Content-Disposition: attachment;
	filename="uinput_sample.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy9z
dGF0Lmg+CiNpbmNsdWRlIDxmY250bC5oPgoKI2luY2x1ZGUgPGFzbS90eXBlcy5oPgojaW5jbHVk
ZSA8bGludXgvaW5wdXQuaD4KI2luY2x1ZGUgPGxpbnV4L3VpbnB1dC5oPgoKaW50IG1haW4oaW50
IGFyZ24sIGNoYXIgKmFyZ3ZbXSkKewoJc3RydWN0IHVpbnB1dF91c2VyX2RldglkZXZpY2U7Cglz
dHJ1Y3QgaW5wdXRfZXZlbnQJZXZlbnQ7CglpbnQJCQlmZCwgY250ID0gMDsKCXVuc2lnbmVkIGNo
YXIJCWF1eDsKCWNoYXIgYnVmZls4MF07CgoJLyogb3BlbiB1aW5wdXQgZGV2aWNlIGZpbGUgKi8K
CWZkID0gb3BlbigiL2Rldi9pbnB1dC91aW5wdXQiLCBPX1JEV1IpOwoJaWYgKGZkIDwgMCkgewoJ
CXBlcnJvcigib3BlbiIpOwoJCXJldHVybiBmZDsKCX0KCgkvKiBzZXRzIHRoZSBuYW1lIG9mIG91
ciBkZXZpY2UgKi8KCXN0cmNweShkZXZpY2UubmFtZSwgInRlc3Qga2V5Ym9hcmQiKTsKCgkvKiBp
bmZvcm0gdGhhdCB3ZSdsbCBnZW5lcmF0ZSBrZXkgZXZlbnRzICovCglpb2N0bChmZCwgVUlfU0VU
X0VWQklULCBFVl9LRVkpOwoKCS8qIHNldCBrZXkgZXZlbnRzIHdlIGNhbiBnZW5lcmF0ZSAoaW4g
dGhpcyBjYXNlLCBhbGwpICovCglmb3IgKGF1eCA9IDE7IGF1eCA8IDIwNzsgY250ICsrKQoJCWlv
Y3RsKGZkLCBVSV9TRVRfS0VZQklULCBjbnQpOwpleGl0KDApOwoKCS8qIHdyaXRlIGRvd24gaW5m
b3JtYXRpb24gZm9yIGNyZWF0aW5nIGEgbmV3IGRldmljZSAqLwoJaWYgKHdyaXRlKGZkLCAmZGV2
aWNlLCBzaXplb2Yoc3RydWN0IHVpbnB1dF91c2VyX2RldikpIDwgMCkgewoJCXBlcnJvcigid3Jp
dGUiKTsKCQljbG9zZShmZCk7CgkJcmV0dXJuIDE7Cgl9CgoJLyogYWN0dWFsbHkgY3JlYXRlcyB0
aGUgZGV2aWNlICovCglpb2N0bChmZCwgVUlfREVWX0NSRUFURSk7CgoJY2xvc2UoZmQpOwoJCgly
ZXR1cm4gMDsKfQoK

------_=_NextPart_001_01C3611E.90027EE8--
