Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUB0LmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUB0Lls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:41:48 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:50703 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S261686AbUB0Llg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:41:36 -0500
Date: Fri, 27 Feb 2004 12:41:31 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.3] Ooops ext3_lookup -> d_splice_alias -> d_move
Message-ID: <20040227114131.GA3519@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
this happened a couple minutes ago (grepped from syslog).

Machine is a Sony Picturebook C1-MHP with an TM5800 - Root
filesystem is ext3 (The only on-disk filesystem).

Linux paradigm 2.6.3-paradigm #1 Mon Feb 23 18:23:17 CET 2004 i686 unknown
gcc used is an 2.95.4-debian-prerelease

Unable to handle kernel NULL pointer dereference at virtual address 00000007
 printing eip:
c015d2f8
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[d_move+416/536]    Not tainted
EFLAGS: 00010283
EIP is at d_move+0x1a0/0x218
eax: 00000003   ebx: c7cb0418   ecx: ccfea678   edx: cde3f620
esi: ccfea660   edi: c7cb0400   ebp: ccfea6c8   esp: cdb25e30
ds: 007b   es: 007b   ss: 0068
Process receive (pid: 4889, threadinfo=3Dcdb24000 task=3Dc14b8d00)
Stack: cdb24000 c7cb0428 c7d07cd4 ccfea660 c7cb0480 ccfea6c8 c7cb0468 ccfea=
6e0=20
       ccfea678 c015cd7c c7cb0400 ccfea660 ccfea660 c7d07cd4 c139e200 ccfea=
660=20
       cde2f620 c7cb0400 c017af35 c7d07cd4 ccfea660 fffffff4 cddca9b4 ccfea=
660=20
Call Trace:
 [d_splice_alias+150/231] d_splice_alias+0x96/0xe7
 [ext3_lookup+135/164] ext3_lookup+0x87/0xa4
 [real_lookup+88/197] real_lookup+0x58/0xc5
 [do_lookup+69/126] do_lookup+0x45/0x7e
 [link_path_walk+587/2063] link_path_walk+0x24b/0x80f
 [path_lookup+304/308] path_lookup+0x130/0x134
 [__user_walk+40/64] __user_walk+0x28/0x40
 [vfs_stat+25/70] vfs_stat+0x19/0x46
 [dput+26/468] dput+0x1a/0x1d4
 [__fput+208/240] __fput+0xd0/0xf0
 [sys_stat64+19/45] sys_stat64+0x13/0x2d
 [fput+19/20] fput+0x13/0x14
 [filp_close+95/104] filp_close+0x5f/0x68
 [sys_close+88/123] sys_close+0x58/0x7b
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 89 48 04 89 46 18 8d 6a 20 89 69 04 89 4a 20 8b 47 64 8b 50=20
 <6>note: receive[4889] exited with preempt_count 4
bad: scheduling while atomic!
Call Trace:
 [schedule+60/1248] schedule+0x3c/0x4e0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [__cond_resched+23/27] __cond_resched+0x17/0x1b
 [unmap_vmas+324/466] unmap_vmas+0x144/0x1d2
 [exit_mmap+100/340] exit_mmap+0x64/0x154
 [mmput+95/117] mmput+0x5f/0x75
 [do_exit+398/898] do_exit+0x18e/0x382
 [do_divide_error+0/162] do_divide_error+0x0/0xa2
 [do_page_fault+830/1161] do_page_fault+0x33e/0x489
 [do_page_fault+0/1161] do_page_fault+0x0/0x489
 [schedule+1081/1248] schedule+0x439/0x4e0
 [do_ide_request+18/22] do_ide_request+0x12/0x16
 [generic_unplug_device+73/101] generic_unplug_device+0x49/0x65
 [__wait_on_buffer+170/178] __wait_on_buffer+0xaa/0xb2
 [error_code+45/56] error_code+0x2d/0x38
 [d_move+416/536] d_move+0x1a0/0x218
 [d_splice_alias+150/231] d_splice_alias+0x96/0xe7
 [ext3_lookup+135/164] ext3_lookup+0x87/0xa4
 [real_lookup+88/197] real_lookup+0x58/0xc5
 [do_lookup+69/126] do_lookup+0x45/0x7e
 [link_path_walk+587/2063] link_path_walk+0x24b/0x80f
 [path_lookup+304/308] path_lookup+0x130/0x134
 [__user_walk+40/64] __user_walk+0x28/0x40
 [vfs_stat+25/70] vfs_stat+0x19/0x46
 [dput+26/468] dput+0x1a/0x1d4
 [__fput+208/240] __fput+0xd0/0xf0
 [sys_stat64+19/45] sys_stat64+0x13/0x2d
 [fput+19/20] fput+0x13/0x14
 [filp_close+95/104] filp_close+0x5f/0x68
 [sys_close+88/123] sys_close+0x58/0x7b
 [syscall_call+7/11] syscall_call+0x7/0xb

