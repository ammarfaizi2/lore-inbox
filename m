Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272282AbRILRiM>; Wed, 12 Sep 2001 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272272AbRILRiF>; Wed, 12 Sep 2001 13:38:05 -0400
Received: from home.nohrsc.nws.gov ([192.46.108.2]:40576 "HELO nohrsc.nws.gov")
	by vger.kernel.org with SMTP id <S272282AbRILRhx>;
	Wed, 12 Sep 2001 13:37:53 -0400
Date: Wed, 12 Sep 2001 12:38:09 -0500 (CDT)
From: kelley eicher <keicher@nws.gov>
X-X-Sender: <keicher@home.nohrsc.nws.gov>
To: <linux-kernel@vger.kernel.org>
cc: kelley eicher <keicher@nws.gov>
Subject: Re: 2.4.9-10pre4 kernel: __alloc_pages errors
Message-ID: <Pine.LNX.4.33.0109121203490.6363-400000@home.nohrsc.nws.gov>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="784335468-891059326-1000316289=:6363"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--784335468-891059326-1000316289=:6363
Content-Type: TEXT/PLAIN; charset=US-ASCII

all-

after upgrading to the 2.4.10-pre6 kernel i still have no luck in avoiding
alloc_pages() errors.

this time i have included an kernel oops dump by calling BUG() from
mm/page_alloc.c immediately after the call to printk() that prints
__alloc_pages errors. i have also included the `ksymoops` interpretation
of that oops. coincidentally, i was able to grab a partial `cat` of
/proc/slabinfo milliseonds before the oops so i've attached that as well.

again, the alloc_page() errors that i'm constantly seeing are 0-order with
gfp=0x70/1

oops1.txt --------------------------------------------------------------

ofs1# more oops1.txt
Sep 12 11:30:15 ofs1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x70/1).
Sep 12 11:30:15 ofs1 kernel: invalid operand: 0000
Sep 12 11:30:15 ofs1 kernel: CPU:    0
Sep 12 11:30:15 ofs1 kernel: EIP:    0010:[__alloc_pages+591/604]
Sep 12 11:30:15 ofs1 kernel: EFLAGS: 00010286
Sep 12 11:30:15 ofs1 kernel: eax: 0000003a   ebx: 00000000   ecx: f7df6000
edx: 00000000
Sep 12 11:30:15 ofs1 kernel: esi: c028b208   edi: 00000000   ebp: f7df6000
esp: f7df7e74
Sep 12 11:30:15 ofs1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 12 11:30:15 ofs1 kernel: Process kswapd (pid: 4, stackpage=f7df7000)
Sep 12 11:30:15 ofs1 kernel: Stack: 00000070 00000001 00000008 c02f7a00
00000001 c028b1fc 00000070 c012700e
Sep 12 11:30:15 ofs1 kernel:        c0415a20 c012a499 c0415a20 c012a5ac
f4ac0240 00000001 00000008 c02f7a00
Sep 12 11:30:15 ofs1 kernel:        c01a97c7 00000001 f4ac0240 00003009
f4ac0240 1f9f8d60 19a175af c02f7a28
Sep 12 11:30:15 ofs1 kernel: Call Trace: [_alloc_pages+22/24]
[alloc_bounce_page+13/120] [create_bounce+40/380]
[__make_request+135/1596] [ip_rcv+806/860]
Sep 12 11:30:15 ofs1 kernel:    [generic_make_request+288/304]
[submit_bh+69/96] [ll_rw_block+299/396] [sync_page_buffers+71/84]
[try_to_free_buffers+281/316] [page_launder+603/1376]
Sep 12 11:30:15 ofs1 kernel:    [do_try_to_free_pages+64/184]
[kswapd+105/172] [kernel_thread+40/56]
Sep 12 11:30:15 ofs1 kernel:
Sep 12 11:30:15 ofs1 kernel: Code: 0f 0b 31 c0 5b 5e 5f 5d 83 c4 0c c3 90
83 fa 09 77 09 e8 82

--------------------------------------------------------------------------



ksymoops output: ---------------------------------------------------------

ofs1# ./ksymoops -m /kernel/System.map < oops1.txt
ksymoops 2.4.2 on i686 2.4.10-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre6/ (default)
     -m /kernel/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01f6a80, System.map says c0145bd0.  Ignoring ksyms_base entry
