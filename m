Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269739AbRHaWsc>; Fri, 31 Aug 2001 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269726AbRHaWsT>; Fri, 31 Aug 2001 18:48:19 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:29171 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S269693AbRHaWrw>; Fri, 31 Aug 2001 18:47:52 -0400
Message-Id: <200108312248.PAA29439@goose.mail.pas.earthlink.net>
From: Eli Carter <eli@pflash.com>
To: Alan Cox <alan@redhat.com>
Subject: [PATCH] make rpm fixes
Date: Fri, 31 Aug 2001 17:51:55 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_JIFYOI556JX1N7VEOEJJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_JIFYOI556JX1N7VEOEJJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Alan (& etc.),

I really like the 'make rpm' target.  However, I noticed a couple of bugs 
with it.
1) 'uname' and rpm -q kernel did not agree on the build number.  (uname was 1 
greater than the rpm build number.)
2) IIRC, the build number incremented by 2 for each 'make rpm'.  (If I'm 
mistaken, please overlook. ;) )
3) The symlink and tarball were left over, which also yielded a 'linux -> .' 
symlink on later builds.
4) Those of us who use CVS would rather not tar up the CVS directories.

So, here is a patch (makerpm-6.patch, attached) to address those issues.  
Also, the order of commands in the Makefile is intended to maximize the 
amount of clean up done if the build is prematurely aborted.  If the 'rpm' 
command is stopped for whatever reason, the .version will still be updated.

It is against 2.4.8-ac7 since that is what I have on hand, but I expect it to 
apply cleanly to the latest -ac.  Let me know if you need it re-diff'ed for 
2.4.9-acx.

