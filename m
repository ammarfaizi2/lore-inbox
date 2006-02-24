Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWBXLjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWBXLjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBXLjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:39:10 -0500
Received: from mout0.freenet.de ([194.97.50.131]:22184 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932171AbWBXLjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:39:09 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Mapping to 0x0
Date: Fri, 24 Feb 2006 12:37:21 +0100
User-Agent: KMail/1.8.3
References: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200602241237.21628.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1882606.SQ8eM5HN5T";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1882606.SQ8eM5HN5T
Content-Type: multipart/mixed;
  boundary="Boundary-01=_x/u/DaGR+CrMDP1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_x/u/DaGR+CrMDP1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 February 2006 15:10, you wrote:
> The mmap() usually succeeds and maps something at address 0x00000000. Now=
=20
> what if the kernel would try to execute this (of course badly programmed)=
=20
> code in the context of this very process?
>=20
>     int (*callback)(int xyz) =3D NULL;
>     callback();
>=20
> Would not be the badcode be executed with kernel privileges?

I am playing around with it.
I did the attached code. It is a usermode program, which tries to map NULL,
and a kernel module, which calls a NULL pointer.
The file badcode.bin contains an i386 ud2 instruction.
When loading the kernel module, while the usermode program is executing,
I get the usual NULL pointer dereference oops:

Calling NULL pointer...
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde =3D 00000000
Oops: 0000 [#1]
SMP=20
Modules linked in: kernel nvidia video battery fan button thermal processor=
 ac nfs lockd sunrpc ath_pci ath_rate_sample wlan ath_hal usbhid tuner tvau=
dio msp3400 bttv video_buf firmware_class btcx_risc tveeprom ehci_hcd uhci_=
hcd usbcore intel_agp agpgart ext2
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P      VLI
EFLAGS: 00010246   (2.6.15)=20
EIP is at rest_init+0x3feffd68/0x20
eax: 00000000   ebx: f8bb6280   ecx: 00000000   edx: 00000206
esi: b7faf000   edi: f0435000   ebp: f0435000   esp: f0435fa0
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 6290, threadinfo=3Df0435000 task=3Df71d3030)
Stack: f8bb600e f8bb6020 c0130bc1 0804b018 b7faf000 08048514 c01026e3 0804b=
018=20
       000008bb 0804b008 b7faf000 08048514 bfbc17e8 00000080 0000007b c0100=
07b=20
       00000080 ffffe410 00000073 00000246 bfbc1770 0000007b 5a5a5a5a a55a5=
a5a=20
Call Trace:
 [<f8bb600e>] null_init+0xe/0x20 [kernel]
 [<c0130bc1>] sys_init_module+0xe4/0x1f7
 [<c01026e3>] sysenter_past_esp+0x54/0x75
Code:  Bad EIP value.

Either this really does not work, or I am doing something wrong. :)
Should I try to call the mmap syscall directly?
I can try this on ppc32, too.

=2D-=20
Greetings Michael.

--Boundary-01=_x/u/DaGR+CrMDP1
Content-Type: application/x-tbz;
  name="nulltest.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="nulltest.tar.bz2"

QlpoOTFBWSZTWdinPMwAA0l/i824gBBed/+/v+//9P////8AICAAAAQACFADvnd2Z2O0dsu1YMkE
00BNT0yYo0Mp4mkNAPSA0NGTQAND1B6hp6g0gCZU9pTzUgNGgAADRk0MgAAAAGgCU0RGkTT0Joaj
1NPSekANDQDQB6g0Boeo0GgAcNDRk0aNGmhkZDCAMgBkGmgAAZAyAJFIxCU80p+qZkeqfqj1NB6m
gNAANAaAGgAAGkvCjd3PI9e8NG9NDqaQO2FggFsaKhsRsBWziRhFt3SRMRmQxJQRiANQYMY2in96
f0MyrRwc6LEFZY6k9BMVUKuho4u3P5ut92bSapb6a1aSKKhw4JGL+rIUiC5yHEG1g+j0hOaY6UKQ
c6GCq7AQ3zW1eVd4DR2bSvvve8gcyJHKxOa5gj/vPOtaTQu6Pw380vUkeQLNbMnW+8XYVK+I964a
paFiMu6JNsnIQJcyTSTl8fcls57HJtgRrbrHCJnRPBOzWmQ9mHqY8fHc5d8iMpjGg2NNs8LEEtcm
gxIwWC1EBZpp24z6iJWAne52GAmx5RhGEqyitFprV0mPMy+S0SKMeRkbw4mtpQo6LCUga+/sAhfi
KTCAI9m6X+/aSURDQxEkp16NxyRGXeYbfUJKBiw0/Nnrto6JPNRWxgCJqIdhZ7K7RilbtdQUknRM
lK8EMPCGInNBS4x2+vsZV8smW+bDZk0IzK+ZHbFWzHYXWW8oR7hWcLA+3ouhUfURLgq2jcZk+fYV
3O2N+D3qDJiM+hzOcJp5Wu0j7FaXoQWj61qThaiT8bDXlFWfK2Rq6qJlT2nMIxzBM+mRhReRGSyY
wjW2BMDRKLtrSwQS+OtSxNGLwjwnC4X6tgFAgjAZp2YmzhVItaBJLGWX3tgTgpO8wbj3YVSMv9Pg
HVKiOSgjxH0TeRp5fXi1ce6nCExqqt0URIgcCgI1Z8+9tnkYot0XCATykCCNUqa3tmfAzpAq2kkL
ZcoN9ArsgElByoEkEHwNLFRA/pRBU0PzKBAXqsOwamCd1buxlo2wrOL7cv8yATQWayijPY6HGsOl
6gcbTYQJxdNLaRTKPhs1WSZQiaiBHdg7R3UMm1ZbQXEPFD79YG4iiJ6hRBJgiDEItgCKCvzsZxiF
GIpAsowK1UMIgxohSipBlwx5Vssfhiq4Yr3JphjXhndxampTTa/+gkneQsKYIJmlDMQBYexZJlXZ
bv68Wv+URCk5kt22I1V05QEZiMZysbsGKLOfjxq7q0NcmWwSYUNUwtoRVU7EXpZKNU9rEXGETlCZ
uhWsIAmOAnCHZi9aYoSIi4izBPkqQ9dxpxzVEIGlAULKhrOy94RLV1poNnFwRFSC229QWlnA3kSL
s5rLCGsXLMiwsGOI9PKEl/xdyRThQkNinPMw

--Boundary-01=_x/u/DaGR+CrMDP1--

--nextPart1882606.SQ8eM5HN5T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/u/xlb09HEdWDKgRAp8iAJ9+ivKGHU6AMBke0/X6oO5taS+8EQCgsvHz
P5/mYKRD2aHOsfEHcq5G0Fw=
=Sj9m
-----END PGP SIGNATURE-----

--nextPart1882606.SQ8eM5HN5T--