Sep 12 11:30:15 ofs1 kernel: invalid operand: 0000
Sep 12 11:30:15 ofs1 kernel: CPU:    0
Sep 12 11:30:15 ofs1 kernel: EIP:    0010:[__alloc_pages+591/604]
Sep 12 11:30:15 ofs1 kernel: EFLAGS: 00010286
Sep 12 11:30:15 ofs1 kernel: eax: 0000003a   ebx: 00000000   ecx: f7df6000
edx: 00000000
Sep 12 11:30:15 ofs1 kernel: esi: c028b208   edi: 00000000   ebp: f7df6000
esp: f7df7e74
Sep 12 11:30:15 ofs1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 12 11:30:15 ofs1 kernel: Process kswapd (pid: 4, stackpage=f7df7000)
Sep 12 11:30:15 ofs1 kernel: Stack: 00000070 00000001 00000008 c02f7a00
00000001 c028b1fc 00000070 c012700e
Sep 12 11:30:15 ofs1 kernel:        c0415a20 c012a499 c0415a20 c012a5ac
f4ac0240 00000001 00000008 c02f7a00
Sep 12 11:30:15 ofs1 kernel:        c01a97c7 00000001 f4ac0240 00003009
f4ac0240 1f9f8d60 19a175af c02f7a28
Sep 12 11:30:15 ofs1 kernel: Call Trace: [_alloc_pages+22/24]
[alloc_bounce_page+13/120] [create_bounce+40/380]
[__make_request+135/1596] [ip_rcv+806/860]
Sep 12 11:30:15 ofs1 kernel: Code: 0f 0b 31 c0 5b 5e 5f 5d 83 c4 0c c3 90
83 fa 09 77 09 e8 82
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   31 c0                     xorl   %eax,%eax
Code;  00000004 Before first symbol
   4:   5b                        popl   %ebx
Code;  00000004 Before first symbol
   5:   5e                        popl   %esi
Code;  00000006 Before first symbol
   6:   5f                        popl   %edi
Code;  00000006 Before first symbol
   7:   5d                        popl   %ebp
Code;  00000008 Before first symbol
   8:   83 c4 0c                  addl   $0xc,%esp
Code;  0000000a Before first symbol
   b:   c3                        ret
Code;  0000000c Before first symbol
   c:   90                        nop
Code;  0000000c Before first symbol
   d:   83 fa 09                  cmpl   $0x9,%edx
Code;  00000010 Before first symbol
  10:   77 09                     ja     1b <_EIP+0x1b> 0000001a Before
first symbol
Code;  00000012 Before first symbol
  12:   e8 82 00 00 00            call   99 <_EIP+0x99> 00000098 Before
first symbol


1 warning issued.  Results may not be reliable.
ofs1#
--------------------------------------------------------------------------



/proc/slabinfo ---------------*partial*-----------------------------------

kmem_cache            58     68    112    2    2    1
ip_conntrack          25     33    352    3    3    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        9    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        5     59     64    1    1    1
ip_fib_hash           10    113     32    1    1    1
ip_dst_cache          38     48    160    2    2    1
arp_cache             11     30    128    1    1    1
blkdev_requests      512    520     96   13   13    1
nfs_read_data          0      0    384    0    0    1
nfs_write_data         0      0    384    0    0    1
nfs_page               0      0     96    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        2     42     92    1    1    1
fasync cache           0      0     16    0    0    1
uid_cache              6    113     32    1    1    1
skbuff_head_cache    229    264    160   11   11    1
sock                  31     36    832    4    4    2
sigqueue               0      0    132    0    0    1
cdev_cache            16     59     64    1    1    1
bdev_cache             8     59     64    1    1    1

------------------------------------------------------------------------

i can probide any additional information neccessary to help you debug this
problem.

for ease of use, i have attached the 3 files pasted above as oops1.txt,
ksymoops1.txt and slabinfo1.txt respectively.

thanx,
-kelley

ps: my thoughts to those of you with any family involved in yesterday's
most heinous event.


--784335468-891059326-1000316289=:6363
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ksymoops1.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109121238090.6363@home.nohrsc.nws.gov>
Content-Description: 
Content-Disposition: attachment; filename="ksymoops1.txt"

