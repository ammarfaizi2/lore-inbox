Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVBGXOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVBGXOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBGXOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:14:45 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:58000 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261296AbVBGXOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:14:39 -0500
Date: Tue, 8 Feb 2005 00:14:29 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML? 
In-Reply-To: <200502071835.j17IZMlS003456@ccure.user-mode-linux.org>
Message-Id: <Pine.OSF.4.05.10502072330140.29801-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-272106058-1107818069=:29801"
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-272106058-1107818069=:29801
Content-Type: TEXT/PLAIN; charset=US-ASCII

Well, I keep trying a little bit more. In the mean while you can get some
of the stuff I needed to change to at least get it to compile:

One of the problems was use of direct architecture specific semaphores
(which doesn't work under PREEMPT_REALTIME) and in places where a quick
(maybe too quick) look at the code told me that completions ought to be
used. Therefore I changed two semaphores to completions which compiled
fine. I have tried the change on 2.6.11-rc2, and it seemed to work, but I
have not tested it heavily.

The patch is in an attachment - I hope the mail-list will alow that. It is
simply too trouplesome otherwise when I am using Pine as mail client.

Esben


On Mon, 7 Feb 2005, Jeff Dike wrote:

> simlo@phys.au.dk said:
> > Hi, I am trying to compile and run UM-Linux with PREEMPT_REALTIME. I
> > managed to get it to compile but it wont start - it simply stops
> > somewhere in start_kernel() :-( 
> 
> I've never played with preemption on UML.  No doubt it needs some work...
> 
> 				Jeff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--0-272106058-1107818069=:29801
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=uml_semaphore_patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.OSF.4.05.10502080014290.29801@da410.phys.au.dk>
Content-Description: 
Content-Disposition: attachment; filename=uml_semaphore_patch

LS0tIGxpbnV4LTIuNi4xMS1yYzItdW0vYXJjaC91bS9kcml2ZXJzL3BvcnRf
a2Vybi5jLm9yaWcJMjAwNS0wMS0yMyAxNTo1MzoyOS4wMDAwMDAwMDAgKzAx
MDANCisrKyBsaW51eC0yLjYuMTEtcmMyLXVtL2FyY2gvdW0vZHJpdmVycy9w
b3J0X2tlcm4uYwkyMDA1LTAyLTA2IDE5OjU0OjUyLjAwMDAwMDAwMCArMDEw
MA0KQEAgLTIzLDcgKzIzLDcgQEANCiBzdHJ1Y3QgcG9ydF9saXN0IHsNCiAJ
c3RydWN0IGxpc3RfaGVhZCBsaXN0Ow0KIAlpbnQgaGFzX2Nvbm5lY3Rpb247
DQotCXN0cnVjdCBzZW1hcGhvcmUgc2VtOw0KKwlzdHJ1Y3QgY29tcGxldGlv
biBkb25lOw0KIAlpbnQgcG9ydDsNCiAJaW50IGZkOw0KIAlzcGlubG9ja190
IGxvY2s7DQpAQCAtNjYsNyArNjYsNyBAQA0KIAljb25uLT5mZCA9IGZkOw0K
IAlsaXN0X2FkZCgmY29ubi0+bGlzdCwgJmNvbm4tPnBvcnQtPmNvbm5lY3Rp
b25zKTsNCiANCi0JdXAoJmNvbm4tPnBvcnQtPnNlbSk7DQorCWNvbXBsZXRl
KCZjb25uLT5wb3J0LT5kb25lKTsNCiAJcmV0dXJuKElSUV9IQU5ETEVEKTsN
CiB9DQogDQpAQCAtMTgzLDEzICsxODMsMTQgQEANCiAJKnBvcnQgPSAoKHN0
cnVjdCBwb3J0X2xpc3QpIA0KIAkJeyAubGlzdCAJIAk9IExJU1RfSEVBRF9J
TklUKHBvcnQtPmxpc3QpLA0KIAkJICAuaGFzX2Nvbm5lY3Rpb24gCT0gMCwN
Ci0JCSAgLnNlbSAJCQk9IF9fU0VNQVBIT1JFX0lOSVRJQUxJWkVSKHBvcnQt
PnNlbSwgDQotCQkJCQkJCQkgIDApLA0KIAkJICAubG9jayAJCT0gU1BJTl9M
T0NLX1VOTE9DS0VELA0KIAkJICAucG9ydCAJIAk9IHBvcnRfbnVtLA0KIAkJ
ICAuZmQgIAkJCT0gZmQsDQogCQkgIC5wZW5kaW5nIAkJPSBMSVNUX0hFQURf
SU5JVChwb3J0LT5wZW5kaW5nKSwNCiAJCSAgLmNvbm5lY3Rpb25zIAkJPSBM
SVNUX0hFQURfSU5JVChwb3J0LT5jb25uZWN0aW9ucykgfSk7DQorDQorCWlu
aXRfY29tcGxldGlvbigmcG9ydC0+ZG9uZSksIA0KKw0KIAlsaXN0X2FkZCgm
cG9ydC0+bGlzdCwgJnBvcnRzKTsNCiANCiAgZm91bmQ6DQpAQCAtMjIxLDcg
KzIyMiw3IEBADQogCWludCBmZDsNCiANCiAJd2hpbGUoMSl7DQotCQlpZihk
b3duX2ludGVycnVwdGlibGUoJnBvcnQtPnNlbSkpDQorCQlpZih3YWl0X2Zv
cl9jb21wbGV0aW9uX2ludGVycnVwdGlibGUoJnBvcnQtPmRvbmUpKQ0KIAkJ
CXJldHVybigtRVJFU1RBUlRTWVMpOw0KIA0KIAkJc3Bpbl9sb2NrKCZwb3J0
LT5sb2NrKTsNCi0tLSBsaW51eC0yLjYuMTEtcmMyLXVtL2FyY2gvdW0vZHJp
dmVycy94dGVybV9rZXJuLmMub3JpZwkyMDA1LTAxLTIzIDE1OjUzOjI5LjAw
MDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNi4xMS1yYzItdW0vYXJjaC91
bS9kcml2ZXJzL3h0ZXJtX2tlcm4uYwkyMDA1LTAyLTA2IDE5OjU0OjU4LjAw
MDAwMDAwMCArMDEwMA0KQEAgLTE2LDcgKzE2LDcgQEANCiAjaW5jbHVkZSAi
eHRlcm0uaCINCiANCiBzdHJ1Y3QgeHRlcm1fd2FpdCB7DQotCXN0cnVjdCBz
ZW1hcGhvcmUgc2VtOw0KKwlzdHJ1Y3QgY29tcGxldGlvbiByZWFkeTsNCiAJ
aW50IGZkOw0KIAlpbnQgcGlkOw0KIAlpbnQgbmV3X2ZkOw0KQEAgLTMyLDcg
KzMyLDcgQEANCiAJCXJldHVybihJUlFfTk9ORSk7DQogDQogCXh0ZXJtLT5u
ZXdfZmQgPSBmZDsNCi0JdXAoJnh0ZXJtLT5zZW0pOw0KKwljb21wbGV0ZSgm
eHRlcm0tPnJlYWR5KTsNCiAJcmV0dXJuKElSUV9IQU5ETEVEKTsNCiB9DQog
DQpAQCAtNDksMTAgKzQ5LDEwIEBADQogDQogCS8qIFRoaXMgaXMgYSBsb2Nr
ZWQgc2VtYXBob3JlLi4uICovDQogCSpkYXRhID0gKChzdHJ1Y3QgeHRlcm1f
d2FpdCkgDQotCQl7IC5zZW0gIAk9IF9fU0VNQVBIT1JFX0lOSVRJQUxJWkVS
KGRhdGEtPnNlbSwgMCksDQotCQkgIC5mZCAJCT0gc29ja2V0LA0KKwkJeyAu
ZmQgCQk9IHNvY2tldCwNCiAJCSAgLnBpZCAJCT0gLTEsDQogCQkgIC5uZXdf
ZmQgCT0gLTEgfSk7DQorCWluaXRfY29tcGxldGlvbigmZGF0YS0+cmVhZHkp
Ow0KIA0KIAllcnIgPSB1bV9yZXF1ZXN0X2lycShYVEVSTV9JUlEsIHNvY2tl
dCwgSVJRX1JFQUQsIHh0ZXJtX2ludGVycnVwdCwgDQogCQkJICAgICBTQV9J
TlRFUlJVUFQgfCBTQV9TSElSUSB8IFNBX1NBTVBMRV9SQU5ET00sIA0KQEAg
LTY4LDcgKzY4LDcgQEANCiAJICoNCiAJICogWFhYIE5vdGUsIGlmIHRoZSB4
dGVybSBkb2Vzbid0IHdvcmsgZm9yIHNvbWUgcmVhc29uIChlZy4gRElTUExB
WQ0KIAkgKiBpc24ndCBzZXQpIHRoaXMgd2lsbCBoYW5nLi4uICovDQotCWRv
d24oJmRhdGEtPnNlbSk7DQorCXdhaXRfZm9yX2NvbXBsZXRpb24oJmRhdGEt
PnJlYWR5KTsNCiANCiAJZnJlZV9pcnFfYnlfaXJxX2FuZF9kZXYoWFRFUk1f
SVJRLCBkYXRhKTsNCiAJZnJlZV9pcnEoWFRFUk1fSVJRLCBkYXRhKTsNCg==
--0-272106058-1107818069=:29801--
