Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315747AbSECXNP>; Fri, 3 May 2002 19:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315750AbSECXNO>; Fri, 3 May 2002 19:13:14 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:12518 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315747AbSECXNM>; Fri, 3 May 2002 19:13:12 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_KI5KHD4GQG7LHGP5R3NW"
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] Via-Rhine driver
Date: Fri, 3 May 2002 17:06:20 -0600
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02050317062003.05061@cobra.linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_KI5KHD4GQG7LHGP5R3NW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Please consider the attached patch.

(Allright - I know I'm not supposed to do this but for some reason I can't 
get past the whitespace problem....all tabs are converted to spaces after 
highlight-copy...how do you deal with that?)

I removed Shing Chuang's additions and any controversial things
which I'll post for further discussion in another thread.

PATCH DIFF-ED AGAINST: Kernel 2.4.19-pre8 + ioapic compile patch
PATCH CONTENTS:
	- fixes comments for Rhine-III
	- removes W_MAX_TIMEOUT (unused)
	- adds HasDavicomPhy for Rhine-I (basis: linuxfet driver; my card is R-I and 
				has Davicom chip, flag is referenced in kernel driver)
	- sends chip_id as a parameter to wait_for_reset since np is not initialized 
					on first call
	- changes mmio "else if (chip_id==VT6102)" to "else" so it will work for 				
		Rhine-III's (documentation says same bit is correct)		
	- transmit frame queue message is off by one - fixed
	- adds IntrNormalSummary to "Something Wicked" exclusion list
		so normal interrupts will not trigger the message (src: Donald Becker)

	
		


	







--------------Boundary-00=_KI5KHD4GQG7LHGP5R3NW
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="viadiff2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="viadiff2"