b2ZzMSMgLi9rc3ltb29wcyAtbSAva2VybmVsL1N5c3RlbS5tYXAgPCBvb3Bz
MS50eHQNCmtzeW1vb3BzIDIuNC4yIG9uIGk2ODYgMi40LjEwLXByZTYuICBP
cHRpb25zIHVzZWQNCiAgICAgLVYgKGRlZmF1bHQpDQogICAgIC1rIC9wcm9j
L2tzeW1zIChkZWZhdWx0KQ0KICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZh
dWx0KQ0KICAgICAtbyAvbGliL21vZHVsZXMvMi40LjEwLXByZTYvIChkZWZh
dWx0KQ0KICAgICAtbSAva2VybmVsL1N5c3RlbS5tYXAgKHNwZWNpZmllZCkN
Cg0KV2FybmluZyAoY29tcGFyZV9tYXBzKTogbWlzbWF0Y2ggb24gc3ltYm9s
IHBhcnRpdGlvbl9uYW1lICAsIGtzeW1zX2Jhc2Ugc2F5cyBjMDFmNmE4MCwg
U3lzdGVtLm1hcCBzYXlzIGMwMTQ1YmQwLiAgSWdub3Jpbmcga3N5bXNfYmFz
ZSBlbnRyeQ0KU2VwIDEyIDExOjMwOjE1IG9mczEga2VybmVsOiBpbnZhbGlk
IG9wZXJhbmQ6IDAwMDANClNlcCAxMiAxMTozMDoxNSBvZnMxIGtlcm5lbDog
Q1BVOiAgICAwDQpTZXAgMTIgMTE6MzA6MTUgb2ZzMSBrZXJuZWw6IEVJUDog
ICAgMDAxMDpbX19hbGxvY19wYWdlcys1OTEvNjA0XQ0KU2VwIDEyIDExOjMw
OjE1IG9mczEga2VybmVsOiBFRkxBR1M6IDAwMDEwMjg2DQpTZXAgMTIgMTE6
MzA6MTUgb2ZzMSBrZXJuZWw6IGVheDogMDAwMDAwM2EgICBlYng6IDAwMDAw
MDAwICAgZWN4OiBmN2RmNjAwMCAgIGVkeDogMDAwMDAwMDANClNlcCAxMiAx
MTozMDoxNSBvZnMxIGtlcm5lbDogZXNpOiBjMDI4YjIwOCAgIGVkaTogMDAw
MDAwMDAgICBlYnA6IGY3ZGY2MDAwICAgZXNwOiBmN2RmN2U3NA0KU2VwIDEy
IDExOjMwOjE1IG9mczEga2VybmVsOiBkczogMDAxOCAgIGVzOiAwMDE4ICAg
c3M6IDAwMTgNClNlcCAxMiAxMTozMDoxNSBvZnMxIGtlcm5lbDogUHJvY2Vz
cyBrc3dhcGQgKHBpZDogNCwgc3RhY2twYWdlPWY3ZGY3MDAwKQ0KU2VwIDEy
IDExOjMwOjE1IG9mczEga2VybmVsOiBTdGFjazogMDAwMDAwNzAgMDAwMDAw
MDEgMDAwMDAwMDggYzAyZjdhMDAgMDAwMDAwMDEgYzAyOGIxZmMgMDAwMDAw
NzAgYzAxMjcwMGUgDQpTZXAgMTIgMTE6MzA6MTUgb2ZzMSBrZXJuZWw6ICAg
ICAgICBjMDQxNWEyMCBjMDEyYTQ5OSBjMDQxNWEyMCBjMDEyYTVhYyBmNGFj
MDI0MCAwMDAwMDAwMSAwMDAwMDAwOCBjMDJmN2EwMCANClNlcCAxMiAxMToz
MDoxNSBvZnMxIGtlcm5lbDogICAgICAgIGMwMWE5N2M3IDAwMDAwMDAxIGY0
YWMwMjQwIDAwMDAzMDA5IGY0YWMwMjQwIDFmOWY4ZDYwIDE5YTE3NWFmIGMw
MmY3YTI4IA0KU2VwIDEyIDExOjMwOjE1IG9mczEga2VybmVsOiBDYWxsIFRy
YWNlOiBbX2FsbG9jX3BhZ2VzKzIyLzI0XSBbYWxsb2NfYm91bmNlX3BhZ2Ur
MTMvMTIwXSBbY3JlYXRlX2JvdW5jZSs0MC8zODBdIFtfX21ha2VfcmVxdWVz
dCsxMzUvMTU5Nl0gW2lwX3Jjdis4MDYvODYwXSANClNlcCAxMiAxMTozMDox
NSBvZnMxIGtlcm5lbDogQ29kZTogMGYgMGIgMzEgYzAgNWIgNWUgNWYgNWQg
ODMgYzQgMGMgYzMgOTAgODMgZmEgMDkgNzcgMDkgZTggODIgDQpVc2luZyBk
ZWZhdWx0cyBmcm9tIGtzeW1vb3BzIC10IGVsZjMyLWkzODYgLWEgaTM4Ng0K
DQpDb2RlOyAgMDAwMDAwMDAgQmVmb3JlIGZpcnN0IHN5bWJvbA0KMDAwMDAw
MDAgPF9FSVA+Og0KQ29kZTsgIDAwMDAwMDAwIEJlZm9yZSBmaXJzdCBzeW1i
b2wNCiAgIDA6ICAgMGYgMGIgICAgICAgICAgICAgICAgICAgICB1ZDJhICAg
DQpDb2RlOyAgMDAwMDAwMDIgQmVmb3JlIGZpcnN0IHN5bWJvbA0KICAgMjog
ICAzMSBjMCAgICAgICAgICAgICAgICAgICAgIHhvcmwgICAlZWF4LCVlYXgN
CkNvZGU7ICAwMDAwMDAwNCBCZWZvcmUgZmlyc3Qgc3ltYm9sDQogICA0OiAg
IDViICAgICAgICAgICAgICAgICAgICAgICAgcG9wbCAgICVlYngNCkNvZGU7
ICAwMDAwMDAwNCBCZWZvcmUgZmlyc3Qgc3ltYm9sDQogICA1OiAgIDVlICAg
ICAgICAgICAgICAgICAgICAgICAgcG9wbCAgICVlc2kNCkNvZGU7ICAwMDAw
MDAwNiBCZWZvcmUgZmlyc3Qgc3ltYm9sDQogICA2OiAgIDVmICAgICAgICAg
ICAgICAgICAgICAgICAgcG9wbCAgICVlZGkNCkNvZGU7ICAwMDAwMDAwNiBC
ZWZvcmUgZmlyc3Qgc3ltYm9sDQogICA3OiAgIDVkICAgICAgICAgICAgICAg
ICAgICAgICAgcG9wbCAgICVlYnANCkNvZGU7ICAwMDAwMDAwOCBCZWZvcmUg
Zmlyc3Qgc3ltYm9sDQogICA4OiAgIDgzIGM0IDBjICAgICAgICAgICAgICAg
ICAgYWRkbCAgICQweGMsJWVzcA0KQ29kZTsgIDAwMDAwMDBhIEJlZm9yZSBm
aXJzdCBzeW1ib2wNCiAgIGI6ICAgYzMgICAgICAgICAgICAgICAgICAgICAg
ICByZXQgICAgDQpDb2RlOyAgMDAwMDAwMGMgQmVmb3JlIGZpcnN0IHN5bWJv
bA0KICAgYzogICA5MCAgICAgICAgICAgICAgICAgICAgICAgIG5vcCAgICAN
CkNvZGU7ICAwMDAwMDAwYyBCZWZvcmUgZmlyc3Qgc3ltYm9sDQogICBkOiAg
IDgzIGZhIDA5ICAgICAgICAgICAgICAgICAgY21wbCAgICQweDksJWVkeA0K
Q29kZTsgIDAwMDAwMDEwIEJlZm9yZSBmaXJzdCBzeW1ib2wNCiAgMTA6ICAg
NzcgMDkgICAgICAgICAgICAgICAgICAgICBqYSAgICAgMWIgPF9FSVArMHgx
Yj4gMDAwMDAwMWEgQmVmb3JlIGZpcnN0IHN5bWJvbA0KQ29kZTsgIDAwMDAw
MDEyIEJlZm9yZSBmaXJzdCBzeW1ib2wNCiAgMTI6ICAgZTggODIgMDAgMDAg
MDAgICAgICAgICAgICBjYWxsICAgOTkgPF9FSVArMHg5OT4gMDAwMDAwOTgg
QmVmb3JlIGZpcnN0IHN5bWJvbA0KDQoNCjEgd2FybmluZyBpc3N1ZWQuICBS
ZXN1bHRzIG1heSBub3QgYmUgcmVsaWFibGUuDQpvZnMxIw0K
--784335468-891059326-1000316289=:6363
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="slabinfo1.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109121238091.6363@home.nohrsc.nws.gov>
Content-Description: 
Content-Disposition: attachment; filename="slabinfo1.txt"

