Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUGISvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUGISvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUGISvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:51:49 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:35024 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265234AbUGISvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:51:43 -0400
Date: Fri, 9 Jul 2004 14:53:53 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Updated pci-skeleton.c
In-Reply-To: <40EDC4EC.1070609@pobox.com>
Message-ID: <Pine.LNX.4.60.0407091447360.6699@marabou.research.att.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com>
 <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax>
 <20040704191732.A20676@electric-eye.fr.zoreil.com>
 <20040706011401.A390@electric-eye.fr.zoreil.com> <40E9E6BC.8020608@pobox.com>
 <20040707005402.A15251@electric-eye.fr.zoreil.com> <40EB510F.2040801@metaparadigm.com>
 <Pine.LNX.4.60.0407071359530.3991@marabou.research.att.com> <40EDC4EC.1070609@pobox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1638575288-1089399233=:6699"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1638575288-1089399233=:6699
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Thu, 8 Jul 2004, Jeff Garzik wrote:

> Pavel Roskin wrote:
>> drivers/net/pci-skeleton.c doesn't have power management code, but the 
>> driver it was based on, 8139too.c, has such code and uses 
>> pci_set_power_state() after pci_(save|restore)_state().  Other well 
>> maintained drivers (e.g. e100.c) use pci_set_power_state() after 
>> pci_save_state() and before pci_restore_state().  I think it's reasonable 
>> to follow this example.  Jeff?
>
>
> Yeah, that's working code.  Feel free to cut-n-paste, and/or even update 
> pci-skeleton.c :)

Here it is.  The patch fixes all compile errors and warnings in 
pci-skeleton.c.  The "debug" parameter lacks corresponding variable, so I 
removed it to avoid a warning on module load.  Obsolete pci_power_on() and 
pci_power_off() have been replaced with the new code using 
pci_set_power_state(), pci_save_state() and pci_restore_state().  The 
driver has been tested by compiling it as module and as part of the 
kernel.

