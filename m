Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVE0PD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVE0PD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVE0PD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:03:27 -0400
Received: from fenyo.mail.t-online.hu ([195.228.240.95]:15109 "EHLO
	fenyo.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261790AbVE0PDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:03:03 -0400
Subject: [2.6.12-rc2 - 2.6.12-rc5] oops with vmware
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jb7+KsSNKzV2/Jmletu3"
Date: Fri, 27 May 2005 17:02:00 +0200
Message-Id: <1117206120.1954.7.camel@alderaan.trey.hu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-VBMilter: scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jb7+KsSNKzV2/Jmletu3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

I have a problem with running vmware on between 2.6.12-rc2 and
2.6.12-rc5 kernels. I have no problem with 2.6.12-rc1.

Before running vmware:
------------------------------------

$ lsmod
Module                  Size  Used by
sch_tbf                 4992  1
ipv6                  243264  13
udf                    84868  0
ohci_hcd               19588  0
ac                      3588  0
fan                     3332  0
usb_storage            30212  0
i810_audio             34580  1
ac97_codec             18444  1 i810_audio

Starting vmware:
--------------------------

root@alderaan:/home/trey $ /etc/init.d/vmware start
Starting VMware services:
   Virtual machine monitor
done
   Virtual ethernet
done
   Bridged networking on /dev/vmnet0
done
   Host-only networking on /dev/vmnet1 (background)
done
   Host-only networking on /dev/vmnet2 (background)
done

Interfaces:
----------------

root@alderaan:/home/trey $ ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:828 errors:0 dropped:0 overruns:0 frame:0
          TX packets:828 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:151842 (148.2 KiB)  TX bytes:151842 (148.2 KiB)

vmnet1    Link encap:Ethernet  HWaddr 00:50:56:C0:00:01
          inet addr:192.168.5.1  Bcast:192.168.5.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fec0:1/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

vmnet2    Link encap:Ethernet  HWaddr 00:50:56:C0:00:02
          inet addr:192.168.10.1  Bcast:192.168.10.255
Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fec0:2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

(1800MHz 46C) root@alderaan:/home/trey $

I try pulling up eth0 interface:
----------------------------------------------

root@alderaan:/home/trey $ ifconfig eth0 up
Segmentation fault.

root@alderaan:/home/trey $ dmesg

[...]

vmmon: module license 'unspecified' taints kernel.
/dev/vmmon[2287]: Module vmmon: registered with major=3D10 minor=3D165
/dev/vmmon[2287]: Module vmmon: initialized
/dev/vmnet: open called by PID 2306 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: peer interface eth0 not found, will wait for it to come up
bridge-eth0: attached
/dev/vmnet: open called by PID 2353 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 2352 (vmnet-netifup)
/dev/vmnet: hub 2 does not exist, allocating memory.
/dev/vmnet: port on hub 2 successfully opened
/dev/vmnet: open called by PID 2375 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 2374 (vmnet-dhcpd)
/dev/vmnet: port on hub 2 successfully opened
vmnet1: no IPv6 routers present
vmnet2: no IPv6 routers present
eth0: link down
bridge-eth0: enabling the bridge
Unable to handle kernel NULL pointer dereference at virtual address
00000069
 printing eip:
c0330b5f
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: vmnet vmmon sch_tbf ipv6 udf ohci_hcd ac fan
usb_storage i810_audio ac97_codec
CPU:    0
EIP:    0060:[<c0330b5f>]    Tainted: P      VLI
EFLAGS: 00210286   (2.6.12-rc5)
EIP is at sk_alloc+0xf/0xe0
eax: 00000020   ebx: de9c4000   ecx: 0000000b   edx: 00000020
esi: 00000001   edi: dd52a60c   ebp: 00000000   esp: de9c5e00
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 2415, threadinfo=3Dde9c4000 task=3De3ac3520)
Stack: 0000ac7d c1788000 de9c4000 dd52a600 dd52a60c 00000000 f0c5ad34
00000010
       00000020 00000001 00000000 dd52a600 c1788005 dd52a611 dd52a60c
f0c5af22
       dd52a600 dd52a60c c1788000 00000001 dd52a600 c1788000 00000001
00000000
Call Trace:
 [<f0c5ad34>] VNetBridgeUp+0xf4/0x1f0 [vmnet]
 [<f0c5af22>] VNetBridgeNotify+0x82/0x170 [vmnet]
 [<c012646d>] notifier_call_chain+0x2d/0x50
 [<c0337cb6>] dev_open+0x76/0xa0
 [<c0339403>] dev_change_flags+0x53/0x130
 [<c0337b95>] dev_load+0x25/0x70
 [<c0379e97>] devinet_ioctl+0x247/0x5a0
 [<c037c346>] inet_ioctl+0x66/0xb0
 [<c032e7d9>] sock_ioctl+0xd9/0x240
 [<c0169f8e>] do_ioctl+0x8e/0xa0
 [<c016a155>] vfs_ioctl+0x65/0x1f0
 [<c01565ee>] get_unused_fd+0x5e/0xd0
 [<c016a325>] sys_ioctl+0x45/0x70
 [<c0102c15>] syscall_call+0x7/0xb
Code: 41 7c c1 e8 0b e9 62 fd ff ff 0f b6 41 02 3c 0a 0f 94 c0 e9 07 fe
ff ff 8d 74 26 00 55 57 56 53 83 ec 08 8b 74 24 24 8b 54 24 20 <8b> 46
68 85 c0 0f 84 a6 00 00 00 89 54 24 04 89 04 24 e8 6a 0b
 <6>note: ifconfig[2415] exited with preempt_count 1

After oops:
-----------------

$ lsmod
Module                  Size  Used by
vmnet                  27044  10
vmmon                 104236  0
sch_tbf                 4992  0
ipv6                  243264  12
udf                    84868  0
ohci_hcd               19588  0
ac                      3588  0
fan                     3332  0
usb_storage            30212  0
i810_audio             34580  1
ac97_codec             18444  1 i810_audio
root@alderaan:/home/trey $

With 2.6.12-rc1 vmware running perfectly.

Any idea?=20

Thanks in advance.

-
MG

--=-Jb7+KsSNKzV2/Jmletu3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ez az =?ISO-8859-1?Q?=FCzenetr=E9sz?=
	=?ISO-8859-1?Q?_digit=E1lis?= =?ISO-8859-1?Q?_al=E1=EDr=E1ssal?= van
	=?ISO-8859-1?Q?ell=E1tva?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBClzZoo75Oas+VX1ARAvfjAJ9C2L9qAaxGsTQHr+pmziB5SgvtIgCeKqiE
His833uIMRJy5/yJuO0Xnlc=
=EKGI
-----END PGP SIGNATURE-----

--=-Jb7+KsSNKzV2/Jmletu3--

