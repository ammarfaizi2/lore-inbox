Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130869AbQKXOT3>; Fri, 24 Nov 2000 09:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131090AbQKXOTX>; Fri, 24 Nov 2000 09:19:23 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:35493 "EHLO
        univ.uniyar.ac.ru") by vger.kernel.org with ESMTP
        id <S131148AbQKXOAh>; Fri, 24 Nov 2000 09:00:37 -0500
Date: Fri, 24 Nov 2000 16:30:05 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, vl@kki.org,
        linware@sh.cvut.cz, urban@svenskatest.se, samba@samba.org,
        chaffee@cs.berkeley.edu
Subject: Bug in date converting functions DOS<=>UNIX in FAT, NCPFS and SMBFS drivers
Message-ID: <Pine.GSO.3.96.SK.1001124162224.25896A-200000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-975072605=:25896"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-975072605=:25896
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

I have found a bug in drivers of file systems which use a DOS-like format
of date (16 bit: years since 1980 - 7 bits, month - 4 bits, day - 5 bits).

There are two problems:
1) It is unable to convert UNIX-like dates before 1980 to DOS-like date format.
2) VFAT for example have three kinds of dates: creation date, modification date
   and access date. Sometimes one of these dates is set to zero (which indicates
   that this date is not set). Zero is not a valid date (e.g. months are
   numbered from one, not from zero) and can't be properly converted to
   UNIX-like format of date (it was converted to date before 1980).

I have found FAT, NCPFS and SMBFS drivers subject to this problems. Patch for
fixing these bugs attached.

Also I have a question about VFAT file system. VFAT have not access time fields
in directory entries but it has access date fields. Currently information about
the time of last access is not supported for VFAT file system in LINUX. Is this
correct? Maybe access time should be truncated to days.

Thank you.

P.S. Since I'm not currently subscribed to Linux Kernel Mailing List please CC:
all replies to bsg@uniyar.ac.ru if any.

---559023410-851401618-975072605=:25896
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.2.17-dosdate.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.3.96.SK.1001124163005.25896B@univ.uniyar.ac.ru>
Content-Description: linux-2.2.17-dosdate.diff