LS0tIHZpYS1yaGluZS5jLm9yaWdrZXJuZWwJRnJpIE1heSAgMyAwOToxMzowNyAyMDAyCisrKyB2
aWEtcmhpbmUuYwlGcmkgTWF5ICAzIDE1OjU3OjEwIDIwMDIKQEAgLTksOCArOSw4IEBACiAJYSBj
b21wbGV0ZSBwcm9ncmFtIGFuZCBtYXkgb25seSBiZSB1c2VkIHdoZW4gdGhlIGVudGlyZSBvcGVy
YXRpbmcKIAlzeXN0ZW0gaXMgbGljZW5zZWQgdW5kZXIgdGhlIEdQTC4KIAotCVRoaXMgZHJpdmVy
IGlzIGRlc2lnbmVkIGZvciB0aGUgVklBIFZUODZjMTAwQSBSaGluZS1JSSBQQ0kgRmFzdCBFdGhl
cm5ldAotCWNvbnRyb2xsZXIuICBJdCBhbHNvIHdvcmtzIHdpdGggdGhlIG9sZGVyIDMwNDMgUmhp
bmUtSSBjaGlwLgorCVRoaXMgZHJpdmVyIGlzIGRlc2lnbmVkIGZvciB0aGUgVklBIFZUODZDMTAw
QSBSaGluZS1JLiAKKwlJdCBhbHNvIHdvcmtzIHdpdGggdGhlIDYxMDIgUmhpbmUtSUksIGFuZCA2
MTA1LzYxMDVNIFJoaW5lLUlJSS4gICAKIAogCVRoZSBhdXRob3IgbWF5IGJlIHJlYWNoZWQgYXMg
YmVja2VyQHNjeWxkLmNvbSwgb3IgQy9PCiAJU2N5bGQgQ29tcHV0aW5nIENvcnBvcmF0aW9uCkBA
IC0xMzYsOSArMTM2LDYgQEAKIAogI2RlZmluZSBQS1RfQlVGX1NaCQkxNTM2CQkJLyogU2l6ZSBv
ZiBlYWNoIHRlbXBvcmFyeSBSeCBidWZmZXIuKi8KIAotLyogbWF4IHRpbWUgb3V0IGRlbGF5IHRp
bWUgKi8KLSNkZWZpbmUgV19NQVhfVElNRU9VVAkweDBGRkZVCi0KICNpZiAhZGVmaW5lZChfX09Q
VElNSVpFX18pICB8fCAgIWRlZmluZWQoX19LRVJORUxfXykKICN3YXJuaW5nICBZb3UgbXVzdCBj
b21waWxlIHRoaXMgZmlsZSB3aXRoIHRoZSBjb3JyZWN0IG9wdGlvbnMhCiAjd2FybmluZyAgU2Vl
IHRoZSBsYXN0IGxpbmVzIG9mIHRoZSBzb3VyY2UgZmlsZS4KQEAgLTM0Myw3ICszNDAsNyBAQAog
c3RhdGljIHN0cnVjdCB2aWFfcmhpbmVfY2hpcF9pbmZvIHZpYV9yaGluZV9jaGlwX2luZm9bXSBf
X2RldmluaXRkYXRhID0KIHsKIAl7ICJWSUEgVlQ4NkMxMDBBIFJoaW5lIiwgUkhJTkVfSU9UWVBF
LCAxMjgsCi0JICBDYW5IYXZlTUlJIHwgUmVxVHhBbGlnbiB9LAorCSAgQ2FuSGF2ZU1JSSB8IFJl
cVR4QWxpZ24gfCBIYXNEYXZpY29tUGh5IH0sCiAJeyAiVklBIFZUNjEwMiBSaGluZS1JSSIsIFJI
SU5FX0lPVFlQRSwgMjU2LAogCSAgQ2FuSGF2ZU1JSSB8IEhhc1dPTCB9LAogCXsgIlZJQSBWVDYx
MDUgUmhpbmUtSUlJIiwgUkhJTkVfSU9UWVBFLCAyNTYsCkBAIC01MDYsMTQgKzUwMywxMiBAQAog
c3RhdGljIGludCAgdmlhX3JoaW5lX2Nsb3NlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpOwogc3Rh
dGljIGlubGluZSB2b2lkIGNsZWFyX3RhbGx5X2NvdW50ZXJzKGxvbmcgaW9hZGRyKTsKIAotc3Rh
dGljIHZvaWQgd2FpdF9mb3JfcmVzZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgY2hhciAqbmFt
ZSkKK3N0YXRpYyB2b2lkIHdhaXRfZm9yX3Jlc2V0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGlu
dCBjaGlwX2lkLCBjaGFyICpuYW1lKQogewotCXN0cnVjdCBuZXRkZXZfcHJpdmF0ZSAqbnAgPSBk
ZXYtPnByaXY7CiAJbG9uZyBpb2FkZHIgPSBkZXYtPmJhc2VfYWRkcjsKLQlpbnQgY2hpcF9pZCA9
IG5wLT5jaGlwX2lkOwogCWludCBpOwogCi0JLyogMzA0MyBtYXkgbmVlZCBsb25nIGRlbGF5IGFm
dGVyIHJlc2V0IChkbGluaykgKi8KKwkvKiBWVDg2QzEwMEEgbWF5IG5lZWQgbG9uZyBkZWxheSBh
ZnRlciByZXNldCAoZGxpbmspICovCiAJaWYgKGNoaXBfaWQgPT0gVlQ4NkMxMDBBKQogCQl1ZGVs
YXkoMTAwKTsKIApAQCAtNTM5LDcgKzUzNCw3IEBACiAJCS8qIE1vcmUgcmVjZW50IGRvY3Mgc2F5
IHRoYXQgdGhpcyBiaXQgaXMgcmVzZXJ2ZWQgLi4uICovCiAJCW4gPSBpbmIoaW9hZGRyICsgQ29u
ZmlnQSkgfCAweDIwOwogCQlvdXRiKG4sIGlvYWRkciArIENvbmZpZ0EpOwotCX0gZWxzZSBpZiAo
Y2hpcF9pZCA9PSBWVDYxMDIpIHsKKwl9IGVsc2UgewogCQluID0gaW5iKGlvYWRkciArIENvbmZp
Z0QpIHwgMHg4MDsKIAkJb3V0YihuLCBpb2FkZHIgKyBDb25maWdEKTsKIAl9CkBAIC02NjMsNyAr
NjU4LDcgQEAKIAl3cml0ZXcoQ21kUmVzZXQsIGlvYWRkciArIENoaXBDbWQpOwogCiAJZGV2LT5i
YXNlX2FkZHIgPSBpb2FkZHI7Ci0Jd2FpdF9mb3JfcmVzZXQoZGV2LCBzaG9ydG5hbWUpOworCXdh
aXRfZm9yX3Jlc2V0KGRldiwgY2hpcF9pZCwgc2hvcnRuYW1lKTsKIAogCS8qIFJlbG9hZCB0aGUg
c3RhdGlvbiBhZGRyZXNzIGZyb20gdGhlIEVFUFJPTS4gKi8KICNpZmRlZiBVU0VfSU8KQEAgLTEw
NzQsNyArMTA2OSw3IEBACiAJCXJldHVybiBpOwogCWFsbG9jX3JidWZzKGRldik7CiAJYWxsb2Nf
dGJ1ZnMoZGV2KTsKLQl3YWl0X2Zvcl9yZXNldChkZXYsIGRldi0+bmFtZSk7CisJd2FpdF9mb3Jf
cmVzZXQoZGV2LCBucC0+Y2hpcF9pZCwgZGV2LT5uYW1lKTsKIAlpbml0X3JlZ2lzdGVycyhkZXYp
OwogCWlmIChkZWJ1ZyA+IDIpCiAJCXByaW50ayhLRVJOX0RFQlVHICIlczogRG9uZSB2aWFfcmhp
bmVfb3BlbigpLCBzdGF0dXMgJTQuNHggIgpAQCAtMTE4MSw3ICsxMTc2LDcgQEAKIAlhbGxvY19y
YnVmcyhkZXYpOwogCiAJLyogUmVpbml0aWFsaXplIHRoZSBoYXJkd2FyZS4gKi8KLQl3YWl0X2Zv
cl9yZXNldChkZXYsIGRldi0+bmFtZSk7CisJd2FpdF9mb3JfcmVzZXQoZGV2LCBucC0+Y2hpcF9p
ZCwgZGV2LT5uYW1lKTsKIAlpbml0X3JlZ2lzdGVycyhkZXYpOwogCQogCXNwaW5fdW5sb2NrKCZu
cC0+bG9jayk7CkBAIC0xMjUxLDcgKzEyNDYsNyBAQAogCiAJaWYgKGRlYnVnID4gNCkgewogCQlw
cmludGsoS0VSTl9ERUJVRyAiJXM6IFRyYW5zbWl0IGZyYW1lICMlZCBxdWV1ZWQgaW4gc2xvdCAl
ZC5cbiIsCi0JCQkgICBkZXYtPm5hbWUsIG5wLT5jdXJfdHgsIGVudHJ5KTsKKwkJCSAgIGRldi0+
bmFtZSwgbnAtPmN1cl90eC0xLCBlbnRyeSk7CiAJfQogCXJldHVybiAwOwogfQpAQCAtMTUwMiw4
ICsxNDk3LDggQEAKIAkJCXByaW50ayhLRVJOX0lORk8gIiVzOiBUcmFuc21pdHRlciB1bmRlcnJ1
biwgaW5jcmVhc2luZyBUeCAiCiAJCQkJICAgInRocmVzaG9sZCBzZXR0aW5nIHRvICUyLjJ4Llxu
IiwgZGV2LT5uYW1lLCBucC0+dHhfdGhyZXNoKTsKIAl9Ci0JaWYgKChpbnRyX3N0YXR1cyAmIH4o
IEludHJMaW5rQ2hhbmdlIHwgSW50clN0YXRzTWF4IHwKLQkJCQkJCSAgSW50clR4QWJvcnQgfCBJ
bnRyVHhBYm9ydGVkKSkpIHsKKwlpZiAoaW50cl9zdGF0dXMgJiB+KCBJbnRyTGlua0NoYW5nZSB8
IEludHJTdGF0c01heCB8CisgCQkJCQkJIEludHJUeEFib3J0IHwgSW50clR4QWJvcnRlZCB8IElu
dHJOb3JtYWxTdW1tYXJ5KSkgewogCQlpZiAoZGVidWcgPiAxKQogCQkJcHJpbnRrKEtFUk5fRVJS
ICIlczogU29tZXRoaW5nIFdpY2tlZCBoYXBwZW5lZCEgJTQuNHguXG4iLAogCQkJICAgZGV2LT5u
YW1lLCBpbnRyX3N0YXR1cyk7Cg==

--------------Boundary-00=_KI5KHD4GQG7LHGP5R3NW--
