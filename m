Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRFKSdM>; Mon, 11 Jun 2001 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbRFKSdD>; Mon, 11 Jun 2001 14:33:03 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:8651 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263334AbRFKScs>; Mon, 11 Jun 2001 14:32:48 -0400
From: DJBARROW@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256A68.0065E17F.00@d12mta09.de.ibm.com>
Date: Mon, 11 Jun 2001 20:32:03 +0200
Subject: bug in /net/core/dev.c
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=7yPzFievLxeXCYwohbTiBGmcH5CXNDxRTIXhEyK2hGgoFFK6oFEtO9fs"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=7yPzFievLxeXCYwohbTiBGmcH5CXNDxRTIXhEyK2hGgoFFK6oFEtO9fs
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable




Hi,
I found this bug in dev.c

It happens if register_netdevice is called before net_dev_init which ca=
n
happen from init functions,
when device drivers are compiled into the kernel.

The dev->refcnt will go up to 2 ( it should be 1) unregister_netdevice =
will
usually  loop forever
waiting for the refcnt to drop to 1 when an attempt to unregister is do=
ne.

The printk in the bootmessages early initialization of device <blah> is=

deferred is evidence of this behaviour occuring.

The small patch is below ,hope it is okay for you.

(See attached file: dev.c.2.4.5.patch)

D.J. Barrow Gnu/Linux for S/390 kernel developer
eMail: djbarrow@de.ibm.com,barrow_dj@yahoo.com
Phone: +49-(0)7031-16-2583
IBM Germany Lab, Sch=F6naicherstr. 220, 71032 B=F6blingen
=

--0__=7yPzFievLxeXCYwohbTiBGmcH5CXNDxRTIXhEyK2hGgoFFK6oFEtO9fs
Content-type: application/octet-stream; 
	name="dev.c.2.4.5.patch"
Content-Disposition: attachment; filename="dev.c.2.4.5.patch"
Content-transfer-encoding: base64

LS0tIG5ldC9jb3JlL2Rldi5vbGQuYwlNb24gSnVuIDExIDIwOjAwOjQyIDIwMDEKKysrIG5ldC9j
b3JlL2Rldi5jCU1vbiBKdW4gMTEgMTk6NTE6NTUgMjAwMQpAQCAtMjAsNiArMjAsOSBAQAogICog
ICAgICAgICAgICAgIFBla2thIFJpaWtvbmVuIDxwcmlpa29uZUBwb2VzaWRvbi5wc3B0LmZpPgog
ICoKICAqCUNoYW5nZXM6CisgKiAgICAgICAgICAgICAgRC5KLiBCYXJyb3cgICAgIDogICAgICAg
Rml4ZWQgbmV0X2Rldl9pbml0IGNhbGxpbmcgZGV2X2hvbGQgJiBzZXR0aW5nCisgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhlIGRldi0+cmVmY250IHRvIDIgaWYgcmVn
aXN0ZXJfbmV0ZGV2IGdldHMgCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2FsbGVkIGZpcnN0ICYgaW5pdGlhbGl6YXRpb24gaXMgZGVmZXJyZWQuCiAgKgkJQWxhbiBD
b3gJOglkZXZpY2UgcHJpdmF0ZSBpb2N0bCBjb3BpZXMgZmllbGRzIGJhY2suCiAgKgkJQWxhbiBD
b3gJOglUcmFuc21pdCBxdWV1ZSBjb2RlIGRvZXMgcmVsZXZhbnQgc3R1bnRzIHRvCiAgKgkJCQkJ
a2VlcCB0aGUgcXVldWUgc2FmZS4KQEAgLTI3MzMsOCArMjczNiwxMCBAQAogI2VuZGlmCiAJCWRl
di0+eG1pdF9sb2NrX293bmVyID0gLTE7CiAJCWRldi0+aWZsaW5rID0gLTE7Ci0JCWRldl9ob2xk
KGRldik7Ci0KKwkJLyogQ2FuJ3QgZG8gZGV2X2hvbGQgaGVyZSBpbiBjYXNlCisJCSAqICByZWdp
c3Rlcl9uZXRkZXYgZ2V0cyBjYWxsZWQgZmlyc3QuCisJCSAqLworCQlhdG9taWNfc2V0KCZkZXYt
PnJlZmNudCwxKTsKIAkJLyoKIAkJICogQWxsb2NhdGUgbmFtZS4gSWYgdGhlIGluaXQoKSBmYWls
cwogCQkgKiB0aGUgbmFtZSB3aWxsIGJlIHJlaXNzdWVkIGNvcnJlY3RseS4K

--0__=7yPzFievLxeXCYwohbTiBGmcH5CXNDxRTIXhEyK2hGgoFFK6oFEtO9fs--

