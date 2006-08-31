Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWHaLOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWHaLOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHaLOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:14:10 -0400
Received: from lucidpixels.com ([66.45.37.187]:42718 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751451AbWHaLOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:14:09 -0400
Date: Thu, 31 Aug 2006 07:14:04 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
cc: apiszcz@lucidpixels.com
Subject: 2.6.17.6 New(?) NFS Kernel Bug (OOPS) When vi /over/nfs/file.txt
Message-ID: <Pine.LNX.4.64.0608310708050.2348@p34.internal.lan>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-2002087767-1157022844=:2391"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-2002087767-1157022844=:2391
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Short description: I have a text file I was editing over NFS, around 4 to 
5 kilobytes.  It was during this time this occured:

Note, this is the first time I have ever seen this bug.
My .config is attached.  After a reboot, I ran the same vi command, no 
issues, so I could easily reproduce the problem.

Could anyone offer any insight to exactly what it was that caused this 
bug?

I do have the numbers of NFSD's set to 32, I will set this back to 8 for 
now.

[4640805.423000] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000003
[4640805.423000]  printing eip:
[4640805.423000] c02796cd
[4640805.423000] *pde = 00000000
[4640805.423000] Oops: 0000 [#1]
[4640805.423000] PREEMPT SMP 
[4640805.423000] CPU:    0
[4640805.423000] EIP:    0060:[<c02796cd>]    Not tainted VLI
[4640805.423000] EFLAGS: 00210282   (2.6.17.6 #4) 
[4640805.423000] EIP is at _atomic_dec_and_lock+0x5/0x58
[4640805.423000] eax: 00000003   ebx: 00000003   ecx: 00000000   edx: f70c72cc
[4640805.423000] esi: c01d36b9   edi: c0423520   ebp: c04d2f98   esp: f654bd78
[4640805.423000] ds: 007b   es: 007b   ss: 0068
[4640805.423000] Process nfsd (pid: 1130, threadinfo=f654a000 task=f6544a50)
[4640805.423000] Stack: 00000003 c03bbec1 00000003 c0440800 f70c72c0 c01d36dd 00000003 f70c72cc 
[4640805.423000]        c027ab7c f70c72cc 00200296 c03bf076 f70c72cc c04d2f98 de2e2ec0 c03bfd79 
[4640805.423000]        f70c72cc c01d36b9 c042352c f70c72c0 f654be34 00000089 00000008 f654be10 
[4640805.423000] Call Trace:
[4640805.423000]  <c03bbec1> auth_domain_put+0x18/0x51  <c01d36dd> expkey_put+0x24/0x54
[4640805.423000]  <c027ab7c> kref_put+0x31/0x94  <c03bf076> cache_init+0x25/0x34
[4640805.423000]  <c03bfd79> sunrpc_cache_lookup+0xf4/0x144  <c01d36b9> expkey_put+0x0/0x54
[4640805.423000]  <c01d1b7f> svc_expkey_lookup+0xa1/0xb4  <c01d1be8> exp_find_key+0x56/0xb7
[4640805.423000]  <c0376a5f> ip_push_pending_frames+0x2fb/0x466  <c03765c0> dst_output+0x0/0xc
[4640805.423000]  <c01d2d0b> exp_find+0x20/0x9c  <c0114d82> try_to_wake_up+0x6e/0x3ca
[4640805.423000]  <c01cdbf2> fh_verify+0x40f/0x57d  <c0350e6d> skb_copy_bits+0x1f4/0x26f
[4640805.423000]  <c01cea22> nfsd_open+0x34/0x14a  <c01cedb7> nfsd_write+0xb5/0x10f
[4640805.423000]  <c01d3f1e> nfsd_cache_lookup+0x250/0x36e  <c01d5cac> nfsd3_proc_write+0x104/0x130
[4640805.423000]  <c01cadeb> nfsd_dispatch+0x9b/0x21a  <c03b9159> svc_process+0x3e4/0x6f8
[4640805.423000]  <c03bba88> svc_recv+0x268/0x4c8  <c01cb33d> nfsd+0x1ad/0x330
[4640805.423000]  <c01cb190> nfsd+0x0/0x330  <c0100dc5> kernel_thread_helper+0x5/0xb
[4640805.423000] Code: ff 31 db 83 f8 01 77 17 89 c3 c7 44 24 04 d8 45 4b c0 89 04 24 e8 64 ff ff ff 83 f8 01 76 e9 89 d8 83 c4 08 5b c3 53 8b 5c 24 08 <8b> 13 83 fa 01 74 18 8d 4a ff 89 d0 f0 0f b1 0b 39 c2 75 32 31 
[4640805.423000] EIP: [<c02796cd>] _atomic_dec_and_lock+0x5/0x58 SS:ESP 0068:f654bd78
[4640805.423000]
---1463747160-2002087767-1157022844=:2391
Content-Type: APPLICATION/octet-stream; name=config-2.6.17.6.bz2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0608310714040.2391@p34.internal.lan>
Content-Description: 
Content-Disposition: attachment; filename=config-2.6.17.6.bz2

QlpoOTFBWSZTWWGtPaMACErfgGgQWOf/9z////C////gYB6cdAAN7dzyAGl3
u8nqmqL46O+3vXdAAS7a7jVrrdvR6r0D3ZdqkO5tA7sHQ5adDTr2wK9u7Wnu
x6piR3yPvffe96l9b77F7ew0ECaZDQCNDSnlU9lPFNqjT1PU9R6mJp7VGhoA
aaJpoTTIJNMhNJihtTTJoDI0aaAAAMQIgk9NTDU0k9T9U09R6gAAAAAABJpS
AgmTUap4p+p6mRqPUfpQAAAAPUaAMUk9Aak8hpqaGnqNGmhoNMIaANGRo0NB
IiBACCajJqU2FPUA00AAAAAd35E/0H/kiMFFgejjSGFW0rUWBUYyKcWSoosM
NZ9Qc+UMkOmWbL9X8sTDlFET44Pll8nMyuWmHLJUn+KX+jTNqHCQALYvCLgI
3UfzOFU71Dh3Dofnk4fz7wQ60Yp9CTCYQWVUKqEUlaxRtoigKAo+/GJj0NcV
QRKIoottpbFbYoFR+i+vKzJi1FCpFkKtlqtYFZq4YrijSgsiqKCiKiUtpauK
Vw1NGQqIgKYLQqRrasYrFQURItjUhRqKCwgshhMTBY0trQbQWsWtZFJFrCiL
CoVJWAFX3JREmeVwkWVWLLatRq2IrKxZFjQCVCBugFMFtItSkWVqv0pVRUwt
vvxjALB+ZphlqpUaUXXBjBbZRFYoytUpaI2lBUqoFLQVtiVd7gVcUq1pSmn1
7MmIo5W8MGMIpStCxVdLTCNpUWXOkC9WdPZ+X05Fe0fB+fFny9dlPT9fnlVV
iPeZRwmFoY/Q3/ZBSAIiICkbI0+pTlFR1QAOg2XodCLJEBdXlVZ5oZEaqNuJ
lpAeLDiw7OTM+9tTN0093xyDVB9lkzTVmyIg3QpDBH6kP5Q/6vv22fu9DLNY
Cliu3m2CGqlmO+c6qOadDF5638Pa3BeiJys72/nOoTwPKGQpM/jV661bXpA6
4w0h9/18fx9/L6nrzecOTWfZp4cfQ3MSLYv6+38/r6+0iu6n9qylTGtsZhsb
j5zYyX6F0W9pvcL4rHbQqpEzTxyXeeSo66GAw54/WdJI8a+EfaYleXQPTNV/
TK70rK31+X581x2xWeQ852nDTOSHayM9eaHa7TjCp8a3MGsFq/resXh+dSlF
/s/XIX27VN1G741QwezhrWaUgOllidMENdxV0RbTo7R1bWZnoyFcklixzg8V
UyTUsrn5YDged13Rb24OpZ0tuUP+eKcC3TCL688UfzpY0urxzkhaXv6O358e
TsmyQz04y15Jqiq1nODr/yeblRzmIjmpBeXHPgfBRpyy2DGactYNEuHAcnIE
+UsjVkN64K/dIU93HJqx0yYauNjNr+COHBHHvXDipu2inOLGMW+POVSNY99l
cs74YRmvPrZTW6MuBs30O1nOLpaNHNUr6G3le1zHdb49bdaTu2pMHmIu2VuP
G22dw3W7azGV2k8ReNcLzmgjLGrIZo+6FoubN7r51azS5V90W12Yn2oK3V0h
fXRGUbsu262oy6D/dfk3t7fHy89fHyUejfgRECIgPh8T/F71V4uNscrjKrkk
EkC3mwlL5bhhTtdfBpu5cpF/G1Ywwcyv5MNj/jZR/3fx6g/YF+IAABEUfyz+
aEQCjEt+ae4M+5O65iPbVXkg1WQ/eLPa0fov/suv019JC0Y40/Ya9459nqdf
I+CCR7Pb12eOEsPoFL6X+dNebNEqukhnOCsmisaynqZ3oZZFtOGETEaYutOG
Lni5LtWFwDX8LGNs5YIX5cjJKMrZuUb9Z6xn0upwUN0q92QoOmAXfhwur2qL
Q+5VVq4+fcCDNoRy+uk+TuLp8qrx6OmJ0tZtZYtyb/YuekZ8Oxkt0f7r+4kU
1PGN3viaIusqhvKtsjuvdCbAkEBE1ebJWyS9yUGKX+qkvr7s+642+zpLNLeX
XHf8N7GoLcJlDpQM1XJHhoQ8IRaD+/vkG2XVIHtExS0ZbtCThTJyBuTEXOPl
DpYMbDslWZquay2uYFhamL5vydXG8w7sQL+EMyEqd05k3pxBRoIA93n5PQ0j
Ge07g+NIlV4pjxhPGuVkGzeqH1RgjY2mFS2j8GosNkc3x6RnmwZGkST4IhYe
HJtOLV0V3w1bL7quowbVY73VGx2x1HtqDUXX0jIPrzyal527wsyHlAF4rqJe
YGpo4DXQGYBV1567PAEM1YEAICbNXTe35DwAKzLlpFFGK6Ty2R3y9pu0hvFB
MGYPRqHG6+XMWNQE+j5PQ/TL4efm7qew69kFB8PctGBDeiQPke3TWXWxFqjB
ENlR4WixO74Gfu99vY/GMQuudMyC/fXL+vsO7/LVfn3hhQ4nosX2mTPs3vfV
WckbBKKuTDTsO1dtlnekK0m1mMrGDeAoDw8nzZISB4WKwKfRUlib1nSvK+kz
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
zVGDko47GAl/i7kinChIMNae0YA=

---1463747160-2002087767-1157022844=:2391--
