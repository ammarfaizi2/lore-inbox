Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSFJIrV>; Mon, 10 Jun 2002 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSFJIrU>; Mon, 10 Jun 2002 04:47:20 -0400
Received: from pl244.zamosc.sdi.tpnet.pl ([217.96.195.244]:18317 "EHLO
	linux.zamosc.com.pl") by vger.kernel.org with ESMTP
	id <S316783AbSFJIrT>; Mon, 10 Jun 2002 04:47:19 -0400
Message-ID: <3D04677C.1030907@gnu.pl>
Date: Mon, 10 Jun 2002 10:46:52 +0200
From: Robert Litwiniec <linio@gnu.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
X-Accept-Language: pl, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel oops
Content-Type: multipart/mixed;
 boundary="------------060606020909010904010301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060606020909010904010301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello
I have a notebook running Debian (kernel 2.4) and it often hangs. I can 
reproduce kernel oops. I suspect sis900 nic driver.
I tryied kernel 2.4.17, 2.4.18 (from Debian and from Linus - vanilla and 
also patched with rpc_match module patch-o-matic netfilter), 2.4.19-pre10

laptop:~# uname -a
Linux laptop 2.4.18-rpc #1 czw cze 6 09:36:11 CEST 2002 i686 unknown



laptop:~# lsmod
Module                  Size  Used by    Tainted: P
slip                    6208   2  (autoclean)
slhc                    4352   1  (autoclean) [slip]
af_packet              11592   1  (autoclean)
cls_u32                 4164   0  (unused)
sch_prio                2208   0  (unused)
sch_sfq                 3232   0  (unused)
sch_tbf                 2272   0  (unused)
sch_cbq                10720   0  (unused)
ipx                    15476   2  (autoclean)
ipt_multiport            640   4  (autoclean)
ipt_LOG                 3104  11  (autoclean)
ipt_state                608   4  (autoclean)
ipt_mac                  672  11  (autoclean)
iptable_filter          1728   1  (autoclean)
rtc                     5528   0  (autoclean)
ipt_record_rpc          1376   1
ip_conntrack_rpc_tcp    2848   1  [ipt_record_rpc]
ip_conntrack_rpc_udp    2656   1  [ipt_record_rpc]
nfsd                   64864   1
lockd                  46688   1  [nfsd]
sunrpc                 58196   1  [nfsd lockd]
shaper                  3036   0  (unused)
sis900                 12036   1
ip_nat_ftp              2912   0  (unused)
iptable_nat            12756   2  [ip_nat_ftp]
ip_tables              10464   9  [ipt_multiport ipt_LOG ipt_state 
ipt_mac iptable_filter ipt_record_rpc iptable_nat]
ip_conntrack           12876   5  [ipt_state ipt_record_rpc 
ip_conntrack_rpc_tcp ip_conntrack_rpc_udp ip_nat_ftp iptable_nat]
ncpfs                  31808   0  (unused)
trident                26656   0
soundcore               3492   3  [trident]
ac97_codec              9568   0  [trident]
ide-scsi                7392   0
sr_mod                 11800   0  (unused)
cdrom                  28640   0  [sr_mod]
sg                     28068   0  (unused)
scsi_mod               85240   3  [ide-scsi sr_mod sg]
unix                   13316  81  (autoclean)

cat /proc/interrupts
            CPU0
   0:      16713          XT-PIC  timer
   1:          5          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  SiS 7018 PCI Audio
   8:          1          XT-PIC  rtc
  10:        304          XT-PIC  eth0
  12:         12          XT-PIC  PS/2 Mouse
  14:      13176          XT-PIC  ide0
  15:          7          XT-PIC  ide1
NMI:          0
ERR:          0


laptop:~# cat /proc/pci
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 49).
       Master Capable.  Latency=128.
       Non-prefetchable 32 bit memory at 0x20000000 [0x23ffffff].
   Bus  0, device   0, function  1:
     IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
       Master Capable.  Latency=16.
       I/O at 0x1100 [0x110f].
   Bus  0, device   1, function  0:
     ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 0).
   Bus  0, device   1, function  1:
     Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 130).
       IRQ 10.
       Master Capable.  Latency=128.  Min Gnt=52.Max Lat=11.
       I/O at 0x3200 [0x32ff].
       Non-prefetchable 32 bit memory at 0x24000000 [0x24000fff].
   Bus  0, device   1, function  2:
     USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 7).
       IRQ 11.
       Master Capable.  Latency=128.  Max Lat=80.
       Non-prefetchable 32 bit memory at 0x24001000 [0x24001fff].
   Bus  0, device   1, function  3:
     USB Controller: Silicon Integrated Systems [SiS] 7001 (#2) (rev 7).
       IRQ 11.
       Master Capable.  Latency=128.  Max Lat=80.
       Non-prefetchable 32 bit memory at 0x24002000 [0x24002fff].
   Bus  0, device   1, function  4:
     Multimedia audio controller: Silicon Integrated Systems [SiS] SiS 
PCI Audio Accelerator (rev 2).
       IRQ 5.
       Master Capable.  Latency=128.  Min Gnt=2.Max Lat=24.
       I/O at 0x3400 [0x34ff].
       Non-prefetchable 32 bit memory at 0x24003000 [0x24003fff].
   Bus  0, device   1, function  6:
     Modem: PCI device 1039:7013 (Silicon Integrated Systems [SiS]) (rev 
160).
       IRQ 10.
       Master Capable.  Latency=128.  Min Gnt=52.Max Lat=11.
       I/O at 0x3600 [0x36ff].
       I/O at 0x3800 [0x387f].
   Bus  0, device   2, function  0:
     PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (rev 0).
       Master Capable.  No bursts.  Min Gnt=8.
   Bus  0, device  10, function  0:
     CardBus bridge: Texas Instruments PCI4410 PC card Cardbus 
Controller (rev 2).
       Master Capable.  No bursts.  Min Gnt=192.Max Lat=3.
       Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
   Bus  0, device  10, function  1:
     FireWire (IEEE 1394): PCI device 104c:8017 (Texas Instruments) (rev 2).
       IRQ 5.
       Master Capable.  Latency=128.  Min Gnt=3.Max Lat=4.
       Non-prefetchable 32 bit memory at 0x24004000 [0x240047ff].
       Non-prefetchable 32 bit memory at 0x24008000 [0x2400bfff].
   Bus  1, device   0, function  0:
     VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 
GUI Accelerator+3D (rev 49).
       Prefetchable 32 bit memory at 0x48000000 [0x4fffffff].
       Non-prefetchable 32 bit memory at 0x40000000 [0x4001ffff].
       I/O at 0xa000 [0xa07f].

laptop:~# cat /proc/cmdline
BOOT_IMAGE=Linux_mtrr ro root=306 video=vesa:mtrr


regards
Robert Litwiniec


-- 
--- Debian GNU/Linux, Solaris, Novell administrator
http://linio.net2000.pl, http://mulinux.net2000.pl -mulinux 9.x
linio@gnu.pl|LinuxUser#137705|gsm 501-73-33-52|ICQ 3341146|GG 1520075

--------------060606020909010904010301
Content-Type: application/x-java-vm;
 name="laptop_oops"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="laptop_oops"

a3N5bW9vcHMgMi40LjUgb24gaTY4NiAyLjQuMTguICBPcHRpb25zIHVzZWQKICAgICAtViAo
ZGVmYXVsdCkKICAgICAtayAvcHJvYy9rc3ltcyAoZGVmYXVsdCkKICAgICAtbCAvcHJvYy9t
b2R1bGVzIChkZWZhdWx0KQogICAgIC1vIC9saWIvbW9kdWxlcy8yLjQuMTgvIChkZWZhdWx0
KQogICAgIC1tIC9ib290L1N5c3RlbS5tYXAtMi40LjE4IChkZWZhdWx0KQoKV2FybmluZzog
WW91IGRpZCBub3QgdGVsbCBtZSB3aGVyZSB0byBmaW5kIHN5bWJvbCBpbmZvcm1hdGlvbi4g
IEkgd2lsbAphc3N1bWUgdGhhdCB0aGUgbG9nIG1hdGNoZXMgdGhlIGtlcm5lbCBhbmQgbW9k
dWxlcyB0aGF0IGFyZSBydW5uaW5nCnJpZ2h0IG5vdyBhbmQgSSdsbCB1c2UgdGhlIGRlZmF1
bHQgb3B0aW9ucyBhYm92ZSBmb3Igc3ltYm9sIHJlc29sdXRpb24uCklmIHRoZSBjdXJyZW50
IGtlcm5lbCBhbmQvb3IgbW9kdWxlcyBkbyBub3QgbWF0Y2ggdGhlIGxvZywgeW91IGNhbiBn
ZXQKbW9yZSBhY2N1cmF0ZSBvdXRwdXQgYnkgdGVsbGluZyBtZSB0aGUga2VybmVsIHZlcnNp
b24gYW5kIHdoZXJlIHRvIGZpbmQKbWFwLCBtb2R1bGVzLCBrc3ltcyBldGMuICBrc3ltb29w
cyAtaCBleHBsYWlucyB0aGUgb3B0aW9ucy4KClVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5V
TEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAKIDAw
MDAwMDAwCipwZGUgPSAwMDAwMDAwMApPb3BzOiAwMDAwCkNQVTogICAgMApFSVA6ICAgIDAw
MTA6WzwwMDAwMDAwMD5dICAgIFRhaW50ZWQ6IFAKVXNpbmcgZGVmYXVsdHMgZnJvbSBrc3lt
b29wcyAtdCBlbGYzMi1pMzg2IC1hIGkzODYKRUZMQUdTOiAwMDAxMDI4MgplYXg6IDAwMDAw
MDAwICAgZWJ4OiBjY2Q3ZWEyMCAgIGVjeDogZDA4YmRhMjAgICBlZHg6IGNmNDk3OTQwCmVz
aTogYzhiNmRkM2MgICBlZGk6IGNmNDk3OTQwICAgZWJwOiBjOGI2ZGRkMCAgIGVzcDogYzhi
NmRkMDgKZHM6IDAwMTggICBlczogMDAxOCAgIHNzOiAwMDE4ClByb2Nlc3Mgbm1hcCAocGlk
OiAzMzU4LCBzdGFja3BhZ2U9YzhiNmQwMDApClN0YWNrOiBkMDg2YTJmOCBjY2RmYjY5NCAw
MDAwMDAzYyBjY2Q3ZWEyMCAwMDAwMDAwMiBjOGI2ZGRjMCBjMDJiMDI3OCBjMDFkNTc2Ywog
ICAgICAgY2YzZDUwMDAgYzhiNmRkMzQgZDA4NmMxNDAgMDAwMDAwMDAgMDAwMDAwMDIgZjk2
NDY0YzMgMDAwMDBlODEgMTZmZjRkZDUKICAgICAgIDAwMDYwMDE2IGQwODY5M2MwIDAwMDAw
MDAzIGM4YjZkZGQwIDAwMDAwMDAwIGNmM2Q1MDAwIGMwMWQ1NzZjIGMwMWM4NmM4CkNhbGwg
VHJhY2U6IFs8ZDA4NmEyZjg+XSBbPGMwMWQ1NzZjPl0gWzxkMDg2YzE0MD5dIFs8ZDA4Njkz
YzA+XSBbPGMwMWQ1NzZjPl0KICAgWzxjMDFjODZjOD5dIFs8YzAxZDU3NmM+XSBbPGMwMWQ1
NzZjPl0gWzxjMDFjODk3ZD5dIFs8YzAxZDU3NmM+XSBbPGQwODZiZDFjPl0KICAgWzxjMDFk
NDdmZD5dIFs8YzAxZDU3NmM+XSBbPGMwMWUyM2RlPl0gWzxjMDFlMjQ4YT5dIFs8YzAxZTQ2
ZGQ+XSBbPGMwMWU2NmE0Pl0KICAgWzxjMDFmMWY2Nj5dIFs8YzAxYmQ3Yjc+XSBbPGMwMWJl
NDZhPl0gWzxjMDFiY2E2ZD5dIFs8YzAxYmRiNWU+XSBbPGMwMWJkYjgwPl0KICAgWzxjMDFi
ZTBmND5dIFs8YzAxMDZkMmI+XQpDb2RlOiAgQmFkIEVJUCB2YWx1ZS4KCgo+PkVJUDsgMDAw
MDAwMDAgQmVmb3JlIGZpcnN0IHN5bWJvbAoKPj5lYng7IGNjZDdlYTIwIDxfZW5kK2NhOWY2
MDQvMjg5NGViZTQ+Cj4+ZWN4OyBkMDhiZGEyMCA8X2VuZCsxMDVkZTYwNC8yODk0ZWJlND4K
Pj5lZHg7IGNmNDk3OTQwIDxfZW5kK2YxYjg1MjQvMjg5NGViZTQ+Cj4+ZXNpOyBjOGI2ZGQz
YyA8X2VuZCs4ODhlOTIwLzI4OTRlYmU0Pgo+PmVkaTsgY2Y0OTc5NDAgPF9lbmQrZjFiODUy
NC8yODk0ZWJlND4KPj5lYnA7IGM4YjZkZGQwIDxfZW5kKzg4OGU5YjQvMjg5NGViZTQ+Cj4+
ZXNwOyBjOGI2ZGQwOCA8X2VuZCs4ODhlOGVjLzI4OTRlYmU0PgoKVHJhY2U7IGQwODZhMmY4
IDxfZW5kKzEwNThhZWRjLzI4OTRlYmU0PgpUcmFjZTsgYzAxZDU3NmMgPGRldl9pb2N0bCsx
NmMvNDAwPgpUcmFjZTsgZDA4NmMxNDAgPF9lbmQrMTA1OGNkMjQvMjg5NGViZTQ+ClRyYWNl
OyBkMDg2OTNjMCA8X2VuZCsxMDU4OWZhNC8yODk0ZWJlND4KVHJhY2U7IGMwMWQ1NzZjIDxk
ZXZfaW9jdGwrMTZjLzQwMD4KVHJhY2U7IGMwMWM4NmM4IDxmYmNvbl9zY3JvbGwrMjY4L2E0
MD4KVHJhY2U7IGMwMWQ1NzZjIDxkZXZfaW9jdGwrMTZjLzQwMD4KVHJhY2U7IGMwMWQ1NzZj
IDxkZXZfaW9jdGwrMTZjLzQwMD4KVHJhY2U7IGMwMWM4OTdkIDxmYmNvbl9zY3JvbGwrNTFk
L2E0MD4KVHJhY2U7IGMwMWQ1NzZjIDxkZXZfaW9jdGwrMTZjLzQwMD4KVHJhY2U7IGQwODZi
ZDFjIDxfZW5kKzEwNThjOTAwLzI4OTRlYmU0PgpUcmFjZTsgYzAxZDQ3ZmQgPG5ldGlmX3J4
K2JkL2YwPgpUcmFjZTsgYzAxZDU3NmMgPGRldl9pb2N0bCsxNmMvNDAwPgpUcmFjZTsgYzAx
ZTIzZGUgPGlwX3JvdXRlX291dHB1dF9zbG93KzIxZS82MzA+ClRyYWNlOyBjMDFlMjQ4YSA8
aXBfcm91dGVfb3V0cHV0X3Nsb3crMmNhLzYzMD4KVHJhY2U7IGMwMWU0NmRkIDxpcF9yY3Zf
ZmluaXNoK2NkLzFmMD4KVHJhY2U7IGMwMWU2NmE0IDxpcF9tY19vdXRwdXQrNC8yMTA+ClRy
YWNlOyBjMDFmMWY2NiA8dGNwX2RhdGFfcXVldWUrMjYvOWQwPgpUcmFjZTsgYzAxYmQ3Yjcg
PHBjaV9mcmVlX3Jlc291cmNlcysxNy8zMD4KVHJhY2U7IGMwMWJlNDZhIDxwY2lfc2Nhbl9z
bG90K2NhL2QwPgpUcmFjZTsgYzAxYmNhNmQgPGNkcm9tX3N5c2N0bF9pbmZvKzUyZC81MzA+
ClRyYWNlOyBjMDFiZGI1ZSA8cGNpX3JlYWRfYmFzZXMrZGUvMjIwPgpUcmFjZTsgYzAxYmRi
ODAgPHBjaV9yZWFkX2Jhc2VzKzEwMC8yMjA+ClRyYWNlOyBjMDFiZTBmNCA8cGNpX3NjYW5f
YnJpZGdlKzEyNC8xNzA+ClRyYWNlOyBjMDEwNmQyYiA8ZXJyb3JfY29kZSsxMy8zYz4KCiA8
MD5LZXJuZWwgcGFuaWM6IEFpZWUsIGtpbGxpbmcgaW50ZXJydXB0IGhhbmRsZXIhCgoxIHdh
cm5pbmcgaXNzdWVkLiAgUmVzdWx0cyBtYXkgbm90IGJlIHJlbGlhYmxlLgo=
--------------060606020909010904010301--

