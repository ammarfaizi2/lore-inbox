Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129252AbRBCND0>; Sat, 3 Feb 2001 08:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129362AbRBCNDP>; Sat, 3 Feb 2001 08:03:15 -0500
Received: from fungus.teststation.com ([212.32.186.211]:46517 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129252AbRBCNDF>; Sat, 3 Feb 2001 08:03:05 -0500
Date: Sat, 3 Feb 2001 14:02:53 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <T.Stewart@student.umist.ac.uk>
cc: <linux-kernel@vger.kernel.org>, <chromatix@penguinpowered.com>
Subject: Re: DFE-530TX with no mac address
In-Reply-To: <3A7B599F.18307.47A4F1@localhost>
Message-ID: <Pine.LNX.4.30.0102031246490.13570-200000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463780587-1775766346-981202455=:13570"
Content-ID: <Pine.LNX.4.30.0102031314270.13570@cola.teststation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463780587-1775766346-981202455=:13570
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0102031314271.13570@cola.teststation.com>

On Sat, 3 Feb 2001 T.Stewart@student.umist.ac.uk wrote:

> VIA VT3065 Rhine-II chip registers at 0xd400
>  0x000: 00000000 00000000 00000804 00000000 00000000 
> 00000000 00000000 00000000
>  0x020: 00000400 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
>  0x040: 00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 feffffff
>  0x060: 00000000 00000000 00000000 0e09131f 00008100 
> 08000080 02470000 00000000
>  No interrupt sources are pending (0000).
>   Access to the EEPROM has been disabled (0x80).
>     Direct reading or writing is not possible.
> EEPROM contents (Assumed from chip registers):
> 0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x110:  00 00 00 00 00 00 00 00 09 0e 00 00 47 02 73 73
>  ***WARNING***: No MII transceivers found!

This is intresting. Your card reports that it is stopped while the other
report show normal values on most things. Does this change if you try and
send something (like a ping)?
Common to both reports is that the transceivers don't respond.

The functioning card reports a PHY ID of 0016 f880, wonder which chip that
is ... ?


The attached patch for the via-daig program plays with a few registers.

Run it as 'via-diag -aaeemm -I' then do a 'ifconfig eth0 down; ifconfig 
eth0 up' and see if anything happens.

If this doesn't work you may want to play "guess the register". A fun
game for all ages, made more fun by using obfuscated english. There is a 
datasheet here for a chip similar to the ones you have.
	http://www.via.com.tw/pdf/productinfo/vt86c100a.pdf

/Urban

---1463780587-1775766346-981202455=:13570
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="via-diag-reload.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0102031314150.13570@cola.teststation.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="via-diag-reload.patch"

LS0tIHZpYS1kaWFnLmMub3JpZwlTYXQgRmViICAzIDEwOjE0OjUwIDIwMDEN
CisrKyB2aWEtZGlhZy5jCVNhdCBGZWIgIDMgMTM6MDA6NDcgMjAwMQ0KQEAg
LTE1MCw2ICsxNTAsOCBAQA0KIHN0YXRpYyBpbnQgZ2V0X21lZGlhX2luZGV4
KGNvbnN0IGNoYXIgKm5hbWUpOw0KIC8qIENoaXAtc3BlY2lmaWMgb3B0aW9u
cywgaWYgYW55LCBnbyBoZXJlLiAqLw0KIA0KK3N0YXRpYyBpbnQgdHJ5X3Rv
X3N0YXJ0ID0gMCwgdHJ5X3RvX3N0b3AgPSAwOw0KKw0KIAwNCiBpbnQNCiBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCkBAIC0xNjEsNyArMTYzLDcg
QEANCiAJaW50IGNhcmRfbnVtID0gMDsNCiAJZXh0ZXJuIGNoYXIgKm9wdGFy
ZzsNCiANCi0Jd2hpbGUgKChjID0gZ2V0b3B0X2xvbmcoYXJnYywgYXJndiwg
IiM6YUE6RGVFZkY6RzptcDpxclJzdDp2VndXSDpCTDpTOiIsDQorCXdoaWxl
ICgoYyA9IGdldG9wdF9sb25nKGFyZ2MsIGFyZ3YsICIjOmFBOkRlRWZGOkc6
bXA6cXJSc3Q6dlZ3V0g6Qkw6UzpJaSIsDQogCQkJCQkJCWxvbmdvcHRzLCAm
bG9uZ2luZCkpDQogCQkgICAhPSAtMSkNCiAJCXN3aXRjaCAoYykgew0KQEAg
LTIwNSw2ICsyMDcsOCBAQA0KIAkJY2FzZSAnQic6IG9wdF9mbGFzaF9zaG93
Kys7CWJyZWFrOw0KIAkJY2FzZSAnTCc6IG9wdF9mbGFzaF9sb2FkZmlsZSA9
IG9wdGFyZzsJYnJlYWs7DQogCQljYXNlICdTJzogb3B0X2ZsYXNoX2R1bXBm
aWxlID0gb3B0YXJnOwlicmVhazsNCisJCWNhc2UgJ0knOiB0cnlfdG9fc3Rh
cnQgPSAxOyB0cnlfdG9fc3RvcCA9IDA7IGJyZWFrOw0KKwkJY2FzZSAnaSc6
IHRyeV90b19zdGFydCA9IDA7IHRyeV90b19zdG9wID0gMTsgYnJlYWs7DQog
CQljYXNlICc/JzoNCiAJCQllcnJmbGFnKys7DQogCQl9DQpAQCAtNTU5LDYg
KzU2MywyNSBAQA0KIAkJCSAgICJQZXJoYXBzIGl0IGlzIHNldCB0byBBQ1BJ
IHBvd2VyLW9mZiBtb2RlLlxuIg0KIAkJCSAgICJUbyBleGFtaW5lIHRoaXMg
ZGV2aWNlIGFueXdheSB1c2UgdGhlICctZicgZmxhZy5cbiIpOw0KIAkJcmV0
dXJuIDE7DQorCX0NCisNCisJLyogRXhwZXJpbWVudHMgd2l0aCBnZXR0aW5n
IHRoZSBjYXJkIHRvIHN0b3Agd29ya2luZyAuLi4gKi8NCisJaWYgKHRyeV90
b19zdG9wKSB7DQorCQkvKiBUaGlzIGRvZXNuJ3Qgc3RvcCBteSBjYXJkIDoo
ICovDQorCQlmb3IgKGk9MDsgaTw2OyBpKyspDQorCQkJb3V0YigweDAwLCBp
b2FkZHIgKyBpKTsNCisJCW91dGIoMHgwMSwgaW9hZGRyICsgMHg2Yyk7DQor
DQorCQkvKiB0aGlzIHN0b3BzIHRoaW5ncywgYnV0IGlmY29uZmlnIHVwL2Rv
d24gcmVzZXRzIHByb3Blcmx5ICovDQorCQlvdXRiKDB4ODAsIGlvYWRkciAr
IDB4MDkpOw0KKwl9DQorCS8qIC4uLiBhbmQgdGhlbiBzdGFydGluZyBpdCBh
Z2FpbiAqLw0KKwlpZiAodHJ5X3RvX3N0YXJ0KSB7DQorCQkvKiB3ZSBrbm93
IHRoZSBQSFkgaXMgOCAqLw0KKwkJb3V0YigweDA4LCBpb2FkZHIgKyAweDZj
KTsNCisNCisJCS8qIHRlbGwgdGhlIGNoaXAgdG8gcmVsb2FkIGZyb20gRUVQ
Uk9NICovDQorCQlvdXRiKDB4MjAsIGlvYWRkciArIDB4NzQpOw0KIAl9DQog
DQogCS8qIEFsd2F5cyBzaG93IHRoZSBiYXNpYyBzdGF0dXMuICovDQo=
---1463780587-1775766346-981202455=:13570--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