a21lbV9jYWNoZSAgICAgICAgICAgIDU4ICAgICA2OCAgICAxMTIgICAgMiAg
ICAyICAgIDENCmlwX2Nvbm50cmFjayAgICAgICAgICAyNSAgICAgMzMgICAg
MzUyICAgIDMgICAgMyAgICAxDQp0Y3BfdHdfYnVja2V0ICAgICAgICAgIDAg
ICAgICAwICAgICA5NiAgICAwICAgIDAgICAgMQ0KdGNwX2JpbmRfYnVja2V0
ICAgICAgICA5ICAgIDExMyAgICAgMzIgICAgMSAgICAxICAgIDENCnRjcF9v
cGVuX3JlcXVlc3QgICAgICAgMCAgICAgIDAgICAgIDY0ICAgIDAgICAgMCAg
ICAxDQppbmV0X3BlZXJfY2FjaGUgICAgICAgIDUgICAgIDU5ICAgICA2NCAg
ICAxICAgIDEgICAgMQ0KaXBfZmliX2hhc2ggICAgICAgICAgIDEwICAgIDEx
MyAgICAgMzIgICAgMSAgICAxICAgIDENCmlwX2RzdF9jYWNoZSAgICAgICAg
ICAzOCAgICAgNDggICAgMTYwICAgIDIgICAgMiAgICAxDQphcnBfY2FjaGUg
ICAgICAgICAgICAgMTEgICAgIDMwICAgIDEyOCAgICAxICAgIDEgICAgMQ0K
YmxrZGV2X3JlcXVlc3RzICAgICAgNTEyICAgIDUyMCAgICAgOTYgICAxMyAg
IDEzICAgIDENCm5mc19yZWFkX2RhdGEgICAgICAgICAgMCAgICAgIDAgICAg
Mzg0ICAgIDAgICAgMCAgICAxDQpuZnNfd3JpdGVfZGF0YSAgICAgICAgIDAg
ICAgICAwICAgIDM4NCAgICAwICAgIDAgICAgMQ0KbmZzX3BhZ2UgICAgICAg
ICAgICAgICAwICAgICAgMCAgICAgOTYgICAgMCAgICAwICAgIDENCmRub3Rp
ZnkgY2FjaGUgICAgICAgICAgMCAgICAgIDAgICAgIDIwICAgIDAgICAgMCAg
ICAxDQpmaWxlIGxvY2sgY2FjaGUgICAgICAgIDIgICAgIDQyICAgICA5MiAg
ICAxICAgIDEgICAgMQ0KZmFzeW5jIGNhY2hlICAgICAgICAgICAwICAgICAg
MCAgICAgMTYgICAgMCAgICAwICAgIDENCnVpZF9jYWNoZSAgICAgICAgICAg
ICAgNiAgICAxMTMgICAgIDMyICAgIDEgICAgMSAgICAxDQpza2J1ZmZfaGVh
ZF9jYWNoZSAgICAyMjkgICAgMjY0ICAgIDE2MCAgIDExICAgMTEgICAgMQ0K
c29jayAgICAgICAgICAgICAgICAgIDMxICAgICAzNiAgICA4MzIgICAgNCAg
ICA0ICAgIDINCnNpZ3F1ZXVlICAgICAgICAgICAgICAgMCAgICAgIDAgICAg
MTMyICAgIDAgICAgMCAgICAxDQpjZGV2X2NhY2hlICAgICAgICAgICAgMTYg
ICAgIDU5ICAgICA2NCAgICAxICAgIDEgICAgMQ0KYmRldl9jYWNoZSAgICAg
ICAgICAgICA4ICAgICA1OSAgICAgNjQgICAgMSAgICAxICAgIDENCg==
--784335468-891059326-1000316289=:6363
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="oops1.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109121238092.6363@home.nohrsc.nws.gov>
Content-Description: 
Content-Disposition: attachment; filename="oops1.txt"

