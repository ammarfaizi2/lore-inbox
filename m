Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSFWBrp>; Sat, 22 Jun 2002 21:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSFWBro>; Sat, 22 Jun 2002 21:47:44 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:28946 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S316957AbSFWBrm>; Sat, 22 Jun 2002 21:47:42 -0400
Subject: OOPS 2.4.18 + RealTek 8139 + VIA686 + Athlon
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ytZlvgkSQdWREvrNi0Rw"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Jun 2002 21:49:27 -0400
Message-Id: <1024796968.6029.49.camel@madmax>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ytZlvgkSQdWREvrNi0Rw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,
Have encountered a repeatable OOPS in 2.4.18 that does not occur in
2.4.19pre9 or pre10 (not sure about other preX patches).  Since this
seems fixed in upcoming 2.4.19, this may be moot; but reported here for
completeness.

The oops is triggered by large amounts of disk buffer page management
(e.g. tar xzf linux-2.4.18.tar.gz) in combination with a RealTek
RTL8139C ethernet controller chip PCI card installed in the system.
Interestingly, driver support for the 8139 need not be compiled into the
kernel; the mere presence of the card is sufficient, suggesting perhaps
a shared IRQ or other resource overlap.  More interestingly, the 8139
driver, when loaded, works even after OOPSes are triggered.

A representative OOPS in text is below, a few more GZIPped, and finally
dot.config.gz.

Hardware: Soltek DRV2, Athlon XP, IDE disk and CDROM on hda and hdb,
Radeon 8500LEE, SIIG USB2.0+IEEE1394 card via Hint PCI->PCI bridge.

Kris

--=-ytZlvgkSQdWREvrNi0Rw
Content-Disposition: inline; filename=oneoops.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=oneoops.txt; charset=ISO-8859-1

