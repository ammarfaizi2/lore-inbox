Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWBUXHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWBUXHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBUXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:07:33 -0500
Received: from xenotime.net ([66.160.160.81]:4489 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751205AbWBUXHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:07:32 -0500
Date: Tue, 21 Feb 2006 15:07:29 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Ariel Garcia <garcia@iwr.fzk.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
In-Reply-To: <200602212350.33394.garcia@iwr.fzk.de>
Message-ID: <Pine.LNX.4.58.0602211457430.8603@shark.he.net>
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de>
 <Pine.LNX.4.58.0602210903260.8603@shark.he.net> <200602212350.33394.garcia@iwr.fzk.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1606286688-402438957-1140563249=:8603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1606286688-402438957-1140563249=:8603
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 21 Feb 2006, Ariel Garcia wrote:

> Hi Randy, Jens,
>
> > > The first thing to try is to add the acpi addon from Randy and see if
> > > that helps at all. Looking at the log, the first command we issue
> > > after resume times out which smells a lot like an unlock command
> > > missing (which is typically in the GTF list from acpi).
> >
> > Ariel-
> > These patches (for 2.6.16-rc3) are at
> >http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-2616-rc3.patch
> > in case you didn't find them yet.
>
> yes, thanks! i had found them, but i hadn't reported yet because it didn't
> work (exactly the same output as w/o the patch) and i wanted to enable
> your new debugging functionality to get some additional feedback.
>
> So at least now (printk=255) i can see that there seems to be an error
> _before_ the suspend, just when loading the GTFs (whatever they are ;-)

The ACPI "_GTF" method "gets taskfiles" (=> GTF).  Taskfiles
are one or more arrays of ATA-interface registers.

> do_drive_get_GTF: ERR: ata_dev_present: 0, PORT_DISABLED: 0
> ata_acpi_exec_tfs: get_GTF error (-19)
> ata_acpi_exec_tfs: ret=-19
>
> but no extra debugging output after the suspend/restart. Does that help?
> dmesg output attached.

The "error" is only for the second drive (ix=1, which you don't have,
right?).  I guess I need to disable that message.

Please add this additional patch (attached) (credit: SUSE) and
let us know if it helps.  Meanwhile I will check the resume
path to see if I notice anything that is missing.

-- 
~Randy
---1606286688-402438957-1140563249=:8603
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sata-acpi-fsc-debug.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0602211507290.8603@shark.he.net>
Content-Description: 
Content-Disposition: attachment; filename="sata-acpi-fsc-debug.patch"

LS0tIGxpbnV4LTIuNi4xNS9kcml2ZXJzL2FjcGkvcGNpX2xpbmsuYy5vcmln
CTIwMDYtMDItMTQgMTM6NTE6NDQuMDA5MTc2OTU0ICswMTAwDQorKysgbGlu
dXgtMi42LjE1L2RyaXZlcnMvYWNwaS9wY2lfbGluay5jCTIwMDYtMDItMTUg
MTM6MzI6NDUuNjU5MjIxODY3ICswMTAwDQpAQCAtODAzLDYgKzgwMyw3IEBA
IHN0YXRpYyBpbnQgaXJxcm91dGVyX3Jlc3VtZShzdHJ1Y3Qgc3lzX2QNCiAJ
c3RydWN0IGxpc3RfaGVhZCAqbm9kZSA9IE5VTEw7DQogCXN0cnVjdCBhY3Bp
X3BjaV9saW5rICpsaW5rID0gTlVMTDsNCiANCisJcHJpbnRrKEtFUk5fREVC
VUcgImlycXJvdXRlcl9yZXN1bWU6IEVOVEVSXG4iKTsNCiAJQUNQSV9GVU5D
VElPTl9UUkFDRSgiaXJxcm91dGVyX3Jlc3VtZSIpOw0KIA0KIAlhY3BpX2lu
X3Jlc3VtZSA9IDE7DQpAQCAtODE1LDYgKzgxNiw3IEBAIHN0YXRpYyBpbnQg
aXJxcm91dGVyX3Jlc3VtZShzdHJ1Y3Qgc3lzX2QNCiAJCWFjcGlfcGNpX2xp
bmtfcmVzdW1lKGxpbmspOw0KIAl9DQogCWFjcGlfaW5fcmVzdW1lID0gMDsN
CisJcHJpbnRrKEtFUk5fREVCVUcgImlycXJvdXRlcl9yZXN1bWU6IEVYSVRc
biIpOw0KIAlyZXR1cm5fVkFMVUUoMCk7DQogfQ0KIA0KLS0tIGxpbnV4LTIu
Ni4xNS9kcml2ZXJzL3Njc2kvbGliYXRhLWNvcmUuYy5vcmlnCTIwMDYtMDIt
MTYgMTI6Mjk6NDkuODA1NTI0OTIyICswMTAwDQorKysgbGludXgtMi42LjE1
L2RyaXZlcnMvc2NzaS9saWJhdGEtY29yZS5jCTIwMDYtMDItMTYgMTI6MzE6
NDUuMTkxNjAzODQ5ICswMTAwDQpAQCAtNDI5NiwxMyArNDI5NiwxNyBAQCBz
dGF0aWMgaW50IGF0YV9zdGFydF9kcml2ZShzdHJ1Y3QgYXRhX3BvDQogICov
DQogaW50IGF0YV9kZXZpY2VfcmVzdW1lKHN0cnVjdCBhdGFfcG9ydCAqYXAs
IHN0cnVjdCBhdGFfZGV2aWNlICpkZXYpDQogew0KKwlwcmludGsoS0VSTl9E
RUJVRyAiYXRhJWQ6IHJlc3VtZSBkZXZpY2VcbiIsIGFwLT5pZCk7DQorDQor
CVdBUk5fT04gKGlycXNfZGlzYWJsZWQoKSk7DQorDQorCWlmICghYXRhX2Rl
dl9wcmVzZW50KGRldikpDQorCQlyZXR1cm4gMDsNCisJYXRhX2FjcGlfZXhl
Y190ZnMoYXApOw0KIAlpZiAoYXAtPmZsYWdzICYgQVRBX0ZMQUdfU1VTUEVO
REVEKSB7DQogCQlhcC0+ZmxhZ3MgJj0gfkFUQV9GTEFHX1NVU1BFTkRFRDsN
CiAJCWF0YV9zZXRfbW9kZShhcCk7DQogCX0NCi0JaWYgKCFhdGFfZGV2X3By
ZXNlbnQoZGV2KSkNCi0JCXJldHVybiAwOw0KLQlhdGFfYWNwaV9leGVjX3Rm
cyhhcCk7DQogCWlmIChkZXYtPmNsYXNzID09IEFUQV9ERVZfQVRBKQ0KIAkJ
YXRhX3N0YXJ0X2RyaXZlKGFwLCBkZXYpOw0KIA0KQEAgLTQzMTgsNiArNDMy
Miw3IEBAIGludCBhdGFfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgYXRhX3BvcnQg
KmENCiAgKi8NCiBpbnQgYXRhX2RldmljZV9zdXNwZW5kKHN0cnVjdCBhdGFf
cG9ydCAqYXAsIHN0cnVjdCBhdGFfZGV2aWNlICpkZXYpDQogew0KKwlwcmlu
dGsoS0VSTl9ERUJVRyAiYXRhJWQ6IHN1c3BlbmQgZGV2aWNlXG4iLCBhcC0+
aWQpOw0KIAlpZiAoIWF0YV9kZXZfcHJlc2VudChkZXYpKQ0KIAkJcmV0dXJu
IDA7DQogCWlmIChkZXYtPmNsYXNzID09IEFUQV9ERVZfQVRBKQ0KQEAgLTUw
OTgsNiArNTEwMyw3IEBAIGludCBwY2lfdGVzdF9jb25maWdfYml0cyhzdHJ1
Y3QgcGNpX2RldiANCiANCiBpbnQgYXRhX3BjaV9kZXZpY2Vfc3VzcGVuZChz
dHJ1Y3QgcGNpX2RldiAqcGRldiwgcG1fbWVzc2FnZV90IHN0YXRlKQ0KIHsN
CisJZGV2X3ByaW50ayhLRVJOX0RFQlVHLCAmcGRldi0+ZGV2LCAic3VzcGVu
ZCBQQ0kgZGV2aWNlXG4iKTsNCiAJcGNpX3NhdmVfc3RhdGUocGRldik7DQog
CXBjaV9kaXNhYmxlX2RldmljZShwZGV2KTsNCiAJcGNpX3NldF9wb3dlcl9z
dGF0ZShwZGV2LCBQQ0lfRDNob3QpOw0KQEAgLTUxMDYsNiArNTExMiw3IEBA
IGludCBhdGFfcGNpX2RldmljZV9zdXNwZW5kKHN0cnVjdCBwY2lfZGUNCiAN
CiBpbnQgYXRhX3BjaV9kZXZpY2VfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2KQ0KIHsNCisJZGV2X3ByaW50ayhLRVJOX0RFQlVHLCAmcGRldi0+ZGV2
LCAicmVzdW1lIFBDSSBkZXZpY2VcbiIpOw0KIAlwY2lfc2V0X3Bvd2VyX3N0
YXRlKHBkZXYsIFBDSV9EMCk7DQogCXBjaV9yZXN0b3JlX3N0YXRlKHBkZXYp
Ow0KIAlwY2lfZW5hYmxlX2RldmljZShwZGV2KTsNCg==

---1606286688-402438957-1140563249=:8603--