U2VwIDEyIDExOjMwOjE1IG9mczEga2VybmVsOiBfX2FsbG9jX3BhZ2VzOiAw
LW9yZGVyIGFsbG9jYXRpb24gZmFpbGVkIChnZnA9MHg3MC8xKS4NClNlcCAx
MiAxMTozMDoxNSBvZnMxIGtlcm5lbDogaW52YWxpZCBvcGVyYW5kOiAwMDAw
DQpTZXAgMTIgMTE6MzA6MTUgb2ZzMSBrZXJuZWw6IENQVTogICAgMA0KU2Vw
IDEyIDExOjMwOjE1IG9mczEga2VybmVsOiBFSVA6ICAgIDAwMTA6W19fYWxs
b2NfcGFnZXMrNTkxLzYwNF0NClNlcCAxMiAxMTozMDoxNSBvZnMxIGtlcm5l
bDogRUZMQUdTOiAwMDAxMDI4Ng0KU2VwIDEyIDExOjMwOjE1IG9mczEga2Vy
bmVsOiBlYXg6IDAwMDAwMDNhICAgZWJ4OiAwMDAwMDAwMCAgIGVjeDogZjdk
ZjYwMDAgICBlZHg6IDAwMDAwMDAwDQpTZXAgMTIgMTE6MzA6MTUgb2ZzMSBr
ZXJuZWw6IGVzaTogYzAyOGIyMDggICBlZGk6IDAwMDAwMDAwICAgZWJwOiBm
N2RmNjAwMCAgIGVzcDogZjdkZjdlNzQNClNlcCAxMiAxMTozMDoxNSBvZnMx
IGtlcm5lbDogZHM6IDAwMTggICBlczogMDAxOCAgIHNzOiAwMDE4DQpTZXAg
MTIgMTE6MzA6MTUgb2ZzMSBrZXJuZWw6IFByb2Nlc3Mga3N3YXBkIChwaWQ6
IDQsIHN0YWNrcGFnZT1mN2RmNzAwMCkNClNlcCAxMiAxMTozMDoxNSBvZnMx
IGtlcm5lbDogU3RhY2s6IDAwMDAwMDcwIDAwMDAwMDAxIDAwMDAwMDA4IGMw
MmY3YTAwIDAwMDAwMDAxIGMwMjhiMWZjIDAwMDAwMDcwIGMwMTI3MDBlIA0K
U2VwIDEyIDExOjMwOjE1IG9mczEga2VybmVsOiAgICAgICAgYzA0MTVhMjAg
YzAxMmE0OTkgYzA0MTVhMjAgYzAxMmE1YWMgZjRhYzAyNDAgMDAwMDAwMDEg
MDAwMDAwMDggYzAyZjdhMDAgDQpTZXAgMTIgMTE6MzA6MTUgb2ZzMSBrZXJu
ZWw6ICAgICAgICBjMDFhOTdjNyAwMDAwMDAwMSBmNGFjMDI0MCAwMDAwMzAw
OSBmNGFjMDI0MCAxZjlmOGQ2MCAxOWExNzVhZiBjMDJmN2EyOCANClNlcCAx
MiAxMTozMDoxNSBvZnMxIGtlcm5lbDogQ2FsbCBUcmFjZTogW19hbGxvY19w
YWdlcysyMi8yNF0gW2FsbG9jX2JvdW5jZV9wYWdlKzEzLzEyMF0gW2NyZWF0
ZV9ib3VuY2UrNDAvMzgwXSBbX19tYWtlX3JlcXVlc3QrMTM1LzE1OTZdIFtp
cF9yY3YrODA2Lzg2MF0gDQpTZXAgMTIgMTE6MzA6MTUgb2ZzMSBrZXJuZWw6
ICAgIFtnZW5lcmljX21ha2VfcmVxdWVzdCsyODgvMzA0XSBbc3VibWl0X2Jo
KzY5Lzk2XSBbbGxfcndfYmxvY2srMjk5LzM5Nl0gW3N5bmNfcGFnZV9idWZm
ZXJzKzcxLzg0XSBbdHJ5X3RvX2ZyZWVfYnVmZmVycysyODEvMzE2XSBbcGFn
ZV9sYXVuZGVyKzYwMy8xMzc2XSANClNlcCAxMiAxMTozMDoxNSBvZnMxIGtl
cm5lbDogICAgW2RvX3RyeV90b19mcmVlX3BhZ2VzKzY0LzE4NF0gW2tzd2Fw
ZCsxMDUvMTcyXSBba2VybmVsX3RocmVhZCs0MC81Nl0gDQpTZXAgMTIgMTE6
MzA6MTUgb2ZzMSBrZXJuZWw6IA0KU2VwIDEyIDExOjMwOjE1IG9mczEga2Vy
bmVsOiBDb2RlOiAwZiAwYiAzMSBjMCA1YiA1ZSA1ZiA1ZCA4MyBjNCAwYyBj
MyA5MCA4MyBmYSAwOSA3NyAwOSBlOCA4MiANCg==
--784335468-891059326-1000316289=:6363--
