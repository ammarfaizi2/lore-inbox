Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSCWBYV>; Fri, 22 Mar 2002 20:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSCWBXF>; Fri, 22 Mar 2002 20:23:05 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293041AbSCWBPW>;
	Fri, 22 Mar 2002 20:15:22 -0500
Date: Fri, 22 Mar 2002 14:48:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Chua <jchua@fedex.com>
Subject: Re: [PATCH] 2.4.19-pre4 ide-probe
In-Reply-To: <Pine.LNX.4.44.0203210853510.24355-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.10.10203221447260.11833-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-279076291-1016837291=:11833"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-279076291-1016837291=:11833
Content-Type: text/plain; charset=us-ascii


This is the bases of the codes origin.

Comments?

Andre Hedrick
LAD Storage Consulting Group

On Thu, 21 Mar 2002, Jeff Chua wrote:

> 
> Marcelo, Andre,
> 
> Someone apparently added the "hook", but it was never used in the kernel,
> 
> What is ide_xlate_1024 referring to?
> 
> Jeff
> 
> ---------- Forwarded message ----------
> Date: Thu, 14 Mar 2002 11:22:27 +0800 (SGT)
> From: Jeff Chua <jeffchua@silk.corp.fedex.com>
> To: Linux Kernel <linux-kernel@vger.kernel.org>,
>      Marcelo Tosatti <marcelo@conectiva.com.br>
> Cc: Jeff Chua <jchua@fedex.com>
> Subject: [PATCH] 2.4.19-pre3 ide_xlate_1024_hook ???
> 
> 
> It seems that the "ide_xlate_1024_hook" is redundant in
> ./drivers/ide/ide-probe.c
> 
> It's not used anywhere by the kernel, and it caused "depmod" to fail
> with unknown ide_xlate_1024_hook symbol.
> 
> 
> Jeff
> 
> Patch ...
> 
> --- ./drivers/ide/ide-probe.c.org       Thu Mar 14 11:01:20 2002
> +++ ./drivers/ide/ide-probe.c   Thu Mar 14 11:03:16 2002
> @@ -987,7 +987,6 @@
>  }
> 
>  #ifdef MODULE
> -extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
> 
>  int init_module (void)
>  {
> @@ -997,14 +996,12 @@
>                 ide_unregister(index);
>         ideprobe_init();
>         create_proc_ide_interfaces();
> -       ide_xlate_1024_hook = ide_xlate_1024;
>         return 0;
>  }
> 
>  void cleanup_module (void)
>  {
>         ide_probe = NULL;
> -       ide_xlate_1024_hook = 0;
>  }
>  MODULE_LICENSE("GPL");
>  #endif /* MODULE */
> 
> 
> 

--1430322656-279076291-1016837291=:11833
Content-Type: text/plain; charset=us-ascii; name="debian.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10203221448110.11833@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="debian.patch"