Jun 22 19:28:44 madmax kernel: cpu: 0, clocks: 2686339, slice: 1343169
Jun 22 19:30:21 madmax kernel: invalid operand: 0000
Jun 22 19:30:21 madmax kernel: CPU:    0
Jun 22 19:30:21 madmax kernel: EIP:    0010:[rmqueue+316/432]    Not tainte=
d
Jun 22 19:30:21 madmax kernel: EIP:    0010:[<c012b89c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 22 19:30:21 madmax kernel: EFLAGS: 00010087
Jun 22 19:30:21 madmax kernel: eax: c02c8e28   ebx: c02c8e40   ecx: 0000000=
1   edx: c17fff80
Jun 22 19:30:21 madmax kernel: esi: c154f4c0   edi: 00000000   ebp: 0000000=
1   esp: de3c5ef4
Jun 22 19:30:21 madmax kernel: ds: 0018   es: 0018   ss: 0018
Jun 22 19:30:21 madmax kernel: Process tar (pid: 151, stackpage=3Dde3c5000)
Jun 22 19:30:21 madmax kernel: Stack: c02c8f9c 000001ff 0000000c 00000000 0=
00143d3 00000282 00000000 c02c8e28=20
Jun 22 19:30:21 madmax kernel:        c012bad3 000001d2 de3c5f7c 0000000c c=
18fd3dc c02c8e28 c02c8f98 000001d2=20
Jun 22 19:30:21 madmax kernel:        c0127781 c012b926 00000000 c012779d d=
e95c940 de95c940 ffffffea 00002800=20
Jun 22 19:30:21 madmax kernel: Call Trace: [__alloc_pages+51/368] [generic_=
file_write+993/1728] [_alloc_pages+22/32] [generic_file_write+1021/1728] [e=
xt3_file_write+70/80]=20
Jun 22 19:30:23 madmax kernel: Call Trace: [<c012bad3>] [<c0127781>] [<c012=
b926>] [<c012779d>] [<c014f2f6>]=20
Jun 22 19:30:24 madmax kernel:    [<c0131156>] [<c0106c5b>]=20
Jun 22 19:30:26 madmax kernel: Code: 0f 0b ff 74 24 14 9d c7 46 14 01 00 00=
 00 8b 44 24 1c 3b 46=20


>>EIP; c012b89c <rmqueue+13c/1b0>   <=3D=3D=3D=3D=3D

>>eax; c02c8e28 <contig_page_data+a8/320>
>>ebx; c02c8e40 <contig_page_data+c0/320>
>>edx; c17fff80 <_end+14a83d4/24544454>
>>esi; c154f4c0 <_end+11f7914/24544454>
>>esp; de3c5ef4 <_end+1e06e348/24544454>

Trace; c012bad3 <__alloc_pages+33/170>
Trace; c0127781 <generic_file_write+3e1/6c0>
Trace; c012b926 <_alloc_pages+16/20>
Trace; c012779d <generic_file_write+3fd/6c0>
Trace; c014f2f6 <ext3_file_write+46/50>
Trace; c0131156 <sys_write+96/f0>
Trace; c0106c5b <system_call+33/38>

Code;  c012b89c <rmqueue+13c/1b0>
00000000 <_EIP>:
Code;  c012b89c <rmqueue+13c/1b0>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012b89e <rmqueue+13e/1b0>
   2:   ff 74 24 14               pushl  0x14(%esp,1)
Code;  c012b8a2 <rmqueue+142/1b0>
   6:   9d                        popf  =20
Code;  c012b8a3 <rmqueue+143/1b0>
   7:   c7 46 14 01 00 00 00      movl   $0x1,0x14(%esi)
Code;  c012b8aa <rmqueue+14a/1b0>
   e:   8b 44 24 1c               mov    0x1c(%esp,1),%eax
Code;  c012b8ae <rmqueue+14e/1b0>
  12:   3b 46 00                  cmp    0x0(%esi),%eax

--=-ytZlvgkSQdWREvrNi0Rw
Content-Disposition: attachment; filename=oops.txt.gz
Content-Type: application/x-gzip; name=oops.txt.gz
Content-Transfer-Encoding: base64

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
/yk2N27//w/TCONOcgAA

--=-ytZlvgkSQdWREvrNi0Rw
Content-Disposition: attachment; filename=dot.config.gz
Content-Type: application/x-gzip; name=dot.config.gz
Content-Transfer-Encoding: base64

H4sIAFsoFT0CA42Yy5bjKAyG9/M0naQq5SxmgTG26ZhLAXaS2vAEtZ95+xFJVyJxOWd20fdzESCE
HG70KKd47Y5///sXfxjSs5exymGHNHG1wkkldGDLiyozrIvwL3AGguTzx8uAqeLFxotxZx/NmQpS
b4udKOPKXvmcwSsbBkp6f2GWImssG8gc7uKFimk46B/ZMhknw6xot+A5BZMx0NjKDK9exMOgzSWb
dRJlO2udiXwW/OzXbDrl3d/fZMEWNv2FtJnlNCuBuqngXDaHrTloozQlXgxnS6W5NBnUIrwMyyUx
YFeYvlHUS+MpGaQTnI4SNVM4VmYT7LKi8/U3v0mL/Oj9EGH/uPA+Mo6Hg6Y8oEA8c+NEFMuIOks9
qlBlSsJJP/fZog1m3EpqxX71anIZhPkzAodXdAzB6AwyNPEdCJ4PpHoWQgbDLJzCN88yZ40LBYh4
/14MRl12VWGUo6kKfk03vqLt9t0bohpdvn45x0FscURh/MMWY2xJdY+aWsbPEHqZHZXCFxyCc5H6
3pvAUS5BuAqClj0Os1XLK0p6JNjBiNJK5OiDTE68UOoC54aOVtqoxwiGDg58zoUx2BxJhwLhgT5X
sYqinQ2sJyn2wRULfI6LVDLUJcWKCX4Ed250WZcgaVRhOZiGF2yOwtuGh0JPYa57EuAG1wVulfd1
zQcWRH2uVfNFMF0XzUXj6PhzMFnMPGhgboITduI3SWFEVNI543IXNSvaA4IYEoMYWiMxDyfv2CDy
0Z5+5Mn0NbLXysaeeckrrtSCLOFKOCqmp0U0PKwc/NP3Mpb+SIuZGsralv4c/FPcFqZj92u/+6QX
0sOLOtBbCyjyvmwXuf8qoU2ZraCw0yX0Y2XQID6XCu3HEk7VUQd/37uCSw3tcewn4RMfwD35+CAh
rA1Nd5EvvgCwp1IP4kpHTIIzaxBvDV6OM17KputhX+nvN1unxxJbs0iOA28Q5XPSgoP0Z9I1gUca
S6VpvRMfqnhcjLW38oECyXMvq31IafSwo58ZVCLSfdY9VowWVD8aA4Uu5dEysjWY1lAl3yTr9vx6
vRZjNce57xSKm/pqfWXXvKuxuAk94Mjks3tI+NYLIXaHE4q+HxLNzGVD2sBd09B8b/cV7Nglu+ng
CkQcWvCwKnWjkSlSvVUUBuTgOhg+GDS0tSirghGZv2lOUQoz8nwlCFUuNwqnZG3XkJnxLG49KXke
WBn4yqjw3+aW6DelYiNNt4B/p/rFG/wKeCgAcdGZKqdTF23A1S+kUk0e0btLSPcZeLgywcfAvdbI
XNT+/b3LoYeDv6Q0hl5cvTmGKncXcCE9WWKke4EO3CliwOFeKEivMS7dnZCwFyMkQZSZnzB9ooCj
uI4W13BIjZ/gd48u0JgeYSQqPxg69pY3CcpiE5aOTenN6Xj8RWeEzIoj+AsakUklnCaZ9L4O3ASC
5bHmjMCB6kCgDbQdrH9PwD1GlPj6MmRKne1psrcDunajH4g6ENmv2llU48AX7nnIzLihrxWvejJf
sjU8Q3AxGTwb+W6RJXwtMnVOJ51dYuaCDNJoyOIb0xyXJo+jfbagnmjyXmcGXEd4Udgk4tvho6F8
gPJdVz7eG0r3/qup7JtKe7SWB92xOc9x11SaHhwPTeWtqTS9Ph6byqmhnA6tPqfmjp4OrfWc3lrz
dB/ZeiASu+79FLtGh92+OT9Iu/pgOxpRP3hfb32o44aj73V8rOOPOj41/G64smv4ssucORvZRVdh
K2VrGNF+bxMrX8d7NQJv5EK+zcY+qyz+f8fi2Rl7Xk0qD87Hvqsw/K/tE+7fKhCCM4OwzhyNRgeU
mJKZ0u5u/88edffwIqDEezdRMfr9enQGWStSV98TIz6qNJx+E11nXIIlYgri4bOI4b9iEyyKlARn
ORSA1Ef3P46g8oJSEP/pzSbJ0z+A9xr/PwgWGs5JFwAA

--=-ytZlvgkSQdWREvrNi0Rw--

