Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWGLW3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWGLW3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWGLW3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:29:15 -0400
Received: from lucidpixels.com ([66.45.37.187]:27542 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750869AbWGLW3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:29:14 -0400
Date: Wed, 12 Jul 2006 18:29:13 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: David Greaves <david@dgreaves.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
In-Reply-To: <44B57373.2030907@dgreaves.com>
Message-ID: <Pine.LNX.4.64.0607121828290.11285@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>
  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>
  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan> 
 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan> 
 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan> 
 <1152545639.27368.137.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan> 
 <Pine.LNX.4.64.0607110926150.858@p34.internal.lan>
 <1152634324.18028.21.camel@localhost.localdomain> <44B57373.2030907@dgreaves.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-2040782755-1152743353=:11285"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-2040782755-1152743353=:11285
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Unfortunately not, the correct patch you need is attached to get the 
ata_op code, against 2.6.17.3.

On Wed, 12 Jul 2006, David Greaves wrote:

> Alan Cox wrote:
>> Ar Maw, 2006-07-11 am 09:28 -0400, ysgrifennodd Justin Piszcz:
>>> Alan/Jeff/Mark,
>>>
>>> Is there anything else I can do to further troubleshoot this problem now
>>> that we have the failed opcode(s)?  Again, there is never any corruption
>>> on these drives, so it is more of an annoyance than anything else.
>>
>> Nothing strikes me so far other than the data not making sense. Possibly
>> it will become clearer later if/when we see other examples.
>
> For me it's SMART related.
>
> smartctl -data -o on /dev/sda reliably gets a similar message.
> Justin - does this smartctl command trigger a message for you?
>
> I've been mailing on and off since January-ish.
> (http://marc.theaimsgroup.com/?l=linux-ide&w=2&r=7&s=libpata&q=b)
>
> Back in March I was running 2.6.16 (with a different version of Mark's
> opcode patch) and I sent an email with the following info:
>
> dmesg:
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
>
> Does that help with the diagnosis?
>
> Also see my emails: SMART on SATA reporting errors?
>  http://marc.theaimsgroup.com/?l=linux-ide&m=113933732903205&w=2
>
> I did reply but got no response so I assumed I was just so far off base
> that I was being ignored  :)
>
> David
>
---1463747160-2040782755-1152743353=:11285
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=libata-ata_op.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0607121829130.11285@p34.internal.lan>
Content-Description: 
Content-Disposition: attachment; filename=libata-ata_op.patch

ZGlmZiAtdXByTiBsaW51eC0yLjYuMTcuMy9kcml2ZXJzL3Njc2kvbGliYXRh
LXNjc2kuYyBsaW51eC0yLjYuMTcuMy1kaWZmL2RyaXZlcnMvc2NzaS9saWJh
dGEtc2NzaS5jDQotLS0gbGludXgtMi42LjE3LjMvZHJpdmVycy9zY3NpL2xp
YmF0YS1zY3NpLmMJMjAwNi0wNi0zMCAxMzozNzozOC4wMDAwMDAwMDAgLTA0
MDANCisrKyBsaW51eC0yLjYuMTcuMy1kaWZmL2RyaXZlcnMvc2NzaS9saWJh
dGEtc2NzaS5jCTIwMDYtMDctMDkgMTY6MzE6NDUuNjY1MTEyMDAwIC0wNDAw
DQpAQCAtNDI4LDEwICs0MjgsMTYgQEAgaW50IGF0YV9zY3NpX2RldmljZV9z
dXNwZW5kKHN0cnVjdCBzY3NpXw0KICAqCXNwaW5fbG9ja19pcnFzYXZlKGhv
c3Rfc2V0IGxvY2spDQogICovDQogdm9pZCBhdGFfdG9fc2Vuc2VfZXJyb3Io
dW5zaWduZWQgaWQsIHU4IGRydl9zdGF0LCB1OCBkcnZfZXJyLCB1OCAqc2ss
IHU4ICphc2MsDQotCQkJdTggKmFzY3EpDQorCQkJdTggKmFzY3EsIHN0cnVj
dCBhdGFfcXVldWVkX2NtZCAqcWMpDQogew0KIAlpbnQgaTsNCiANCisJc3Ry
dWN0IHNjc2lfY21uZCAqY21kID0gcWMtPnNjc2ljbWQ7DQorCXN0cnVjdCBh
dGFfdGFza2ZpbGUgKnRmID0gJnFjLT50ZjsNCisJdW5zaWduZWQgY2hhciAq
c2IgPSBjbWQtPnNlbnNlX2J1ZmZlcjsNCisJdW5zaWduZWQgY2hhciAqZGVz
YyA9IHNiICsgODsNCisJdW5zaWduZWQgY2hhciBhdGFfb3AgPSB0Zi0+Y29t
bWFuZDsNCisJDQogCS8qIEJhc2VkIG9uIHRoZSAzd2FyZSBkcml2ZXIgdHJh
bnNsYXRpb24gdGFibGUgKi8NCiAJc3RhdGljIGNvbnN0IHVuc2lnbmVkIGNo
YXIgc2Vuc2VfdGFibGVbXVs0XSA9IHsNCiAJCS8qIEJCRHxFQ0N8SUR8TUFS
ICovDQpAQCAtNTIwLDYgKzUyNiw3IEBAIHZvaWQgYXRhX3RvX3NlbnNlX2Vy
cm9yKHVuc2lnbmVkIGlkLCB1OCANCiAJcHJpbnRrKEtFUk5fRVJSICJhdGEl
dTogdHJhbnNsYXRlZCBBVEEgc3RhdC9lcnIgMHglMDJ4LyUwMnggdG8gIg0K
IAkgICAgICAgIlNDU0kgU0svQVNDL0FTQ1EgMHgleC8lMDJ4LyUwMnhcbiIs
IGlkLCBkcnZfc3RhdCwgZHJ2X2VyciwNCiAJICAgICAgICpzaywgKmFzYywg
KmFzY3EpOw0KKwlwcmludGsoS0VSTl9FUlIgImF0YV9nZW5fYXRhX2Rlc2Nf
c2Vuc2U6IGZhaWxlZCBhdGFfb3A9MHglMDJ4XG4iLCBhdGFfb3ApOw0KIAly
ZXR1cm47DQogfQ0KIA0KQEAgLTU0Miw2ICs1NDksNyBAQCB2b2lkIGF0YV9n
ZW5fYXRhX2Rlc2Nfc2Vuc2Uoc3RydWN0IGF0YV9xDQogCXN0cnVjdCBhdGFf
dGFza2ZpbGUgKnRmID0gJnFjLT50ZjsNCiAJdW5zaWduZWQgY2hhciAqc2Ig
PSBjbWQtPnNlbnNlX2J1ZmZlcjsNCiAJdW5zaWduZWQgY2hhciAqZGVzYyA9
IHNiICsgODsNCisJdW5zaWduZWQgY2hhciBhdGFfb3AgPSB0Zi0+Y29tbWFu
ZDsNCiANCiAJbWVtc2V0KHNiLCAwLCBTQ1NJX1NFTlNFX0JVRkZFUlNJWkUp
Ow0KIA0KQEAgLTU1OCw4ICs1NjYsOSBAQCB2b2lkIGF0YV9nZW5fYXRhX2Rl
c2Nfc2Vuc2Uoc3RydWN0IGF0YV9xDQogCSAqIG9udG8gc2Vuc2Uga2V5LCBh
c2MgJiBhc2NxLg0KIAkgKi8NCiAJaWYgKHRmLT5jb21tYW5kICYgKEFUQV9C
VVNZIHwgQVRBX0RGIHwgQVRBX0VSUiB8IEFUQV9EUlEpKSB7DQorCQlwcmlu
dGsoS0VSTl9XQVJOSU5HICJhdGFfZ2VuX2F0YV9kZXNjX3NlbnNlOiBmYWls
ZWQgYXRhX29wPTB4JTAyeFxuIiwgYXRhX29wKTsNCiAJCWF0YV90b19zZW5z
ZV9lcnJvcihxYy0+YXAtPmlkLCB0Zi0+Y29tbWFuZCwgdGYtPmZlYXR1cmUs
DQotCQkJCSAgICZzYlsxXSwgJnNiWzJdLCAmc2JbM10pOw0KKwkJCQkgICAm
c2JbMV0sICZzYlsyXSwgJnNiWzNdLHFjKTsNCiAJCXNiWzFdICY9IDB4MGY7
DQogCX0NCiANCkBAIC02MTcsNiArNjI2LDcgQEAgdm9pZCBhdGFfZ2VuX2Zp
eGVkX3NlbnNlKHN0cnVjdCBhdGFfcXVldQ0KIAlzdHJ1Y3Qgc2NzaV9jbW5k
ICpjbWQgPSBxYy0+c2NzaWNtZDsNCiAJc3RydWN0IGF0YV90YXNrZmlsZSAq
dGYgPSAmcWMtPnRmOw0KIAl1bnNpZ25lZCBjaGFyICpzYiA9IGNtZC0+c2Vu
c2VfYnVmZmVyOw0KKwl1bnNpZ25lZCBjaGFyIGF0YV9vcCA9IHRmLT5jb21t
YW5kOw0KIA0KIAltZW1zZXQoc2IsIDAsIFNDU0lfU0VOU0VfQlVGRkVSU0la
RSk7DQogDQpAQCAtNjMzLDggKzY0Myw5IEBAIHZvaWQgYXRhX2dlbl9maXhl
ZF9zZW5zZShzdHJ1Y3QgYXRhX3F1ZXUNCiAJICogb250byBzZW5zZSBrZXks
IGFzYyAmIGFzY3EuDQogCSAqLw0KIAlpZiAodGYtPmNvbW1hbmQgJiAoQVRB
X0JVU1kgfCBBVEFfREYgfCBBVEFfRVJSIHwgQVRBX0RSUSkpIHsNCisJCXBy
aW50ayhLRVJOX1dBUk5JTkcgImF0YV9nZW5fZml4ZWRfc2Vuc2U6IGZhaWxl
ZCBhdGFfb3A9MHglMDJ4XG4iLCBhdGFfb3ApOw0KIAkJYXRhX3RvX3NlbnNl
X2Vycm9yKHFjLT5hcC0+aWQsIHRmLT5jb21tYW5kLCB0Zi0+ZmVhdHVyZSwN
Ci0JCQkJICAgJnNiWzJdLCAmc2JbMTJdLCAmc2JbMTNdKTsNCisJCQkJICAg
JnNiWzJdLCAmc2JbMTJdLCAmc2JbMTNdLHFjKTsNCiAJCXNiWzJdICY9IDB4
MGY7DQogCX0NCiANCg==

---1463747160-2040782755-1152743353=:11285--
