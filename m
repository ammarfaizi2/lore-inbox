Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbUC3JBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbUC3JBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:01:13 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:34949 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S263542AbUC3JBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:01:04 -0500
Date: Tue, 30 Mar 2004 11:00:57 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.5-rc2-mm5 usb pl2303 oops on module remove
Message-Id: <20040330110057.1b46daa9@phoebee>
X-Mailer: Sylpheed version 0.9.10claws36 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__30_Mar_2004_11_00_57_+0200_be87uFoL+w+n9S0="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__30_Mar_2004_11_00_57_+0200_be87uFoL+w+n9S0=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there!

I get this if I 'rmmod pl2303':

usb 1-1: new full speed USB device using address 10
usb 1-1: USB disconnect, address 10
usb 1-1: new full speed USB device using address 11
usbserial 1-1:1.0: PL-2303 converter detected
usb 1-1: PL-2303 converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 5-2: new full speed USB device using address 4
drivers/usb/core/devio.c: proc_resetdevice - this function is broken
usb 5-2: USB disconnect, address 4
usb 5-2: new full speed USB device using address 5
usb 5-2: USB disconnect, address 5
PL-2303 ttyUSB0: pl2303_write - failed submitting write urb, error -19
PL-2303 ttyUSB0: pl2303_write - failed submitting write urb, error -19
PL-2303 ttyUSB0: pl2303_write - failed submitting write urb, error -19
PL-2303 ttyUSB0: pl2303_write - failed submitting write urb, error -19
PL-2303 ttyUSB0: PL-2303 converter now disconnected from ttyUSB0
usbcore: deregistering driver pl2303
drivers/usb/serial/usb-serial.c: USB Serial deregistering driver PL-2303
PL-2303 ttyUSB1: PL-2303 converter now disconnected from ttyUSB1
usbserial 1-1:1.0: device disconnected
Unable to handle kernel NULL pointer dereference at virtual address 0000003d
 printing eip:
c0268812
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0268812>]    Tainted: PF  VLI
EFLAGS: 00010286   (2.6.5-rc2-mm5) 
EIP is at kref_put+0x7/0x1d
eax: 0000003d   ebx: c94d0f9c   ecx: 00000003   edx: 0000003d
esi: 00000001   edi: c94d0f88   ebp: 00000000   esp: d9d97f18
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 24692, threadinfo=d9d96000 task=c8ced190)
Stack: 00000000 e09e30e7 0000003d c02bdc6d c46c2294 c94d0f80 00000001 e09ec7e0 
       e09e3470 c94d0f88 c46c2280 e09eb0f9 e09ec900 c04679fc 00000880 e09eb00f 
       e09ec7e0 c0130d01 e09ec900 00000880 d9d97f6c 00000000 33326c70 40003330 
Call Trace:
 [<e09e30e7>] usb_serial_disconnect+0x38/0x82 [usbserial]
 [<c02bdc6d>] device_release_driver+0x64/0x66
 [<e09e3470>] usb_serial_deregister+0xa8/0xac [usbserial]
 [<e09eb00f>] pl2303_exit+0x1b/0x1f [pl2303]
 [<c0130d01>] sys_delete_module+0x14d/0x19c
 [<c014519f>] do_munmap+0x146/0x183
 [<c03e48db>] syscall_call+0x7/0xb

Code: 00 c7 44 24 08 2b 6f 42 c0 c7 44 24 04 2a 92 3f c0 c7 04 24 61 aa 40 c0 e8
15 4c eb ff e8 a5 ea e9 ff eb c9 83 ec 04 8b 54 24 08 <ff> 0a 0f 94 c0 84 c0 75
04 83 c4 04 c3 89 14 24 ff 52 04 eb f4 

Is it because of my tainted kernel or is it a known bug?

Regards,
Martin

-- 
MyExcuse:
Operators killed when huge stack of backup tapes fell over.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Tue__30_Mar_2004_11_00_57_+0200_be87uFoL+w+n9S0=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAaTdJmjLYGS7fcG0RArtnAJsECh3HFDE54//Svfbw3VCeW7sixwCgorAC
Qz8Yzwu67N+OKrULAaB8fyI=
=hAIi
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Mar_2004_11_00_57_+0200_be87uFoL+w+n9S0=--
