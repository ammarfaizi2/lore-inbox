Return-Path: <linux-kernel-owner+w=401wt.eu-S1752633AbWLYVrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWLYVrw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbWLYVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 16:47:52 -0500
Received: from squawk.glines.org ([72.36.206.66]:58306 "EHLO squawk.glines.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbWLYVrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 16:47:51 -0500
Message-ID: <459046FE.9030008@glines.org>
Date: Mon, 25 Dec 2006 13:47:42 -0800
From: Mark Glines <mark@glines.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061221)
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  powerpc: linkstation uses uimage style zImages
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no> <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no> <45902A6F.4000100@glines.org> <Pine.LNX.4.60.0612252128530.3424@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612252128530.3424@poirot.grange>
Content-Type: multipart/mixed;
 boundary="------------030108020406060304010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108020406060304010101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Guennadi Liakhovetski wrote:
> On Mon, 25 Dec 2006, Mark Glines wrote:
>> Followup:  Yeah, it looks like it just doesn't know which format of zImage to
>> produce for linkstation.
>>
>> I'm not sure what image should be used by default.  I guess it depends on the
>> bootloader.  Maybe default to uImage, as uBoot seems to be fairly common on
>> these devices?
> 
> Yes, uImage is the format used on linkstation. Is there a way to cleanly 
> specify this in the kernel sources apart from a comment in Kconfig?

Yep.  Kconfig just needs to select DEFAULT_UIMAGE, and then the system 
tries to build a uImage.

Once I tracked down and installed a "mkimage" command (dependency needed 
by the WRAP line), my "make zImage" succeeded.  So, I hope you guys 
apply this.

...

   GEN     .version
   LD      .tmp_vmlinux1
   KSYM    .tmp_kallsyms1.S
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
   SYSMAP  System.map
   SYSMAP  .tmp_System.map
   MODPOST vmlinux
   WRAP    arch/powerpc/boot/uImage
Image Name:   Linux-2.6.20-rc2-kuroboxHG
Created:      Sun Dec 24 19:24:12 2006
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1673973 Bytes = 1634.74 kB = 1.60 MB
Load Address: 0x00000000
Entry Point:  0x00000000
paranoid@kuro-2 /usr/src/linux $


Signed-off-by: Mark Glines <mark@glines.org>

--------------030108020406060304010101
Content-Type: text/plain;
 name="linkstation-uses-uimage.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="linkstation-uses-uimage.diff"

LS0tIGxpbnV4LTIuNi4yMC1yYzIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9lbWJlZGRlZDZ4
eC9LY29uZmlnLm9yaWcJMjAwNi0xMi0yNCAxOToxMzo0OS4wMDAwMDAwMDAgLTA4MDAKKysr
IGxpbnV4LTIuNi4yMC1yYzIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9lbWJlZGRlZDZ4eC9L
Y29uZmlnCTIwMDYtMTItMjQgMTk6MTQ6MDIuMDAwMDAwMDAwIC0wODAwCkBAIC03OSw2ICs3
OSw3IEBACiAJc2VsZWN0IE1QSUMKIAlzZWxlY3QgRlNMX1NPQwogCXNlbGVjdCBQUENfVURC
R18xNjU1MCBpZiBTRVJJQUxfODI1MAorCXNlbGVjdCBERUZBVUxUX1VJTUFHRQogCWhlbHAK
IAkgIFNlbGVjdCBMSU5LU1RBVElPTiBpZiBjb25maWd1cmluZyBmb3Igb25lIG9mIFBQQy0g
KE1QQzgyNDEpCiAJICBiYXNlZCBOQVMgc3lzdGVtcyBmcm9tIEJ1ZmZhbG8gVGVjaG5vbG9n
eS4gU28gZmFyIG9ubHkK
--------------030108020406060304010101--
