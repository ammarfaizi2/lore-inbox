Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUHSHYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUHSHYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUHSHYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:24:16 -0400
Received: from fmr12.intel.com ([134.134.136.15]:37862 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262574AbUHSHYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:24:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C485BD.724FFF89"
Subject: RE: 2.6.8.1: kernel panic rmmod'ing apm
Date: Thu, 19 Aug 2004 15:23:37 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F039A1831@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.8.1: kernel panic rmmod'ing apm
Thread-Index: AcSFhw4G435hvUUwTOSjTaYpmfRRBQANZThQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Brannon Klopfer" <plazmcman@softhome.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Aug 2004 07:23:39.0255 (UTC) FILETIME=[72AE3870:01C485BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C485BD.724FFF89
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
It possibly is a similar problem when we remmod processor module (idle
routine need be synchronized). Does the attached patch help?

Thanks,
Shaohua

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Brannon Klopfer
>Sent: Thursday, August 19, 2004 8:52 AM
>To: linux-kernel@vger.kernel.org
>Subject: 2.6.8.1: kernel panic rmmod'ing apm
>
>Linux littleblue 2.6.8.1 #81 Wed Aug 18 17:13:39 PDT 2004 i686 unknown
>unknown GNU/Linux
>
>Gnu C                  3.3.4
>Gnu make               3.80
>binutils               2.15.90.0.3
>util-linux             2.12a
>mount                  2.12a
>module-init-tools      3.0
>e2fsprogs              1.35
>jfsutils               1.1.6
>xfsprogs               2.6.13
>pcmcia-cs              3.2.7
>quota-tools            3.12.
>PPP                    2.4.2
>nfs-utils              1.0.6
>Linux C Library        2.3.2
>Dynamic linker (ldd)   2.3.2
>Linux C++ Library      5.0.6
>Procps                 3.2.1
>Net-tools              1.60
>Kbd                    1.12
>Sh-utils               5.2.1
>Modules Loaded         snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib
>snd_mpu401_uart snd_rawmidi snd_cs4231_lib nfsd exportfs intel_agp
>uhci_hcd serial_cs 3c574_cs ds yenta_socket pcmcia_core agpgart
>
>-----------------------------
>
>Hello,
>    When rmmod'ing apm, I get a kernel panic. However, the machine
>continues to function properly, AFAIK. Here's the dmesg:
>
>[snip]
>Unable to handle kernel paging request at virtual address d2d9f211
> printing eip:
>d2d9f211
>*pde =3D 01357067
>*pte =3D 00000000
>Oops: 0000 [#1]
>PREEMPT
>Modules linked in: snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib
>snd_mpu401_uart snd_rawmidi snd_cs4231_lib nfsd exportfs intel_agp
>uhci_hcd serial_cs 3c574_cs ds yenta_socket pcmcia_core agpgart
>CPU:    0
>EIP:    0060:[<d2d9f211>]    Not tainted
>EFLAGS: 00010246   (2.6.8.1)
>EIP is at 0xd2d9f211
>eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c03c0000
>esi: 00011ff9   edi: 00000202   ebp: 00000001   esp: c03c0f84
>ds: 007b   es: 007b   ss: 0068
>Process swapper (pid: 0, threadinfo=3Dc03c0000 task=3Dc033fa40)
>Stack: 00005305 00000000 00000000 00090000 c03e0000 c03c0000 00011ff9
>0000000a
>       00000001 d2d9f373 00005305 00000000 00000000 c03c0fbc 00005305
>d2d9f4ab
>       c03c0000 00099100 c03e0120 00423007 c0102164 c03c0000 c03c1723
>c033fa40
>Call Trace:
> [<c0102164>] cpu_idle+0x34/0x40
> [<c03c1723>] start_kernel+0x163/0x180
> [<c03c1340>] unknown_bootoption+0x0/0x160
>Code:  Bad EIP value.
> <0>Kernel panic: Attempted to kill the idle task!
>In idle task - not syncing
>
>[END]
>
>After that, the module is gone, and everything works fine. I just tried
>inserting and removeing it subsequent times, and it works with no
errors
>(so far). I only rmmod when apm is used by nothing.
>
>The only reason I'm messing around with the apm module is that Loki's
UT
>seems to (sometimes) run much too fast with APM support in kernel, and
>rmmod'ing it out seems to do the trick. This is probably indicitive of
>another problem, though my system seems pretty stable (other than that
>kernel panic...).
>
>All said, this doesn't bother me, as my system stays up.
>
>-Brannon Klopfer
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

------_=_NextPart_001_01C485BD.724FFF89
Content-Type: application/octet-stream;
	name="apm.patch"
Content-Transfer-Encoding: base64
Content-Description: apm.patch
Content-Disposition: attachment;
	filename="apm.patch"

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9hcG0uYyAxLjY1IHZzIGVkaXRlZCA9PT09PQotLS0gMS42
NS9hcmNoL2kzODYva2VybmVsL2FwbS5jCTIwMDQtMDctMDMgMTQ6MTc6MzAgKzA4OjAwCisrKyBl
ZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9hcG0uYwkyMDA0LTA4LTE5IDE1OjEwOjAzICswODowMApA
QCAtMjM2MCw4ICsyMzYwLDEwIEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBhcG1fZXhpdCh2b2lkKQog
ewogCWludAllcnJvcjsKIAotCWlmIChzZXRfcG1faWRsZSkKKwlpZiAoc2V0X3BtX2lkbGUpIHsK
IAkJcG1faWRsZSA9IG9yaWdpbmFsX3BtX2lkbGU7CisJCXN5bmNocm9uaXplX2tlcm5lbCgpOwor
CX0KIAlpZiAoKChhcG1faW5mby5iaW9zLmZsYWdzICYgQVBNX0JJT1NfRElTRU5HQUdFRCkgPT0g
MCkKIAkgICAgJiYgKGFwbV9pbmZvLmNvbm5lY3Rpb25fdmVyc2lvbiA+IDB4MDEwMCkpIHsKIAkJ
ZXJyb3IgPSBhcG1fZW5nYWdlX3Bvd2VyX21hbmFnZW1lbnQoQVBNX0RFVklDRV9BTEwsIDApOwo=

------_=_NextPart_001_01C485BD.724FFF89--
