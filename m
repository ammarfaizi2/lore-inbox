Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLEQuy>; Tue, 5 Dec 2000 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbQLEQup>; Tue, 5 Dec 2000 11:50:45 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:34556 "EHLO
	univ.uniyar.ac.ru") by vger.kernel.org with ESMTP
	id <S129429AbQLEQub>; Tue, 5 Dec 2000 11:50:31 -0500
Date: Tue, 5 Dec 2000 19:19:37 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: linux-kernel@vger.kernel.org, Alan.Cox@linux.org, urban@svenskatest.se,
        samba@samba.org, chaffee@cs.berkeley.edu
Subject: [PATCH] Bug in date converting functions DOS<=>UNIX in FAT, NCPFS and SMBFS drivers [second attempt]
Message-ID: <Pine.GSO.3.96.SK.1001205191049.27946A-200000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-976033177=:27946"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-976033177=:27946
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

Few weeks ago I have sent the following letter:

On Fri, 24 Nov 2000, Igor Yu. Zhbanov wrote:

> Hello!
> 
> I have found a bug in drivers of file systems which use a DOS-like format
> of date (16 bit: years since 1980 - 7 bits, month - 4 bits, day - 5 bits).
> 
> There are two problems:
> 1) It is unable to convert UNIX-like dates before 1980 to DOS-like date format.
> 2) VFAT for example have three kinds of dates: creation date, modification date
>    and access date. Sometimes one of these dates is set to zero (which indicates
>    that this date is not set). Zero is not a valid date (e.g. months are
>    numbered from one, not from zero) and can't be properly converted to
>    UNIX-like format of date (it was converted to date before 1980).
> 
> I have found FAT, NCPFS and SMBFS drivers subject to this problems. Patch for
> fixing these bugs attached.
> 
> Also I have a question about VFAT file system. VFAT have not access time fields
> in directory entries but it has access date fields. Currently information about
> the time of last access is not supported for VFAT file system in LINUX. Is this
> correct? Maybe access time should be truncated to days.
> 
> Thank you.
> 
> P.S. Since I'm not currently subscribed to Linux Kernel Mailing List please CC:
> all replies to bsg@uniyar.ac.ru if any.
> 

As I see now in 2.2.18pre24 NCPFS is fixed but VFAT and SMBFS doesn't. (This
happened because the maintainer of NCPFS resent my patch to Alan Cox but only the
part of patch related to NCPFS). So I resent you patch for VFAT and SMBFS attached
to this letter.

Thank you.

---559023410-851401618-976033177=:27946
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.2.17-dosdate.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.3.96.SK.1001205191937.27946B@univ.uniyar.ac.ru>
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
Lzg2NDAwLTM2NTI7DQpkaWZmIC11ciBsaW51eC0yLjIuMTcvZnMvc21iZnMv
Q2hhbmdlTG9nIGxpbnV4L2ZzL3NtYmZzL0NoYW5nZUxvZw0KLS0tIGxpbnV4
LTIuMi4xNy9mcy9zbWJmcy9DaGFuZ2VMb2cJTW9uIFNlcCAgNCAyMTozOToy
NyAyMDAwDQorKysgbGludXgvZnMvc21iZnMvQ2hhbmdlTG9nCVdlZCBOb3Yg
MjIgMTQ6MTA6NDAgMjAwMA0KQEAgLTEsNSArMSwxMCBAQA0KIENoYW5nZUxv
ZyBmb3Igc21iZnMuDQogDQorMjAwMC0xMS0yMiBJZ29yIFpoYmFub3YgPGJz
Z0B1bml5YXIuYWMucnU+DQorDQorCSogcHJvYy5jOiBmaXhlZCBkYXRlX3Vu
aXgyZG9zIGZvciBkYXRlcyBlYXJsaWVyIHRoYW4gMDEvMDEvMTk4MA0KKwkg
IGFuZCBkYXRlX2RvczJ1bml4IGZvciBkYXRlPT0wDQorDQogMjAwMC0wNy0y
MCBVcmJhbiBXaWRtYXJrIDx1cmJhbkBzdmVuc2thdGVzdC5zZT4NCiANCiAJ
KiBwcm9jLmM6IGZpeCAyIHBsYWNlcyB3aGVyZSBiYWQgc2VydmVyIHJlc3Bv
bnNlcyBjb3VsZCBjYXVzZSBhbiBPb3BzLg0KZGlmZiAtdXIgbGludXgtMi4y
LjE3L2ZzL3NtYmZzL3Byb2MuYyBsaW51eC9mcy9zbWJmcy9wcm9jLmMNCi0t
LSBsaW51eC0yLjIuMTcvZnMvc21iZnMvcHJvYy5jCU1vbiBTZXAgIDQgMjE6
Mzk6MjcgMjAwMA0KKysrIGxpbnV4L2ZzL3NtYmZzL3Byb2MuYwlXZWQgTm92
IDIyIDE0OjEzOjMyIDIwMDANCkBAIC0xNjksNyArMTY5LDkgQEANCiAJaW50
IG1vbnRoLCB5ZWFyOw0KIAl0aW1lX3Qgc2VjczsNCiANCi0JbW9udGggPSAo
KGRhdGUgPj4gNSkgJiAxNSkgLSAxOw0KKwkvKiBmaXJzdCBzdWJ0cmFjdCBh
bmQgbWFzayBhZnRlciB0aGF0Li4uIE90aGVyd2lzZSwgaWYNCisJICAgZGF0
ZSA9PSAwLCBiYWQgdGhpbmdzIGhhcHBlbiAqLw0KKwltb250aCA9ICgoZGF0
ZSA+PiA1KSAtIDEpICYgMTU7DQogCXllYXIgPSBkYXRlID4+IDk7DQogCXNl
Y3MgPSAodGltZSAmIDMxKSAqIDIgKyA2MCAqICgodGltZSA+PiA1KSAmIDYz
KSArICh0aW1lID4+IDExKSAqIDM2MDAgKyA4NjQwMCAqDQogCSAgICAoKGRh
dGUgJiAzMSkgLSAxICsgZGF5X25bbW9udGhdICsgKHllYXIgLyA0KSArIHll
YXIgKiAzNjUgLSAoKHllYXIgJiAzKSA9PSAwICYmDQpAQCAtMTg4LDYgKzE5
MCw4IEBADQogCWludCBkYXksIHllYXIsIG5sX2RheSwgbW9udGg7DQogDQog
CXVuaXhfZGF0ZSA9IHV0YzJsb2NhbChzZXJ2ZXIsIHVuaXhfZGF0ZSk7DQor
CWlmICh1bml4X2RhdGUgPCAzMTU1MzI4MDApDQorCQl1bml4X2RhdGUgPSAz
MTU1MzI4MDA7IC8qIEphbiAxIEdNVCAwMDowMDowMCAxOTgwLiBCdXQgd2hh
dCBhYm91dCBhbm90aGVyIHRpbWUgem9uZT8gKi8NCiAJKnRpbWUgPSAodW5p
eF9kYXRlICUgNjApIC8gMiArDQogCQkoKCh1bml4X2RhdGUgLyA2MCkgJSA2
MCkgPDwgNSkgKw0KIAkJKCgodW5peF9kYXRlIC8gMzYwMCkgJSAyNCkgPDwg
MTEpOw0K
---559023410-851401618-976033177=:27946--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