LS0tIGxpbnV4LTIuNC4xMi5kZWJpYW4vZHJpdmVycy9pZGUvaWRlLWdlb21l
dHJ5LmMub3JpZwlUaHUgSmFuICA0IDEyOjUwOjE3IDIwMDENCisrKyBsaW51
eC0yLjQuMTIuZGViaWFuL2RyaXZlcnMvaWRlL2lkZS1nZW9tZXRyeS5jCVNh
dCBPY3QgMjcgMjE6NTA6MjMgMjAwMQ0KQEAgLTYsNiArNiw4IEBADQogI2lu
Y2x1ZGUgPGxpbnV4L21jMTQ2ODE4cnRjLmg+DQogI2luY2x1ZGUgPGFzbS9p
by5oPg0KIA0KKyNpZmRlZiBDT05GSUdfQkxLX0RFVl9JREUNCisNCiAvKg0K
ICAqIFdlIHF1ZXJ5IENNT1MgYWJvdXQgaGFyZCBkaXNrcyA6IGl0IGNvdWxk
IGJlIHRoYXQgd2UgaGF2ZSBhIFNDU0kvRVNESS9ldGMNCiAgKiBjb250cm9s
bGVyIHRoYXQgaXMgQklPUyBjb21wYXRpYmxlIHdpdGggU1QtNTA2LCBhbmQg
dGh1cyBzaG93aW5nIHVwIGluIG91cg0KQEAgLTgwLDkgKzgyLDEwIEBADQog
CX0NCiAjZW5kaWYNCiB9DQorI2VuZGlmIC8qIENPTkZJR19CTEtfREVWX0lE
RSAqLw0KIA0KIA0KLSNpZmRlZiBDT05GSUdfQkxLX0RFVl9JREUNCisjaWYg
ZGVmaW5lZChDT05GSUdfQkxLX0RFVl9JREUpIHx8IGRlZmluZWQoQ09ORklH
X0JMS19ERVZfSURFX01PRFVMRSkNCiANCiBleHRlcm4gaWRlX2RyaXZlX3Qg
KiBnZXRfaW5mb19wdHIoa2Rldl90KTsNCiBleHRlcm4gdW5zaWduZWQgbG9u
ZyBjdXJyZW50X2NhcGFjaXR5IChpZGVfZHJpdmVfdCAqKTsNCkBAIC0yMTQs
NCArMjE3LDQgQEANCiAJCSAgICAgICBkcml2ZS0+Ymlvc19jeWwsIGRyaXZl
LT5iaW9zX2hlYWQsIGRyaXZlLT5iaW9zX3NlY3QpOw0KIAlyZXR1cm4gcmV0
Ow0KIH0NCi0jZW5kaWYgLyogQ09ORklHX0JMS19ERVZfSURFICovDQorI2Vu
ZGlmIC8qIGRlZmluZWQoQ09ORklHX0JMS19ERVZfSURFKSB8fCBkZWZpbmVk
KENPTkZJR19CTEtfREVWX0lERV9NT0RVTEUpICovDQotLS0gbGludXgtMi40
LjEyLmRlYmlhbi9kcml2ZXJzL2lkZS9pZGUtcHJvYmUuYy5vcmlnCVNhdCBT
ZXAgIDggMTI6MDI6MzIgMjAwMQ0KKysrIGxpbnV4LTIuNC4xMi5kZWJpYW4v
ZHJpdmVycy9pZGUvaWRlLXByb2JlLmMJU2F0IE9jdCAyNyAyMTo1MDoyMyAy
MDAxDQpAQCAtOTEzLDYgKzkxMyw4IEBADQogfQ0KIA0KICNpZmRlZiBNT0RV
TEUNCitleHRlcm4gaW50ICgqaWRlX3hsYXRlXzEwMjRfaG9vaykoa2Rldl90
LCBpbnQsIGludCwgY29uc3QgY2hhciAqKTsNCisNCiBpbnQgaW5pdF9tb2R1
bGUgKHZvaWQpDQogew0KIAl1bnNpZ25lZCBpbnQgaW5kZXg7DQpAQCAtOTIx
LDExICs5MjMsMTMgQEANCiAJCWlkZV91bnJlZ2lzdGVyKGluZGV4KTsNCiAJ
aWRlcHJvYmVfaW5pdCgpOw0KIAljcmVhdGVfcHJvY19pZGVfaW50ZXJmYWNl
cygpOw0KKwlpZGVfeGxhdGVfMTAyNF9ob29rID0gaWRlX3hsYXRlXzEwMjQ7
DQogCXJldHVybiAwOw0KIH0NCiANCiB2b2lkIGNsZWFudXBfbW9kdWxlICh2
b2lkKQ0KIHsNCiAJaWRlX3Byb2JlID0gTlVMTDsNCisJaWRlX3hsYXRlXzEw
MjRfaG9vayA9IDA7DQogfQ0KICNlbmRpZiAvKiBNT0RVTEUgKi8NCi0tLSBs
aW51eC0yLjQuMTIuZGViaWFuL2ZzL3BhcnRpdGlvbnMvTWFrZWZpbGUub3Jp
ZwlUaHUgSnVsIDI2IDE2OjMwOjA0IDIwMDENCisrKyBsaW51eC0yLjQuMTIu
ZGViaWFuL2ZzL3BhcnRpdGlvbnMvTWFrZWZpbGUJU2F0IE9jdCAyNyAyMTo1
MDoyNCAyMDAxDQpAQCAtOSw3ICs5LDcgQEANCiANCiBPX1RBUkdFVCA6PSBw
YXJ0aXRpb25zLm8NCiANCi1leHBvcnQtb2JqcyA6PSBjaGVjay5vIGlibS5v
DQorZXhwb3J0LW9ianMgOj0gY2hlY2subyBpYm0ubyBtc2Rvcy5vDQogDQog
b2JqLXkgOj0gY2hlY2subw0KIA0KLS0tIGxpbnV4LTIuNC4xMi5kZWJpYW4v
ZnMvcGFydGl0aW9ucy9tc2Rvcy5jLm9yaWcJTW9uIE9jdCAgMSAyMDowMzoy
NiAyMDAxDQorKysgbGludXgtMi40LjEyLmRlYmlhbi9mcy9wYXJ0aXRpb25z
L21zZG9zLmMJU2F0IE9jdCAyNyAyMTo1MDoyNSAyMDAxDQpAQCAtMjksNyAr
MjksMTMgQEANCiANCiAjaWZkZWYgQ09ORklHX0JMS19ERVZfSURFDQogI2lu
Y2x1ZGUgPGxpbnV4L2lkZS5oPgkvKiBJREUgeGxhdGUgKi8NCi0jZW5kaWYg
LyogQ09ORklHX0JMS19ERVZfSURFICovDQorI2VsaWYgZGVmaW5lZChDT05G
SUdfQkxLX0RFVl9JREVfTU9EVUxFKQ0KKyNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCisNCitpbnQgKCppZGVfeGxhdGVfMTAyNF9ob29rKShrZGV2X3Qs
IGludCwgaW50LCBjb25zdCBjaGFyICopOw0KK0VYUE9SVF9TWU1CT0woaWRl
X3hsYXRlXzEwMjRfaG9vayk7DQorI2RlZmluZSBpZGVfeGxhdGVfMTAyNCBp
ZGVfeGxhdGVfMTAyNF9ob29rDQorI2VuZGlmDQogDQogI2luY2x1ZGUgPGFz
bS9zeXN0ZW0uaD4NCiANCkBAIC00NzAsNyArNDc2LDcgQEANCiAgKi8NCiBz
dGF0aWMgaW50IGhhbmRsZV9pZGVfbWVzcyhzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICpiZGV2KQ0KIHsNCi0jaWZkZWYgQ09ORklHX0JMS19ERVZfSURFDQorI2lm
IGRlZmluZWQoQ09ORklHX0JMS19ERVZfSURFKSB8fCBkZWZpbmVkKENPTkZJ
R19CTEtfREVWX0lERV9NT0RVTEUpDQogCVNlY3RvciBzZWN0Ow0KIAl1bnNp
Z25lZCBjaGFyICpkYXRhOw0KIAlrZGV2X3QgZGV2ID0gdG9fa2Rldl90KGJk
ZXYtPmJkX2Rldik7DQpAQCAtNDc4LDYgKzQ4NCwxMCBAQA0KIAlpbnQgaGVh
ZHMgPSAwOw0KIAlzdHJ1Y3QgcGFydGl0aW9uICpwOw0KIAlpbnQgaTsNCisj
aWZkZWYgQ09ORklHX0JMS19ERVZfSURFX01PRFVMRQ0KKwlpZiAoIWlkZV94
bGF0ZV8xMDI0KQ0KKwkJcmV0dXJuIDE7DQorI2VuZGlmDQogCS8qDQogCSAq
IFRoZSBpMzg2IHBhcnRpdGlvbiBoYW5kbGluZyBwcm9ncmFtcyB2ZXJ5IG9m
dGVuDQogCSAqIG1ha2UgcGFydGl0aW9ucyBlbmQgb24gY3lsaW5kZXIgYm91
bmRhcmllcy4NCkBAIC01MzksNyArNTQ5LDcgQEANCiAJLyogRmx1c2ggdGhl
IGNhY2hlICovDQogCWludmFsaWRhdGVfYmRldihiZGV2LCAxKTsNCiAJdHJ1
bmNhdGVfaW5vZGVfcGFnZXMoYmRldi0+YmRfaW5vZGUtPmlfbWFwcGluZywg
MCk7DQotI2VuZGlmIC8qIENPTkZJR19CTEtfREVWX0lERSAqLw0KKyNlbmRp
ZiAvKiBkZWZpbmVkKENPTkZJR19CTEtfREVWX0lERSkgfHwgZGVmaW5lZChD
T05GSUdfQkxLX0RFVl9JREVfTU9EVUxFKSAqLw0KIAlyZXR1cm4gMTsNCiB9
DQogIA0K
--1430322656-279076291-1016837291=:11833--
