Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbUKBOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUKBOTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUKBOPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:15:34 -0500
Received: from dialin-212-144-166-159.arcor-ip.net ([212.144.166.159]:12196
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261545AbUKBN7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:59:16 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-837659431"
To: Linux Mailing List Kernel <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: 2.6.8 and 2.6.9 Dual Opteron glitches
Date: Tue, 2 Nov 2004 14:59:03 +0100
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-6-837659431
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hija,

I've a few glitches with my brandnew dual Opteron System which I'd
like to share with you. First of all, all those problems seem to
be there with 2.6.8.1 and 2.6.9 but since this seemed to be the
case I moved on with 2.6.9 and hadn't investigated any further
on 2.6.8.1 so some of the issues might only apply to 2.6.9.

1) 32 bit kernel HPET calibration hang: If the kernel is compiled
    with HPET support, the kernel will hang on boot while
    calibrating the timer. The problem goes away if HPET support is
    not compiled in. I've no idea what information to provide to help
    debug this.

2) 64 bit kernel vgettimeofday panic: The kernel panics in
    arch/x64_64/vsyscall.c:169 on boot.

   static int __init vsyscall_init(void)
   {
           if ((unsigned long) &vgettimeofday != 
VSYSCALL_ADDR(__NR_vgettimeofday))
                   panic("vgettimeofday link addr broken");

   Replacing those panic(s) by printk make the machine boot just fine
   and also work (seemingly) without any problems under load.

3) Interrupt distribution 32 bit vs. 64 bit. Below is a copy of the
    current interrupt distribution for the 64 bit kernel which shows
    a huge shift towards CPU1. In a 32 bit kernel the distribution is
    reversed and even more visible than here since in total <100
    interupts will be handled by CPU1 after days of operation. The 64
    bit kernel has all relevant options for K8 (irq balancing,
    NUMA support, etc.) enabled.

            CPU0       CPU1
   0:      15260    4196668   IO-APIC-edge  timer
   9:          0          0   IO-APIC-level  acpi
169:          0          5   IO-APIC-level  ehci_hcd
177:          0          3   IO-APIC-level  uhci_hcd, ohci1394
185:       1999     934839   IO-APIC-level  uhci_hcd, eth0
NMI:       2698       2817
LOC:    4211263    4211263
ERR:          0
MIS:          0

4) ACPI powermanagement (32bit and 64bit): No matter which ACPI options
    I choose in the BIOS, ACPI will only handle the first CPU somewhat
    and leave the second CPU alone. I'd love to have some simple
    powermanagement because the system will get quite warm, even when
    idle, and warm == loud because the fans (which are barely noticeable
    when the system is cold) kick into gear quite fast.

processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C1
default state:           C1
bus master activity:     00000000
states:
    *C1:                  promotion[--] demotion[--] latency[000] 
usage[00000000]
     C2:                  <not supported>
     C3:                  <not supported>
state count:             8
active state:            T0
states:
    *T0:                  00%
     T1:                  12%
     T2:                  25%
     T3:                  37%
     T4:                  50%
     T5:                  62%
     T6:                  75%
     T7:                  87%

processor id:            1
acpi id:                 2
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C1
default state:           C1
bus master activity:     00000000
states:
    *C1:                  promotion[--] demotion[--] latency[000] 
usage[00000000]
     C2:                  <not supported>
     C3:                  <not supported>
<not supported>

Ask me for info, you'll get it. ;)

Servus,
       Daniel

--Apple-Mail-6-837659431
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQYeSpzBkNMiD99JrAQJuXQgAunpyySR4xH2oq4L8Rt6mJRY3LBkgFgeR
wl0ZLJuRZ9uyTqwvhFaVt6/OQnqUVm4nOBK2R6X+XxCcfq6pZLsxYZPHOWz86ag1
C0QB0FzlncHrI3SiGEUBC7JJrpGl/4suhKeOt6R+WZ5Te92aYg9rFuY2LXzELckn
fzzHr1h+Qqy5uanXq2kgyq1COUEl7b+hXssOLLTQtoOI8EMTSnwwNQZfnyBOV8YC
7EP3ZnIVDOJAA/KK1BZgPW0hPscUGufDZh2ggiQWKLh1tFvteX4LirJiYTxoqS28
qV0iH1Nnxr7amNl2jlbetZ8VH5GKa3FUdSRhqKoa3FW7A19ywZrQgw==
=NZy0
-----END PGP SIGNATURE-----

--Apple-Mail-6-837659431--