Questions, comments, suggestions?
(Please CC me; I'm subscribed at work, but not here at home.)

Eli 
---------------.
Eli Carter      \  (This is my home account; I am subscribed at work.)
eli(a)pflash.com `-------------------------------------------------------



--------------Boundary-00=_JIFYOI556JX1N7VEOEJJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="makerpm-6.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="makerpm-6.patch"

LS0tIGxpbnV4Lm9yaWcvTWFrZWZpbGUJV2VkIEF1ZyAyOSAyMjowNjozMiAyMDAxCisrKyBsaW51
eC9NYWtlZmlsZQlGcmkgQXVnIDMxIDE0OjU5OjUyIDIwMDEKQEAgLTMwOCwxMSArMzA4LDcgQEAK
ICQoVE9QRElSKS9pbmNsdWRlL2xpbnV4L2NvbXBpbGUuaDogaW5jbHVkZS9saW51eC9jb21waWxl
LmgKIAogbmV3dmVyc2lvbjoKLQlAaWYgWyAhIC1mIC52ZXJzaW9uIF07IHRoZW4gXAotCQllY2hv
IDEgPiAudmVyc2lvbjsgXAotCWVsc2UgXAotCQlleHByIDBgY2F0IC52ZXJzaW9uYCArIDEgPiAu
dmVyc2lvbjsgXAotCWZpCisJLiBzY3JpcHRzL21rdmVyc2lvbiA+IC52ZXJzaW9uCiAKIGluY2x1
ZGUvbGludXgvY29tcGlsZS5oOiAkKENPTkZJR1VSQVRJT04pIGluY2x1ZGUvbGludXgvdmVyc2lv
bi5oIG5ld3ZlcnNpb24KIAlAZWNobyAtbiBcI2RlZmluZSBVVFNfVkVSU0lPTiBcIlwjYGNhdCAu
dmVyc2lvbmAgPiAudmVyCkBAIC01MjUsMjAgKzUyMSwyMyBAQAogIwlJZiB5b3UgZG8gYSBtYWtl
IHNwZWMgYmVmb3JlIHBhY2tpbmcgdGhlIHRhcmJhbGwgeW91IGNhbiBycG0gLXRhIGl0CiAjCiBz
cGVjOgotCVsgLWUgLnZlcnNpb24gXSB8fCBlY2hvIDEgPiAudmVyc2lvbgogCS4gc2NyaXB0cy9t
a3NwZWMgPmtlcm5lbC5zcGVjCiAKICMKLSMJQnVpbGQgYSB0YXIgYmFsbCAsIGdlbmVyYXRlIGFu
IHJwbSBmcm9tIGl0IGFuZCBwYWNrIHRoZSByZXN1bHQKKyMJQnVpbGQgYSB0YXIgYmFsbCwgZ2Vu
ZXJhdGUgYW4gcnBtIGZyb20gaXQgYW5kIHBhY2sgdGhlIHJlc3VsdAogIwlUaGVyZSBhcncgdHdv
IGJpdHMgb2YgbWFnaWMgaGVyZQogIwkxKSBUaGUgdXNlIG9mIC8uIHRvIGF2b2lkIHRhciBwYWNr
aW5nIGp1c3QgdGhlIHN5bWxpbmsKICMJMikgUmVtb3ZpbmcgdGhlIC5kZXAgZmlsZXMgYXMgdGhl
eSBoYXZlIHNvdXJjZSBwYXRocyBpbiB0aGVtIHRoYXQKICMJICAgd2lsbCBiZWNvbWUgaW52YWxp
ZAogIwotcnBtOgljbGVhbiBuZXd2ZXJzaW9uIHNwZWMKK3JwbToJY2xlYW4gc3BlYwogCWZpbmQg
LiBcKCAtc2l6ZSAwIC1vIC1uYW1lIC5kZXBlbmQgLW8gLW5hbWUgLmhkZXBlbmQgXCkgLXR5cGUg
ZiAtcHJpbnQgfCB4YXJncyBybSAtZgogCXNldCAtZTsgXAogCWNkICQoVE9QRElSKS8uLiA7IFwK
IAlsbiAtc2YgJChUT1BESVIpICQoS0VSTkVMUEFUSCkgOyBcCi0JdGFyIGN2ZnogJChLRVJORUxQ
QVRIKS50YXIuZ3ogJChLRVJORUxQQVRIKS8uIDsgXAotCXJwbSAtdGEgJChUT1BESVIpLy4uLyQo
S0VSTkVMUEFUSCkudGFyLmd6CisJdGFyIC1jdnogLS1leGNsdWRlIENWUyAtZiAkKEtFUk5FTFBB
VEgpLnRhci5neiAkKEtFUk5FTFBBVEgpLy4gOyBcCisJcm0gJChLRVJORUxQQVRIKSA7IFwKKwlj
ZCAkKFRPUERJUikgOyBcCisJLiBzY3JpcHRzL21rdmVyc2lvbiA+IC52ZXJzaW9uIDsgXAorCXJw
bSAtdGEgJChUT1BESVIpLy4uLyQoS0VSTkVMUEFUSCkudGFyLmd6IDsgXAorCXJtICQoVE9QRElS
KS8uLi8kKEtFUk5FTFBBVEgpLnRhci5negpkaWZmIC11TiBsaW51eC5vcmlnL3NjcmlwdHMvbWtz
cGVjIGxpbnV4L3NjcmlwdHMvbWtzcGVjCi0tLSBsaW51eC5vcmlnL3NjcmlwdHMvbWtzcGVjCVN1
biBBdWcgMTkgMjI6NTg6MjkgMjAwMQorKysgbGludXgvc2NyaXB0cy9ta3NwZWMJVGh1IEF1ZyAz
MCAyMTo1MjoxOSAyMDAxCkBAIC05LDggKzksOSBAQAogZWNobyAiTmFtZToga2VybmVsIgogZWNo
byAiU3VtbWFyeTogVGhlIExpbnV4IEtlcm5lbCIKIGVjaG8gIlZlcnNpb246ICIkVkVSU0lPTi4k
UEFUQ0hMRVZFTC4kU1VCTEVWRUwkRVhUUkFWRVJTSU9OIHwgc2VkIC1lICJzLy0vLyIKLWVjaG8g
LW4gIlJlbGVhc2U6ICIKLWNhdCAudmVyc2lvbgorIyB3ZSBuZWVkIHRvIGRldGVybWluZSB0aGUg
TkVYVCB2ZXJzaW9uIG51bWJlciBzbyB0aGF0IHVuYW1lIGFuZAorIyBycG0gLXEgd2lsbCBhZ3Jl
ZQorZWNobyAiUmVsZWFzZTogYC4gc2NyaXB0cy9ta3ZlcnNpb25gIgogZWNobyAiTGljZW5zZTog
R1BMIgogZWNobyAiR3JvdXA6IFN5c3RlbSBFbnZpcm9ubWVudC9LZXJuZWwiCiBlY2hvICJWZW5k
b3I6IFRoZSBMaW51eCBDb21tdW5pdHkiCmRpZmYgLXVOIGxpbnV4Lm9yaWcvc2NyaXB0cy9ta3Zl
cnNpb24gbGludXgvc2NyaXB0cy9ta3ZlcnNpb24KLS0tIGxpbnV4Lm9yaWcvc2NyaXB0cy9ta3Zl
cnNpb24JV2VkIERlYyAzMSAxODowMDowMCAxOTY5CisrKyBsaW51eC9zY3JpcHRzL21rdmVyc2lv
bglXZWQgQXVnIDI5IDIwOjM0OjU1IDIwMDEKQEAgLTAsMCArMSw2IEBACitpZiBbICEgLWYgLnZl
cnNpb24gXQordGhlbgorICAgIGVjaG8gMQorZWxzZQorICAgIGV4cHIgMGBjYXQgLnZlcnNpb25g
ICsgMQorZmkK

--------------Boundary-00=_JIFYOI556JX1N7VEOEJJ--