--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--f2QGlHpHGjS2mn6Y
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.6.3.gz"
Content-Transfer-Encoding: base64

H4sIAK40OkACA4xcW3PbOLJ+31/B2nk4SVVmrJtleavyAIGgiBFJIASoy7ywFJuJdSJLXl0y
8b/fBklJIAlQ8zAZs79Gowk0+gKA+u1fvznodNy9ro7rp9Vm8+58z7bZfnXMnp3X1Y/Medpt
v62//8d53m3/7+hkz+vjv377F2aRRyfpYjT8/H5+CMPk+pBQt6thExKRmOKUCpS6IQIAhPzm
4N1zBr0cT/v18d3ZZD+zjbN7O65328O1E7Lg0DYkkUTBVSIOCIpSzEJOA3IlC4kiFwUs0mjj
mE1JlLIoFSE/dz3J33LjHLLj6e3amZgjrklbihnlGAigaylMuCmPGSZCpAhj6awPznZ3VHK0
VlhqqgYMmiVeKnzqyc/dwVUYnRZ/6EIuIAnHxHWJa+hhioJALENx7cNLJFlcHwlngaYBZQL7
xE0jxniTikST5hLkBjQfxYtCGKeMSxrSv0jqsTgV8IeuXD6uwW71vPq6gWndPZ/gf4fT29tu
r9lMyNwkIFqXBSFNooAhV++vBKArfIYNY8HGggVEEsXOURzWJMxILCiLhGkUAT6bA9/vnrLD
Ybd3ju9vmbPaPjvfMmWY2aFi7mnVGhRlxpZoQmLjHCo8SkL0xYqKJAyptMJjOgGjtcIzKubC
iparDsXYt/IQ8dDpdIxw2B8NzcDABty3AFJgKxaGCzM2tAnk4A9oElJ6A27HB2Z0aul0+mCh
j8x0EqDIYHghjhPBKmsrnNMI++BrLD2XcK8V7btmGC9jurAOxYwi3E97t6zI8B4KxSFfYH9y
Xc6KuECuW6UE3RQj8CylE7w/Y/FckDBVEqBJioIJi6n0w2rjOU/nLJ6KlE2rAI1mAa/1Pa66
8HzNMo7cSmOfE5mCKyNxjUbCJEDgTGJZWee1NVhSeUxIyGXdISQ8Rdw6YLAMqtqFmNQlAAl8
deQhCHnGeZEMxnGMjBgdTc0TTTHELeYSi2KhiKuKYQ5RXIsp+pxGzKcTPyQVd1uSBuZ4VqJD
Cxwi6ZfDD/7azCJjs5slHjW8lI9mBAIZhgCMpxdHv/s720POsV19z16z7fGcbzgfEOb0k4N4
+PHq8blmiYJ5co5iMOFEgPvQBoOHqUvFtEFIIR5Jql7n87/vnrOfdy/Pq/t/F3qo3qDP55+r
7ROkWjjPsk6Qd4EyefgpFKXbY7b/tnrKPjqiHkmViGuf6ikdMyZrJBpJEoOlSt3Wc0QEhHAT
LU9wUk/UMITrvSEJUpd1aiIlvHGV6KE6pUyiWF0r6ZM4zDO9y/QWvcOwGye/aNVcEDrsknEy
aehZf0FSf0HO5o1R47g+6JDvyepCyMkxeP+FSq/CoJElgZVpk19MdXixyY/OGPIwbcKvgqFd
XRYsU8fbZ/89Zdund+cASfx6+/1qJQCnXky+VDK5klZMNFiIZxi4C5NLPJQEMp2wWQqpOORj
IYqqTsvImwjIvTjCpE14U6iRQ02EgPVswS9dGZXqDZRDbtNConFeRZwHVI2n83bJCZ/365/Z
/qDPhHKQ+TQrbhBhDZ+56hGbp5akosrz8A94RvZQvcidE+S19nyTE+KCvfIUQwoU04j9A1ba
kkBeuURI7doPoGIDN1xTTc8QWDSJk6geChXZB5NqmP34dLj6bliUnxyOQ0zRJ4dAlfnJCTH8
A3/p3jxfuhfx8AjGky81k9oF7NKYGKu8AkaR5v4USYmrUgoJ9Y4DMkF4mS9Ai/AIhXqZBK+i
y1Avacn2zHSBf/Wqif45TDLJg9w7FgEyH8U7vNo/qyFu1G8F/vn1/LxUhfn1EaoNt/CsWkLS
6zz2DD0D0B/eQ9trXoOpeThUn2qwxuSqJ3X83fFtc/pu8pTlW6mRbJgO+ZU9nY55lfptrf7Z
7V9XR63QG9PICyEZDDxtF6GgIZbI69uWxJBCUvdaCHezn+unzHEvLuO63bB+KskOq29yePNU
1bd5tMkbhNnrbv/uyOzpZbvb7L6/l4LB2EPpftRfFZ4br8hX+9Vmk20cNS7aJF5tEMWcxbLZ
UI1nnn9sVu/GhhFvrsXN7umH81woqDOPgymEhFnqmR3SGV7YYcwhqKBWGFMh2nhUDy7Cj8NO
K0sCyanB9s5woPZOXutUHC+5ZGYsGrtNYoy0lFIj5rspnwedx2EdpBGVcWVjJBg3JxxKhTv4
j9O70Avv4iBorlzqkmbXBbGc+mx1yEAkWO/u6aQykTwdvVs/Z38cfx3VOnFess3b3Xr7bedA
ngqNi9honHTfVdJbhhTQat5cElKoAiRVuzeVeH5GhVQbeu1ysdDdig60WyJwwCCSWzxewDhf
tqsgsKC6EkCCPAP0pwxLc1l3ZvFoQICtMclqOJ9e1m9AOE/v3dfT92/rX/o2lZJSFu2Vncuz
yYbucNBp172S5BbPULmr4ofGX0xCmeeNGbj+FrEtKqltxWGv2zrq8V/dTueG2m6I6kG+huab
iSYtr61TlEhWtzuAWBQslf21qICKve1G54jgYW+xaGsZ0O79oq83nrv4TG4dGBS6D4PFopUn
n/N2FsgFvYDcELMc9fDwsV0fLO7ve52bLP12Fp/L/g2NFctw2MoicLfXae+IU9reTSRGD4Pu
fbsQF/c6MMMpC9x/xhiRebvms/lUtHNQGqIJucEDI91tny8R4McOuTGQMg57j+0DOaMIrGNh
sUTllNQepSBS3FzEhtVHZ2P7qq2vWEWLWFTL/QwBquFhldMuE5lmAC09uvak7ZRcm5ftipOE
D8/rw49PznH1ln1ysPt7zPT9pcscuHqkwH5cUM3nAmeYCSFbhlLEphAo4nRGIpfFpnL43O/k
nMyK3Wumjwlkn9kf3/+AF3H+//Qj+7r79fHyuq+nzXH9Bul0kESH6qCVAT1ItE2gnB4TlYQq
QNQQ+Fud5clKJZEjAZtMaDQxT91m9/fvxTmioWY/j0F/noKZLiDtoq6lVoJ+1LmIh4RlEnIW
hGshrwb7qHvfW9xgGPRaGBBuVxJR/GBbcjqD1TFdmB5bpbgzFImlsHPQqGc7RyosAOrd9lcR
kL7aUagpYeIptnNAKeBh2aKiGy763cduiwquxP3eqOUtSKuOCoV4wuwcXiITSKJcFiIa2dkm
rvRb0PIwPcLxfb9N2xpjGoZtuoFvbpteirpt85v3gQedYcv4iGUIPCOwxhaT50h0hy2woL1B
h9oZvuRmksLKvclDBb8tB99k6dZMpsqCINovdE98oXfbVpxi6N1i6LfNSM7Q67UyDPvdWwxt
EooJHbTNl4v7j/e/2vFOi4uVMLp2NOkO0v7Aa2EIZIyEZHGL5Qreb3nH/OiguU2S70gVMWf1
vHo7ZnvbVtk5DOg2UCJeiyMoWSIa/YlyTdq4vjR8Y64l2zyXOcc5HDofFIMS9ylnhQSqspeE
1SWRc/XakBeqEP97NT1yPuRuXW0ZBbOwujHVzK+800EdcIVcNrOsSzsvEbUjwKL6JYQ43f7j
wPngrffZHP67Zh8f9GtCWoalGqk2l4zm9PXwfjhmr9oe3DXXLJkhRYrHTJDG3Nf5WAIGMj5n
f42tv6ZgSEmDZbRoleljqmvM97vj7mm30eQ21IUJY2WbOibGvGchp9xfivI+Vh0n0rcIdGcW
IEZzygx0HHIDFcpWyc/vSHusxR4U2jDF1dN6e9wdXs7tnqsbrlF2/Hu3/7Hefm+uy4jI85Rp
bI2LZxzhKalu3OcUiKPIHDhAcECjPMk0zHAS0YUuDbjTKTHtItFCw/MTL/JnDI6sUhnxIi/D
xE1jlkjLHSRgq+3ZVjSgnJruNhTQJCa627oQ1Z065CqFbF2GuUbmA9uYu5aXTgnWS4SluuHH
prRyDqLYkK9ZVN5O8BqFcnU58GJg/D/ObL0/nlYbR2R7tQdfOXKvmBtPZ6YalfLZsDr+syEU
gHSGsG0Shw1Nh01Vh1dddckyiSIS6MPvwugQ84iPY+pOiHkePRoUh//6PBZES3RTowUr49t6
czQM1HWYIk/VaRGEWDzVtVeAJ3mdRGNcJ8mCTR97oKJQ3eI0ToGCvyQkIQ3hPD/EFXV6iCT2
04CGVJohymMUTYgZDBE2A3wq5ZJbW8VTC6IWsqp5zbBkFv1joo5rzZhaM0bAFZibEeTXzFAf
KhJNpG/RTwYWAPNQWHT3SQCh2YxBjS8tg2i1rAJm86gptDT1upGheAIeISZ/qoPYGhghEwmW
CER/t+KEr5JCJMAGY+QSa1flqa8ZhvUHIcQCChQSk0YBw/oF6CsgopCnYyQoNjUzLDpFNixP
RZYGOizGSWB7U4PFlojBLEvEZJeXkW2unBLCARKCeksLDBmwBUnskNlsIUCZfQkAZgsD4DpM
NWemXDvK45EPub6wBUyd05sjNzR45Z/Df+SXh0YnObR5yWGLmxxaXaGGxLYmjEtbT16MJhbI
D2wamJznsMUlDO0ueagHgNnQJ/nhu5kB+TVnOWzzlhpIEjocNLCmCQ3tdjw0r8Chdc0svFi/
PgtP+e2oS/2DJa/dNrSWTioLUfxpWks7cyHG1E6ajtBnAYrSUafX/aKvjiDAPctiWFiEo8B8
tXXRMx/PBIiPrYmvS6HKM2dTBP5vSbTm8CotybYS7CF1Qm3LfhWHP0+9gM2BAozNq01fdkLV
03e7vfNttd47/z1lp6y41FcRk3+q0WhdljTOMTscDY0gcZmQyJwpQt1CMbmcZqAYb7Oj6V4H
ILUBOqeoSRguK+cOLHJru/XXYf6SoID+RUxnEZD9nk2WHF+yvVLkQ7fjwJh0O53w6/r4sVLQ
qYKVxJW6KaSV83cfcb4MieVGtUggBwytM1acmaR9cNEWS4swudVahPgWC+Q7qGkQ8rRZv4Et
vK437862nF97vazkySSgtjXafbDsG6qDfvP+rc9tu795rSWQpYRsXLkDomW3DYXuqNvtqok0
4y7ikmCVMsYeZFeWy8B924EvglINM0v5NDB/CVJcF7BphMXo8ZdlJCexOdITwmNmG0tiAzww
28jsFSFrE8Ry8zIivWlqOwUddfuP2FT6K0Aypq+dkmQ93DjjsGpJKudU2PzjmXHU7T1aGdRh
VRovIIsWRieT88QL9U0ddRefe9oqpuLRNracYusJRgLlpm0By9pHPBdgRlEa+1DBW9cFZ2q/
qHn/UHNooNHZmWlGTCLLSZcb9KZW07EsUDHqjywXMnyotLFvto8lCSBGeZbt6XjUHZpnEOag
a7kqIKaPo8AiUNIJi/o3xsowWHQxMcd4z3Wp5UMUbrwNzrmW5MFDkW+qDT3tQi+QL/spGg2J
ZYSrrRUFCuZllarujlVKXkUcC7e6AQREpvEI8OXVp7xWgPUhSOVmYA4JSAgtJyoKVtfq8r+G
jcFWW+qb7HBwlMl/2O62v7+sXver5/WuFmyh9KXsnCawr4fdJjtm1+ZPq/3z4bo1/7bPfof0
749utzJzkCXZQlRsW3NzNCM2rDwL+Qcs8AqKy/7+hbbaZxX+7u1NbRJX3qxyLbaQHKMlFrfk
flX30u+UX7aKQzRmprvaJA5J5WojDxYl1byqQtcAa7fMLxKvGXx10zG/EaeIt9+KP70+rVf5
1fGvp0Pj5aoj1egY3jjFGuF8etZUqJjmoH/f6VrSjjnkB1DlXjJZufuRbZ1YzaAhm5UtubzZ
DcfYFlUFpJnV2FeM1WrrrM/fclU6n6PIdrpozfQqCVZ+Hf+9MT59fD96bFsEwPAwaGPwwtmf
3dGijYVbN6TPKy3EN9YiJMWPXfzYa+NZ0Bj3uGhjQYvIEGnR6+qYnfZOrHyYaZ1BAMx9WXOz
Ze8i58N6+22/2mfPH43HUnF1j7q8Cn/Kjrvd8aU5XWP9wwEo9HtY3wMcq3qOVZ5jD7x8aCDl
YeVdI48jUhWlCGmIG7HqDEESKtkVraneOFK7tvYxTcS40ldByrXX774WgC0UFfAYh71Of9HG
4YHsFtyVQbetuezjNjhIiPUO11nCjXeY+YZPTKhwI7CA8qy5YjWAqO80DVUeeNO3l9323fQ9
C/dZ1AxYdPt2Olr9A414cjnpTA7ZfqNO6StuSOeEzCBRZ94z/bBNp6dcoGRhRQWOCYnSxedu
pzdo51l+fhiOtDHJmf5ky9rBaY1BCvPBaoGSmVL9td6IzIwnXPnA0Ttmuic4QSGpfxxz+QgY
SoULg3ZUSeI8IdIfUzrqDHp1IvxbNr3GjBzActTDD13jVaKcAUIOF73zfBZv0LhyUHn3KVnm
t/KvOpwpEFan40rqeEGgGJqOzSviwrOQN1kiMpcsss5WbhH6j4DAY1q8nvbzHYqoXt6yaVMw
gEBmWaEFg7ocMw5bGDjudjscuS22B8YpJMXTNvNkCfYLA2/hUt+KNb/hfVntV09qU/+anpyr
TM3KZjK/F8v0X7zx5xqtYlIoUJegi1/EiQ1XnbP9erVpOvmy6ah339FqjisxrX5boyP5R+1m
8z2zRHGq/Kn4PDCLIAtJIte0rQnViOIASq537cO2qijMYq18UhcvHkcpl0vtHsGVCNxJJD/3
7ofl1RKYgMq14UTkZmKc1C8Ud3pp/Zuh8rwmpNV7BSHk2zAbgTFBPD69PO++Oyp7riWIEvsu
s/yowhxKjshlpm33aFb52Kz2kxYQOM3GHPcfhwPLDhoPKDb2JVi05PS8Y+sV192hdHe+baBy
es/vv1fTisqFL+s3V2hi2qFyqz/zA4+pdD1zGqFA8NchsqJx7YqhDiGX5L9loKflT4bFerVl
qPrzO0BYWH6rpVZ4XscdzaFPdShh2aqJJtgneFr8bknT2nrYkAH0tJ80gIcU++AK8gh/aYQ2
33f79fHl9VBpl/8Yy5jKantF5NjT2/tgsH9DkuwYPxcuGtHuff++LqnxxVNODt2He/N90hJW
m8RWHKq+qe22Z4HPrBiE624LaIzMOSRQJe0AUpRvHPes0sqvb9OATnxp56J0MbCjMRNoZvsC
SHEU8KDlc3Dw2GN7c/Xx0ON9Gz60fMVVwo/DhRWekSAgoaU2zBkoasN4zOwwYy5jfeMauZir
yLaH3f4AsXf9ZrZbQSL1+yRaEFTPQn3mBylu1wCIcbfzv8aupTl1XAn/ldTs7mLqxBiDWdyF
/AIFv8aSCcmGYgKVQ01OSIWk7px/f/UwIFlqmUVSRX+td6vdklqte5MuNv0Lk57xEzxLAfM8
8EJiSYBpODWpeTENrNTQRg19K9Waw8zSGNb3k3CCTOAx9Kehl1iBfBoGlPSnifA+Ex9rcCgl
SwTEflEyWeDa7q/8a787bG2qWnjN9n01pSPv4fXwxWyM1WG3P95Fn8ft7mUrTlPPt/DVfBL9
apq87/+5/fh5eLEoxCxSVV4WbeKnKG3AyzOMAReEUghczRHgfs/B1HowJxtOmK7U41KwFIs5
gjLjjo4QViDaVGswpfiK9q8g9XElmOElifx+WfIy/BZVHkSfoFsDEoUgprIgqEyrAkH3jxi+
fAL0EcN8yDbhQyRUlQfBtGFjVcKjjxvaWg6M4+M735O/2x1OHzyOgzS5TGFk0mNbPRTJhQyd
8ZsLkYxZm2xUsixtTJDvIlsKyqrSeh2U0zfhv6GSu6SIoKJdoMnXYxec1OLDy5Z85p4eOX6/
75S1Al/Ln03WSzCm/PD+/a9kvUOfLz8PX/sXHgdSSVdqtzXZTzaX/mrTMrZ6MnC8IoSHNlP2
AhixwGvWVZXqf8bJzMo0icx4l+HqegV3FxW4G3JJ7fY8Z7O7+Z6DktjMWJ6IjzOYZUFrtALR
bh3WepMguIfzqNuxbnN1m2cIqhNKvHAcghnGZDzyPTc8csMTEE6JNwlDFxxCF7b4nlFLpAdj
7GJhy98mLVIXS4HgQkSwN3CFoXFsCI1ALh6QYTZaD3X3mW2g2wWbD9eaRKED8yYOED3CTeWt
zJoK0J5iwAsc+v69o+K5TxAsMGSOcrSG5wghsW1jgJ8dGfs8QrpzHIwDrz/J0TP1/RHcRxGz
CtcuqZ6snfAohMeOqS3vfgnjy6qZeyMP7qOyGAXwCDZF6piQDJ1N3GgAp14k0P1OBro+rBx/
KjLwiE+MFBmD952lZLmSM8PY86f3A7jn0jUz36mKZhMYLlDKPRR9kCEroKWwUCFx6k0dIy7w
0dipgvJwDbeeVCWOVzgCzrTFd48Hm3BI9Wo90i+uyo98zr4s/DzJOvv4IRZqE3GHTd3vAT5F
q7Xp3tNnGOuBdqS7xMf+vbMvyPl0SDtdqLkvrqYDBJnPcmBMBR4XoMQJ3DmTBYd577JfhENX
yDIcYn1lcOdAmJFYuVg68R3m8B0sUEhDiQ5JoGByqhBZDyYG/KM/wFJjV6e746pIHmYvuiq6
EqYmeJwlPzuBKXJZ1QBezBIXGthZMWZAzEJzDvA5aCxGtHNlPhnPUVu7XfnTy/7tbfu+P36f
RAbGhU2ZhrswZ1rYEE6PUJk8Yiiugkj5VKICx8wsL6uGWKu8OJ6++Nrq6/P49sbWU5abvjyn
dMEda2LbapfDVQer/c3prSXZpejuoC9+255O5pmNobp4kut5PmVL3pft+93x/e333d/7u+8T
W+j878BP+g8nHgdxp/ktWE6teQEFTjDQJBQX+tCJ9Yi6tSU8BGjVoHnab3dH3kC3rTUeRFGG
ov7onuGsSVPIRVvlwySB3IS10tgXYJBpUYcsr/0gH0mS5n52E1sQDLI9tEVNFhW1y+n3Lzba
l9jR19CRC5z8R5caRtEHiRHOfgOKxyTTBRlYJwbbdtFETXByFzGxut5it8ruMurVQh4P9wQF
4ZqmS7Aaj8g19MuIoghERXTdAgHajnOse+fDlybiX9tXwLFMtCSJQ4eoiajsrlYtavbfGo2B
F+7e4RRqDUU9DxrBIbY2x3Kz4+yoyXn2+x3TBjzSozV7RWtf6nC+cCLiYBxNdRgjGsPDwlZw
DqVcp3Mw8DfHG5qHXgB3L/uz+YXxaosm96IGcHp3Ls7UPEOscT3EPBQbHD39Jjc9LIEOFTRK
8yXwvVe4HheYposU0SHGBM95HKo4zVPQC0JhTwvWo5COlSwZTfCG4MpQ0xJeYQKcrylMuAae
PFF5BnNJk/ltjer4NhQPsS7TJ1KjclMD8WJN1kG2nAyXWkU457fmhhiLmG7a3haVyVXnI//e
B8aHoCwdKkYcOTygeDnEyB0vXZ9TyVUVJYZmmW627QCDqcCTEVgKQ0cTEKV4noMgatOGPCIg
9plQILgKHOo5T+cV5d8GkCNq8tXcgedx4sgdxmhK7D063+5e9182H0GebI7YZDATZjzOtTTr
tKe16Gij28odabNGlNpWDAz3tachOoJM0MtJAHVF8JqpKPsonblIGrcNprZAGg+6oxr7CZqK
LKMiEg/NqCmaFDNJzfh5q7UODzC0hiG2TmDtAsCmKuCUf7UVtT5V0dJKpFK84gVpLGlyrEU8
px/JKhGDaowpU8+zyeRey+WhyrEeyeaZsWW2k5c2yZTCkor8yBD9wVa51sIyHklAKaggLIVG
WV1Yrn711Ogaud1y2n/vjiIku1GQ8SKJICyFn5fqCZSujLyvUE1JT9ovRFDeaVHrSRYtm195
BAxth25qZI3G0qDiGixUV416s5Vbj7AcoQzGFjAUpQ4MhhypYtEu+yU5xwxa1I45Uq7HMMof
5oOw1i5dZytVaELSl6+yN+/475XmnCQoY5ubHQNktA/VA5hREy27xMwvATNMeGQK9QXBeKnk
Jn6ytKoS5vaP2gDSlk0da1s6grKZE9vsIEXUm6WcUubk/KKLLVws7s3ruAYFpEoQhImNgiJ9
fq5gObfri+3n10FEMKC/P/SFz+XhpUuELNszbEJZXd9oOocE234xI+Uu376/fm9f9+a7S6xX
lHG+dtF//zicjmEYzP70/lBh/uYW1websT/V+kvFpr796RedaRrY5EVlCYXXrj15CByW9JiC
W5huqG0IPLjQY/JuYbql4hP/FqbxLUy3dAEQMbvHNBtmmvk35DQL7m/J6YZ+mo1vqFM4hfuJ
mQ5cyjfhcDbe6JZqMy4PkOtzWV5fqM/AaLCa/iDHcFODQY7JIMd0kGM2yOENN8YbD3Vl0O/L
ZYXDTQPmLOAWyLWlWahEqmRWjB5y8aqSmyrjl6lNN5Qlv+D9dvdz+/KP9nKZdOxb8qgeuW60
cTqhbP1arZhdn1ePQDQLwZcD234SxhX3obJ9Hbi3Fzc09AcvukxrXPKvsCNjLtkoz6vYVXiZ
Va6qd6XIV/nsPmDc6YotscRH1HLF40U+rXw0Y53aFlwS//z98XV8lQ6M5iGLfPFGeYdN/N4s
CvV5wI5YtrmyRdYRi2RsoQUGjSyQZyOOgomNHHgjg5yoF4w7WiSCGpCFAdDHykrnF7a02Hsd
HVky5xExAyt1YqncORKAYkfLmtiW/vnh78/t5++7z+P31+F9r41I7Cttf85xxCVLDzMgqEbw
AfnEMLOCmlR/OlI8c/x/wwR05xx8AAA=

--f2QGlHpHGjS2mn6Y--

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAPyzrUaz2rXW+gJcRAoEFAJ4y0z1OFZNm1h71VTskqdkTkS1eIACgo2KK
5HWMIKFKkP1RR0c0B8lrktk=
=3aOS
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