-- 
Regards,
Pavel Roskin
--8323328-1638575288-1089399233=:6699
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pci-skeleton.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0407091453530.6699@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="pci-skeleton.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9uZXQvcGNpLXNrZWxldG9uLmMNCisr
KyBsaW51eC9kcml2ZXJzL25ldC9wY2ktc2tlbGV0b24uYw0KQEAgLTQ4MSw2
ICs0ODEsNyBAQCBzdHJ1Y3QgbmV0ZHJ2X3ByaXZhdGUgew0KIAl1bnNpZ25l
ZCBpbnQgbWVkaWFzZW5zZToxOwkvKiBNZWRpYSBzZW5zaW5nIGluIHByb2dy
ZXNzLiAqLw0KIAlzcGlubG9ja190IGxvY2s7DQogCWNoaXBfdCBjaGlwc2V0
Ow0KKwl1MzIgcGNpX3N0YXRlWzE2XTsJLyogRGF0YSBzYXZlZCBkdXJpbmcg
c3VzcGVuZCAqLw0KIH07DQogDQogTU9EVUxFX0FVVEhPUiAoIkplZmYgR2Fy
emlrIDxqZ2FyemlrQHBvYm94LmNvbT4iKTsNCkBAIC00ODgsMTIgKzQ4OSwx
MCBAQCBNT0RVTEVfREVTQ1JJUFRJT04gKCJTa2VsZXRvbiBmb3IgYSBQQ0kg
DQogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KIE1PRFVMRV9QQVJNIChtdWx0
aWNhc3RfZmlsdGVyX2xpbWl0LCAiaSIpOw0KIE1PRFVMRV9QQVJNIChtYXhf
aW50ZXJydXB0X3dvcmssICJpIik7DQotTU9EVUxFX1BBUk0gKGRlYnVnLCAi
aSIpOw0KIE1PRFVMRV9QQVJNIChtZWRpYSwgIjEtIiBfX01PRFVMRV9TVFJJ
TkcoOCkgImkiKTsNCiBNT0RVTEVfUEFSTV9ERVNDIChtdWx0aWNhc3RfZmls
dGVyX2xpbWl0LCAicGNpLXNrZWxldG9uIG1heGltdW0gbnVtYmVyIG9mIGZp
bHRlcmVkIG11bHRpY2FzdCBhZGRyZXNzZXMiKTsNCiBNT0RVTEVfUEFSTV9E
RVNDIChtYXhfaW50ZXJydXB0X3dvcmssICJwY2ktc2tlbGV0b24gbWF4aW11
bSBldmVudHMgaGFuZGxlZCBwZXIgaW50ZXJydXB0Iik7DQogTU9EVUxFX1BB
Uk1fREVTQyAobWVkaWEsICJwY2ktc2tlbGV0b246IEJpdHMgMC0zOiBtZWRp
YSB0eXBlLCBiaXQgMTc6IGZ1bGwgZHVwbGV4Iik7DQotTU9EVUxFX1BBUk1f
REVTQyAoZGVidWcsICIodW51c2VkKSIpOw0KIA0KIHN0YXRpYyBpbnQgcmVh
ZF9lZXByb20gKHZvaWQgKmlvYWRkciwgaW50IGxvY2F0aW9uLCBpbnQgYWRk
cl9sZW4pOw0KIHN0YXRpYyBpbnQgbmV0ZHJ2X29wZW4gKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpOw0KQEAgLTU4OCw3ICs1ODcsNiBAQCBzdGF0aWMgaW50
IF9fZGV2aW5pdCBuZXRkcnZfaW5pdF9ib2FyZCAoDQogCXZvaWQgKmlvYWRk
ciA9IE5VTEw7DQogCXN0cnVjdCBuZXRfZGV2aWNlICpkZXY7DQogCXN0cnVj
dCBuZXRkcnZfcHJpdmF0ZSAqdHA7DQotCXU4IHRtcDg7DQogCWludCByYywg
aTsNCiAJdTMyIHBpb19zdGFydCwgcGlvX2VuZCwgcGlvX2ZsYWdzLCBwaW9f
bGVuOw0KIAl1bnNpZ25lZCBsb25nIG1taW9fc3RhcnQsIG1taW9fZW5kLCBt
bWlvX2ZsYWdzLCBtbWlvX2xlbjsNCkBAIC03NDQsNyArNzQyLDYgQEAgc3Rh
dGljIGludCBfX2RldmluaXQgbmV0ZHJ2X2luaXRfb25lIChzdA0KIAlpbnQg
aSwgYWRkcl9sZW4sIG9wdGlvbjsNCiAJdm9pZCAqaW9hZGRyID0gTlVMTDsN
CiAJc3RhdGljIGludCBib2FyZF9pZHggPSAtMTsNCi0JdTggdG1wOw0KIA0K
IC8qIHdoZW4gYnVpbHQgaW50byB0aGUga2VybmVsLCB3ZSBvbmx5IHByaW50
IHZlcnNpb24gaWYgZGV2aWNlIGlzIGZvdW5kICovDQogI2lmbmRlZiBNT0RV
TEUNCkBAIC04NjgsNyArODY1LDcgQEAgc3RhdGljIHZvaWQgX19kZXZleGl0
IG5ldGRydl9yZW1vdmVfb25lIA0KIA0KIAlwY2lfc2V0X2RydmRhdGEgKHBk
ZXYsIE5VTEwpOw0KIA0KLQlwY2lfcG93ZXJfb2ZmIChwZGV2LCAtMSk7DQor
CXBjaV9kaXNhYmxlX2RldmljZSAocGRldik7DQogDQogCURQUklOVEsgKCJF
WElUXG4iKTsNCiB9DQpAQCAtMTEzNiw3ICsxMTMzLDYgQEAgc3RhdGljIHZv
aWQgbmV0ZHJ2X2h3X3N0YXJ0IChzdHJ1Y3QgbmV0Xw0KIAlzdHJ1Y3QgbmV0
ZHJ2X3ByaXZhdGUgKnRwID0gZGV2LT5wcml2Ow0KIAl2b2lkICppb2FkZHIg
PSB0cC0+bW1pb19hZGRyOw0KIAl1MzIgaTsNCi0JdTggdG1wOw0KIA0KIAlE
UFJJTlRLICgiRU5URVJcbiIpOw0KIA0KQEAgLTE4NzUsOSArMTg3MSwxMSBA
QCBzdGF0aWMgdm9pZCBuZXRkcnZfc2V0X3J4X21vZGUgKHN0cnVjdCBuDQog
CQlyeF9tb2RlID0gQWNjZXB0QnJvYWRjYXN0IHwgQWNjZXB0TXVsdGljYXN0
IHwgQWNjZXB0TXlQaHlzOw0KIAkJbWNfZmlsdGVyWzFdID0gbWNfZmlsdGVy
WzBdID0gMDsNCiAJCWZvciAoaSA9IDAsIG1jbGlzdCA9IGRldi0+bWNfbGlz
dDsgbWNsaXN0ICYmIGkgPCBkZXYtPm1jX2NvdW50Ow0KLQkJICAgICBpKyss
IG1jbGlzdCA9IG1jbGlzdC0+bmV4dCkNCi0JCQlzZXRfYml0IChldGhlcl9j
cmMgKEVUSF9BTEVOLCBtY2xpc3QtPmRtaV9hZGRyKSA+PiAyNiwNCi0JCQkJ
IG1jX2ZpbHRlcik7DQorCQkgICAgIGkrKywgbWNsaXN0ID0gbWNsaXN0LT5u
ZXh0KSB7DQorCQkJaW50IGJpdF9uciA9IGV0aGVyX2NyYyhFVEhfQUxFTiwg
bWNsaXN0LT5kbWlfYWRkcikgPj4gMjY7DQorDQorCQkJbWNfZmlsdGVyW2Jp
dF9uciA+PiA1XSB8PSAxIDw8IChiaXRfbnIgJiAzMSk7DQorCQl9DQogCX0N
CiANCiAJLyogaWYgY2FsbGVkIGZyb20gaXJxIGhhbmRsZXIsIGxvY2sgYWxy
ZWFkeSBhY3F1aXJlZCAqLw0KQEAgLTE5MDgsNyArMTkwNiw3IEBAIHN0YXRp
YyBpbnQgbmV0ZHJ2X3N1c3BlbmQgKHN0cnVjdCBwY2lfZGUNCiAJdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCiANCiAJaWYgKCFuZXRpZl9ydW5uaW5nKGRldikp
DQotCQlyZXR1cm47DQorCQlyZXR1cm4gMDsNCiAJbmV0aWZfZGV2aWNlX2Rl
dGFjaCAoZGV2KTsNCiANCiAJc3Bpbl9sb2NrX2lycXNhdmUgKCZ0cC0+bG9j
aywgZmxhZ3MpOw0KQEAgLTE5MjMsNyArMTkyMSw4IEBAIHN0YXRpYyBpbnQg
bmV0ZHJ2X3N1c3BlbmQgKHN0cnVjdCBwY2lfZGUNCiANCiAJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSAoJnRwLT5sb2NrLCBmbGFncyk7DQogDQotCXBjaV9w
b3dlcl9vZmYgKHBkZXYsIC0xKTsNCisJcGNpX3NhdmVfc3RhdGUgKHBkZXYs
IHRwLT5wY2lfc3RhdGUpOw0KKwlwY2lfc2V0X3Bvd2VyX3N0YXRlIChwZGV2
LCAzKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTE5MzIsMTAgKzE5MzEs
MTIgQEAgc3RhdGljIGludCBuZXRkcnZfc3VzcGVuZCAoc3RydWN0IHBjaV9k
ZQ0KIHN0YXRpYyBpbnQgbmV0ZHJ2X3Jlc3VtZSAoc3RydWN0IHBjaV9kZXYg
KnBkZXYpDQogew0KIAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gcGNpX2dl
dF9kcnZkYXRhIChwZGV2KTsNCisJc3RydWN0IG5ldGRydl9wcml2YXRlICp0
cCA9IGRldi0+cHJpdjsNCiANCiAJaWYgKCFuZXRpZl9ydW5uaW5nKGRldikp
DQotCQlyZXR1cm47DQotCXBjaV9wb3dlcl9vbiAocGRldik7DQorCQlyZXR1
cm4gMDsNCisJcGNpX3NldF9wb3dlcl9zdGF0ZSAocGRldiwgMCk7DQorCXBj
aV9yZXN0b3JlX3N0YXRlIChwZGV2LCB0cC0+cGNpX3N0YXRlKTsNCiAJbmV0
aWZfZGV2aWNlX2F0dGFjaCAoZGV2KTsNCiAJbmV0ZHJ2X2h3X3N0YXJ0IChk
ZXYpOw0KIA0K

--8323328-1638575288-1089399233=:6699--