ZGlmZiAtdXIgbGludXgtMi4yLjE3L2ZzL2ZhdC9taXNjLmMgbGludXgvZnMv
ZmF0L21pc2MuYw0KLS0tIGxpbnV4LTIuMi4xNy9mcy9mYXQvbWlzYy5jCVRo
dSBNYXkgIDQgMDQ6MTY6NDYgMjAwMA0KKysrIGxpbnV4L2ZzL2ZhdC9taXNj
LmMJV2VkIE5vdiAyMiAxNDowNTowOCAyMDAwDQpAQCAtMiw2ICsyLDggQEAN
CiAgKiAgbGludXgvZnMvZmF0L21pc2MuYw0KICAqDQogICogIFdyaXR0ZW4g
MTk5MiwxOTkzIGJ5IFdlcm5lciBBbG1lc2Jlcmdlcg0KKyAqICAyMi8xMS8y
MDAwIC0gRml4ZWQgZmF0X2RhdGVfdW5peDJkb3MgZm9yIGRhdGVzIGVhcmxp
ZXIgdGhhbiAwMS8wMS8xOTgwDQorICoJCSBhbmQgZGF0ZV9kb3MydW5peCBm
b3IgZGF0ZT09MCBieSBJZ29yIFpoYmFub3YoYnNnQHVuaXlhci5hYy5ydSkN
CiAgKi8NCiANCiAjaW5jbHVkZSA8bGludXgvZnMuaD4NCkBAIC0yODgsNyAr
MjkwLDkgQEANCiB7DQogCWludCBtb250aCx5ZWFyLHNlY3M7DQogDQotCW1v
bnRoID0gKChkYXRlID4+IDUpICYgMTUpLTE7DQorCS8qIGZpcnN0IHN1YnRy
YWN0IGFuZCBtYXNrIGFmdGVyIHRoYXQuLi4gT3RoZXJ3aXNlLCBpZg0KKwkg
ICBkYXRlID09IDAsIGJhZCB0aGluZ3MgaGFwcGVuICovDQorCW1vbnRoID0g
KChkYXRlID4+IDUpIC0gMSkgJiAxNTsNCiAJeWVhciA9IGRhdGUgPj4gOTsN
CiAJc2VjcyA9ICh0aW1lICYgMzEpKjIrNjAqKCh0aW1lID4+IDUpICYgNjMp
Kyh0aW1lID4+IDExKSozNjAwKzg2NDAwKg0KIAkgICAgKChkYXRlICYgMzEp
LTErZGF5X25bbW9udGhdKyh5ZWFyLzQpK3llYXIqMzY1LSgoeWVhciAmIDMp
ID09IDAgJiYNCkBAIC0zMTAsNiArMzE0LDggQEANCiAJdW5peF9kYXRlIC09
IHN5c190ei50el9taW51dGVzd2VzdCo2MDsNCiAJaWYgKHN5c190ei50el9k
c3R0aW1lKSB1bml4X2RhdGUgKz0gMzYwMDsNCiANCisJaWYgKHVuaXhfZGF0
ZSA8IDMxNTUzMjgwMCkNCisJCXVuaXhfZGF0ZSA9IDMxNTUzMjgwMDsgLyog
SmFuIDEgR01UIDAwOjAwOjAwIDE5ODAuIEJ1dCB3aGF0IGFib3V0IGFub3Ro
ZXIgdGltZSB6b25lPyAqLw0KIAkqdGltZSA9ICh1bml4X2RhdGUgJSA2MCkv
MisoKCh1bml4X2RhdGUvNjApICUgNjApIDw8IDUpKw0KIAkgICAgKCgodW5p
eF9kYXRlLzM2MDApICUgMjQpIDw8IDExKTsNCiAJZGF5ID0gdW5peF9kYXRl
Lzg2NDAwLTM2NTI7DQpkaWZmIC11ciBsaW51eC0yLjIuMTcvZnMvbmNwZnMv
ZGlyLmMgbGludXgvZnMvbmNwZnMvZGlyLmMNCi0tLSBsaW51eC0yLjIuMTcv
ZnMvbmNwZnMvZGlyLmMJVGh1IEp1biAgOCAwMToyNjo0MyAyMDAwDQorKysg
bGludXgvZnMvbmNwZnMvZGlyLmMJV2VkIE5vdiAyMiAxNDowNjowOSAyMDAw
DQpAQCAtNSw2ICs1LDggQEANCiAgKiAgTW9kaWZpZWQgZm9yIGJpZyBlbmRp
YW4gYnkgSi5GLiBDaGFkaW1hIGFuZCBEYXZpZCBTLiBNaWxsZXINCiAgKiAg
TW9kaWZpZWQgMTk5NyBQZXRlciBXYWx0ZW5iZXJnLCBCaWxsIEhhd2VzLCBE
YXZpZCBXb29kaG91c2UgZm9yIDIuMSBkY2FjaGUNCiAgKiAgTW9kaWZpZWQg
MTk5OCBXb2xmcmFtIFBpZW5rb3NzIGZvciBOTFMNCisgKiAgMjIvMTEvMjAw
MCAtIEZpeGVkIG5jcF9kYXRlX3VuaXgyZG9zIGZvciBkYXRlcyBlYXJsaWVy
IHRoYW4gMDEvMDEvMTk4MA0KKyAqCQkgYnkgSWdvciBaaGJhbm92KGJzZ0B1
bml5YXIuYWMucnUpDQogICoNCiAgKi8NCiANCkBAIC0xMTU4LDYgKzExNjAs
OCBAQA0KIAlpbnQgZGF5LCB5ZWFyLCBubF9kYXksIG1vbnRoOw0KIA0KIAl1
bml4X2RhdGUgPSB1dGMybG9jYWwodW5peF9kYXRlKTsNCisJaWYgKHVuaXhf
ZGF0ZSA8IDMxNTUzMjgwMCkNCisJCXVuaXhfZGF0ZSA9IDMxNTUzMjgwMDsg
LyogSmFuIDEgR01UIDAwOjAwOjAwIDE5ODAuIEJ1dCB3aGF0IGFib3V0IGFu
b3RoZXIgdGltZSB6b25lPyAqLw0KIAkqdGltZSA9ICh1bml4X2RhdGUgJSA2
MCkgLyAyICsgKCgodW5peF9kYXRlIC8gNjApICUgNjApIDw8IDUpICsNCiAJ
ICAgICgoKHVuaXhfZGF0ZSAvIDM2MDApICUgMjQpIDw8IDExKTsNCiAJZGF5
ID0gdW5peF9kYXRlIC8gODY0MDAgLSAzNjUyOw0KZGlmZiAtdXIgbGludXgt
Mi4yLjE3L2ZzL3NtYmZzL0NoYW5nZUxvZyBsaW51eC9mcy9zbWJmcy9DaGFu
Z2VMb2cNCi0tLSBsaW51eC0yLjIuMTcvZnMvc21iZnMvQ2hhbmdlTG9nCU1v
biBTZXAgIDQgMjE6Mzk6MjcgMjAwMA0KKysrIGxpbnV4L2ZzL3NtYmZzL0No
YW5nZUxvZwlXZWQgTm92IDIyIDE0OjEwOjQwIDIwMDANCkBAIC0xLDUgKzEs
MTAgQEANCiBDaGFuZ2VMb2cgZm9yIHNtYmZzLg0KIA0KKzIwMDAtMTEtMjIg
SWdvciBaaGJhbm92IDxic2dAdW5peWFyLmFjLnJ1Pg0KKw0KKwkqIHByb2Mu
YzogZml4ZWQgZGF0ZV91bml4MmRvcyBmb3IgZGF0ZXMgZWFybGllciB0aGFu
IDAxLzAxLzE5ODANCisJICBhbmQgZGF0ZV9kb3MydW5peCBmb3IgZGF0ZT09
MA0KKw0KIDIwMDAtMDctMjAgVXJiYW4gV2lkbWFyayA8dXJiYW5Ac3ZlbnNr
YXRlc3Quc2U+DQogDQogCSogcHJvYy5jOiBmaXggMiBwbGFjZXMgd2hlcmUg
YmFkIHNlcnZlciByZXNwb25zZXMgY291bGQgY2F1c2UgYW4gT29wcy4NCmRp
ZmYgLXVyIGxpbnV4LTIuMi4xNy9mcy9zbWJmcy9wcm9jLmMgbGludXgvZnMv
c21iZnMvcHJvYy5jDQotLS0gbGludXgtMi4yLjE3L2ZzL3NtYmZzL3Byb2Mu
YwlNb24gU2VwICA0IDIxOjM5OjI3IDIwMDANCisrKyBsaW51eC9mcy9zbWJm
cy9wcm9jLmMJV2VkIE5vdiAyMiAxNDoxMzozMiAyMDAwDQpAQCAtMTY5LDcg
KzE2OSw5IEBADQogCWludCBtb250aCwgeWVhcjsNCiAJdGltZV90IHNlY3M7
DQogDQotCW1vbnRoID0gKChkYXRlID4+IDUpICYgMTUpIC0gMTsNCisJLyog
Zmlyc3Qgc3VidHJhY3QgYW5kIG1hc2sgYWZ0ZXIgdGhhdC4uLiBPdGhlcndp
c2UsIGlmDQorCSAgIGRhdGUgPT0gMCwgYmFkIHRoaW5ncyBoYXBwZW4gKi8N
CisJbW9udGggPSAoKGRhdGUgPj4gNSkgLSAxKSAmIDE1Ow0KIAl5ZWFyID0g
ZGF0ZSA+PiA5Ow0KIAlzZWNzID0gKHRpbWUgJiAzMSkgKiAyICsgNjAgKiAo
KHRpbWUgPj4gNSkgJiA2MykgKyAodGltZSA+PiAxMSkgKiAzNjAwICsgODY0
MDAgKg0KIAkgICAgKChkYXRlICYgMzEpIC0gMSArIGRheV9uW21vbnRoXSAr
ICh5ZWFyIC8gNCkgKyB5ZWFyICogMzY1IC0gKCh5ZWFyICYgMykgPT0gMCAm
Jg0KQEAgLTE4OCw2ICsxOTAsOCBAQA0KIAlpbnQgZGF5LCB5ZWFyLCBubF9k
YXksIG1vbnRoOw0KIA0KIAl1bml4X2RhdGUgPSB1dGMybG9jYWwoc2VydmVy
LCB1bml4X2RhdGUpOw0KKwlpZiAodW5peF9kYXRlIDwgMzE1NTMyODAwKQ0K
KwkJdW5peF9kYXRlID0gMzE1NTMyODAwOyAvKiBKYW4gMSBHTVQgMDA6MDA6
MDAgMTk4MC4gQnV0IHdoYXQgYWJvdXQgYW5vdGhlciB0aW1lIHpvbmU/ICov
DQogCSp0aW1lID0gKHVuaXhfZGF0ZSAlIDYwKSAvIDIgKw0KIAkJKCgodW5p
eF9kYXRlIC8gNjApICUgNjApIDw8IDUpICsNCiAJCSgoKHVuaXhfZGF0ZSAv
IDM2MDApICUgMjQpIDw8IDExKTsNCg==
---559023410-851401618-975072605=:25896--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
