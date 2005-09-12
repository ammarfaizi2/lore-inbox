Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVILUNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVILUNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVILUNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:13:06 -0400
Received: from bay105-f35.bay105.hotmail.com ([65.54.224.45]:17562 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932195AbVILUNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:13:05 -0400
Message-ID: <BAY105-F354F5F8CE33D7C76ED8CE7C09D0@phx.gbl>
X-Originating-IP: [84.191.235.136]
X-Originating-Email: [wegner3000@hotmail.com]
From: "Marcus Wegner" <wegner3000@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: Crash in Yenta initialization
Date: Mon, 12 Sep 2005 22:13:04 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_78c4_6a7e_2b5f"
X-OriginalArrivalTime: 12 Sep 2005 20:13:05.0100 (UTC) FILETIME=[625BE0C0:01C5B7D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_78c4_6a7e_2b5f
Content-Type: text/plain; charset=iso-8859-1; format=flowed

>  On Sat, Sep 03, Ivan Kokshaysky wrote:
>
>>On Sat, Sep 03, 2005 at 02:45:08AM +0200, Andreas Koch wrote:
>> > crucial part seem to be the different bridge initialization sections:
>>
>>Indeed.
>>
>> > 2.6.12-rc6 + Ivan's patches:
>>...
>> >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
>> >             IO window: 00006000-00006fff
>> >             IO window: 00007000-00007fff
>> >             PREFETCH window: 82000000-83ffffff
>> >             MEM window: 8c000000-8dffffff
>> >           PCI: Bus 11, cardbus bridge: 0000:06:09.1
>> >             IO window: 00008000-00008fff
>> >             IO window: 00009000-00009fff
>> >             PREFETCH window: 84000000-85ffffff
>> >             MEM window: 8e000000-8fffffff
>> >           PCI: Bus 15, cardbus bridge: 0000:06:09.3
>>...
>> > ... Versus the much shorter output from 2.6.13
>>...
>> >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
>> >             IO window: 00004000-000040ff
>> >             IO window: 00004400-000044ff
>> >             PREFETCH window: 82000000-83ffffff
>> >             MEM window: 88000000-89ffffff
>> >           PCI: Bridge: 0000:00:1e.0
>>
>>It's mysterious.
>>So 2.6.13 doesn't see cardbus bridge functions 06:09.1 and 06:09.3,
>>which means that these devices are not on the per-bus device list.
>>OTOH, they are still visible on the global device list, since yenta
>>driver found them. No surprise that it crashes with some uninitialized
>>pointer.
>
>Did you find the reason for this already?
>We have a similar report:
>https://bugzilla.novell.com/show_bug.cgi?id=113778
>...
>It dies in yenta_config_init because dev->subordinate is NULL.
>...
I had the same problem with an ACER 8101 WLMI. I reverted the initialization
partly and it works now, but I don't know if it really fixes the bug.
Something seems to wrong in the pci initcode.

But other hardware errors with the acer notebook still remain. The detection
of the ioapic results in a deadlock in the boot process (the
multiple-ioapic-fix or "noapic" solved this).

yenta related:
- pccard hardware is working now
- O2 Micro 4-1 cardreader is not working

Does someone have ideas, configs or patches for the cardreader? Do you need 
more info? Let me know.

Marcus


------=_NextPart_000_78c4_6a7e_2b5f
Content-Type: application/octet-stream; name="pci-assign-res-fix"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pci-assign-res-fix"

Q3Jhc2ggaW4gWWVudGEgaW5pdGlhbGl6YXRpb24Kc2VlIGh0dHA6Ly9tYXJj
LnRoZWFpbXNncm91cC5jb20vP2w9bGludXgta2VybmVsJm09MTEyNTcwNDQx
NDI4NzAzJnc9MgoKVGhpcyBmaXhlcyB0aGUgcGNpIGluaXRpYWxpemF0aW9u
IChyZXZlcnQgYmFjayB0byBwcmV2aW91cyBzdGF0ZSkuCgpNYXJjdXMgV2Vn
bmVyIDx3ZWduZXIzMDAwQGhvdG1haWwuY29tPgoKCmRpZmYgLXVyTiBsaW51
eC0yLjYuMTMtOC9kcml2ZXJzL3BjaS9wcm9iZS5jIGxpbnV4LTIuNi4xMy04
LW1hcmN1cy9kcml2ZXJzL3BjaS9wcm9iZS5jCi0tLSBsaW51eC0yLjYuMTMt
OC9kcml2ZXJzL3BjaS9wcm9iZS5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAw
MDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTMtOC1tYXJjdXMvZHJpdmVy
cy9wY2kvcHJvYmUuYwkyMDA1LTA5LTExIDAwOjQ2OjA1LjAwMDAwMDAwMCAr
MDIwMApAQCAtNTIzLDExICs1MjMsOCBAQAogCQkJICogYXMgY2FyZHMgd2l0
aCBhIFBDSS10by1QQ0kgYnJpZGdlIGNhbiBiZQogCQkJICogaW5zZXJ0ZWQg
bGF0ZXIuCiAJCQkgKi8KLQkJCWZvciAoaT0wOyBpPENBUkRCVVNfUkVTRVJW
RV9CVVNOUjsgaSsrKQotCQkJCWlmIChwY2lfZmluZF9idXMocGNpX2RvbWFp
bl9ucihidXMpLAotCQkJCQkJCW1heCtpKzEpKQotCQkJCQlicmVhazsKLQkJ
CW1heCArPSBpOworCQkJbWF4ICs9IENBUkRCVVNfUkVTRVJWRV9CVVNOUjsK
KwogCQkJcGNpX2ZpeHVwX3BhcmVudF9zdWJvcmRpbmF0ZV9idXNucihjaGls
ZCwgbWF4KTsKIAkJfQogCQkvKgo=


------=_NextPart_000_78c4_6a7e_2b5f
Content-Type: application/octet-stream; name="multiple-ioapic-fix"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="multiple-ioapic-fix"

QUNQSSBNQURUIGNvbnRhaW5zIGluZm8gb24gMiBJTy1BUElDcy4KIGlvX2Fw
aWNfZ2V0X3VuaXF1ZV9pZCBwYW5pY3MgZHVlIHRvIGJlaW5nIHVuYWJsZSB0
byBhc3NpZ24gYW4gaWQgdG8gdGhlCiBzZWNvbmQgb25lICh0aGUgbWVtb3J5
IGxvY2F0aW9uIHJlYWRzIGFzIGFsbCBvbmVzKS4gVGhlIGNoaXBzZXQgc3Bl
YwogKHNwZWNpZmljYWxseTogSUNINi1NKSBpcyBvbmx5IHRhbGtpbmcgYWJv
dXQgb25lIElPLUFQSUMsIHNvIG1vc3QgbGlrZWx5IHRoZQogTUFEVCBpcyBp
biBlcnJvci4KCk1hcmN1cyBXZWduZXIgPHdlZ25lcjMwMDBAaG90bWFpbC5j
b20+CgoKZGlmZiAtdXJOIGxpbnV4LTIuNi4xMy04L2FyY2gvaTM4Ni9rZXJu
ZWwvaW9fYXBpYy5jIGxpbnV4LTIuNi4xMy04LW1hcmN1cy9hcmNoL2kzODYv
a2VybmVsL2lvX2FwaWMuYwotLS0gbGludXgtMi42LjEzLTgvYXJjaC9pMzg2
L2tlcm5lbC9pb19hcGljLmMJMjAwNS0wOS0wNiAxNzo1MzozOC4wMDAwMDAw
MDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xMy04LW1hcmN1cy9hcmNoL2kzODYv
a2VybmVsL2lvX2FwaWMuYwkyMDA1LTA5LTExIDAzOjQ0OjA4LjAwMDAwMDAw
MCArMDIwMApAQCAtMjQ5Myw3ICsyNDkzLDEwIEBACiAKIAkJLyogU2FuaXR5
IGNoZWNrICovCiAJCWlmIChyZWdfMDAuYml0cy5JRCAhPSBhcGljX2lkKQot
CQkJcGFuaWMoIklPQVBJQ1slZF06IFVuYWJsZSBjaGFuZ2UgYXBpY19pZCFc
biIsIGlvYXBpYyk7CisJCXsKKwkJCXByaW50aygiSU9BUElDWyVkXTogVW5h
YmxlIGNoYW5nZSBhcGljX2lkIVxuIiwgaW9hcGljKTsKKwkJCXJldHVybigt
MSk7CisJCX0KIAl9CiAKIAlhcGljX3ByaW50ayhBUElDX1ZFUkJPU0UsIEtF
Uk5fSU5GTwpkaWZmIC11ck4gbGludXgtMi42LjEzLTgvYXJjaC9pMzg2L2tl
cm5lbC9tcHBhcnNlLmMgbGludXgtMi42LjEzLTgtbWFyY3VzL2FyY2gvaTM4
Ni9rZXJuZWwvbXBwYXJzZS5jCi0tLSBsaW51eC0yLjYuMTMtOC9hcmNoL2kz
ODYva2VybmVsL21wcGFyc2UuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAw
MDAwMCArMDIwMAorKysgbGludXgtMi42LjEzLTgtbWFyY3VzL2FyY2gvaTM4
Ni9rZXJuZWwvbXBwYXJzZS5jCTIwMDUtMDktMTEgMDQ6MDE6MTguMDAwMDAw
MDAwICswMjAwCkBAIC04OTMsNiArODkzLDcgQEAKIAl1MzIJCQlnc2lfYmFz
ZSkKIHsKIAlpbnQJCQlpZHggPSAwOworCWludAkJCXRtcGlkID0gMDsKIAog
CWlmIChucl9pb2FwaWNzID49IE1BWF9JT19BUElDUykgewogCQlwcmludGso
S0VSTl9FUlIgIkVSUk9SOiBNYXggIyBvZiBJL08gQVBJQ3MgKCVkKSBleGNl
ZWRlZCAiCkBAIC05MTIsOCArOTEzLDEzIEBACiAJbXBfaW9hcGljc1tpZHhd
Lm1wY19hcGljYWRkciA9IGFkZHJlc3M7CiAKIAlzZXRfZml4bWFwX25vY2Fj
aGUoRklYX0lPX0FQSUNfQkFTRV8wICsgaWR4LCBhZGRyZXNzKTsKLQlpZiAo
KGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0lOVEVM
KSAmJiAoYm9vdF9jcHVfZGF0YS54ODYgPCAxNSkpCi0JCW1wX2lvYXBpY3Nb
aWR4XS5tcGNfYXBpY2lkID0gaW9fYXBpY19nZXRfdW5pcXVlX2lkKGlkeCwg
aWQpOworCWlmICgoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9W
RU5ET1JfSU5URUwpICYmIChib290X2NwdV9kYXRhLng4NiA8IDE1KSkgewor
CQlpZiAoKHRtcGlkID0gaW9fYXBpY19nZXRfdW5pcXVlX2lkKGlkeCwgaWQp
KSA9PSAtMSkgeworCQkJbnJfaW9hcGljcy0tOworCQkJcmV0dXJuOworCQl9
CisJCW1wX2lvYXBpY3NbaWR4XS5tcGNfYXBpY2lkID0gdG1waWQ7CisJfQog
CWVsc2UKIAkJbXBfaW9hcGljc1tpZHhdLm1wY19hcGljaWQgPSBpZDsKIAlt
cF9pb2FwaWNzW2lkeF0ubXBjX2FwaWN2ZXIgPSBpb19hcGljX2dldF92ZXJz
aW9uKGlkeCk7Cg==


------=_NextPart_000_78c4_6a7e_2b5f--
