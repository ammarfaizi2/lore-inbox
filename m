Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTLPAkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTLPAkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:40:23 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:41229 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S264093AbTLPAkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:40:12 -0500
Message-ID: <1071536102.3fde57e670996@vds.kolivas.org>
Date: Tue, 16 Dec 2003 11:55:02 +1100
From: Con Kolivas <kernel@kolivas.org>
To: Nathan Fredrickson <8nrf@qlink.queensu.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT schedulers' performance on single HT processor
References: <200312130157.36843.kernel@kolivas.org>  <1071431363.19011.64.camel@rocky>  <200312152111.52949.kernel@kolivas.org> <1071533802.24673.35.camel@rocky>
In-Reply-To: <1071533802.24673.35.camel@rocky>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ107153610196f12ccd12b5aa106119e67cf1aac220"
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ107153610196f12ccd12b5aa106119e67cf1aac220
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Quoting Nathan Fredrickson <8nrf@qlink.queensu.ca>:
>           X =  1     2     3     4     5     6     7     8     9    16
> 1phys UP      1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00
> 4phys SMP     1.00  0.99  0.51  0.35  0.27  0.27  0.27  0.27  0.27  0.27
> 4phys HT      1.01  1.00  0.55  0.40  0.33  0.29  0.27  0.26  0.25  0.26
> 4phys HT(w26) 1.01  1.01  0.54  0.37  0.31  0.27  0.26  0.26  0.26  0.26
> 4phys HT(C1)  1.01  1.00  0.52  0.36  0.29  0.28  0.27  0.26  0.25  0.26
> 
> Interesting that the overhead due to HT in the X=1 column is only 1%
> with 4 physical processors.  It was 1-3% before with 1 or 2 physical
> processors.
> 
> In the partial load columns where there are less compiler processes than
> logical CPUs (X=3,4,5,6,7), it appears that both patches are doing a
> better job scheduling than the standard scheduler.  At full load (X=>8)
> all three HT test cases perform about equally and beat standard SMP by
> 1-2%.
> 
> Hope these results are helpful.  I'd be happy to run more cases and/or
> other patches.

(cc list stripped)

Well since you asked... I've been looking for someone with more HT cpus to give
a much simpler approach a try. Here's a sample patch for vanilla test11 with
HT. This one actually helps UP HT performance ever so slightly and I'd be
curious to see if it does anything on more cpus.

Con

---MOQ107153610196f12ccd12b5aa106119e67cf1aac220
Content-Type: application/octet-stream; name="patch-test11-ht-3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-test11-ht-3"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxMS1iYXNlL2tlcm5lbC9zY2hlZC5jCTIwMDMtMTEtMjQgMjI6
MTg6NTYuMDAwMDAwMDAwICsxMTAwCisrKyBsaW51eC0yLjYuMC10ZXN0MTEtaHQzL2tlcm5lbC9z
Y2hlZC5jCTIwMDMtMTItMTUgMjM6Mzg6MzMuMjUwMDU5NTQyICsxMTAwCkBAIC0yMDQsNiArMjA0
LDcgQEAgc3RydWN0IHJ1bnF1ZXVlIHsKIAlzdHJ1Y3QgbW1fc3RydWN0ICpwcmV2X21tOwogCXBy
aW9fYXJyYXlfdCAqYWN0aXZlLCAqZXhwaXJlZCwgYXJyYXlzWzJdOwogCWludCBwcmV2X2NwdV9s
b2FkW05SX0NQVVNdOworCXVuc2lnbmVkIGxvbmcgY3B1OwogI2lmZGVmIENPTkZJR19OVU1BCiAJ
YXRvbWljX3QgKm5vZGVfbnJfcnVubmluZzsKIAlpbnQgcHJldl9ub2RlX2xvYWRbTUFYX05VTU5P
REVTXTsKQEAgLTIyMSw2ICsyMjIsMTAgQEAgc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBy
dW5xdWV1ZSwgcgogI2RlZmluZSB0YXNrX3JxKHApCQljcHVfcnEodGFza19jcHUocCkpCiAjZGVm
aW5lIGNwdV9jdXJyKGNwdSkJCShjcHVfcnEoY3B1KS0+Y3VycikKIAorI2RlZmluZSBodF9hY3Rp
dmUJCShjcHVfaGFzX2h0ICYmIHNtcF9udW1fc2libGluZ3MgPiAxKQorI2RlZmluZSBodF9zaWJs
aW5ncyhjcHUxLCBjcHUyKQkoaHRfYWN0aXZlICYmIFwKKwljcHVfc2libGluZ19tYXBbKGNwdTEp
XSA9PSAoY3B1MikpCisKIC8qCiAgKiBEZWZhdWx0IGNvbnRleHQtc3dpdGNoIGxvY2tpbmc6CiAg
Ki8KQEAgLTExNTcsOCArMTE2Miw5IEBAIGNhbl9taWdyYXRlX3Rhc2sodGFza190ICp0c2ssIHJ1
bnF1ZXVlX3QKIHsKIAl1bnNpZ25lZCBsb25nIGRlbHRhID0gc2NoZWRfY2xvY2soKSAtIHRzay0+
dGltZXN0YW1wOwogCi0JaWYgKCFpZGxlICYmIChkZWx0YSA8PSBKSUZGSUVTX1RPX05TKGNhY2hl
X2RlY2F5X3RpY2tzKSkpCi0JCXJldHVybiAwOworCWlmICghaWRsZSAmJiAoZGVsdGEgPD0gSklG
RklFU19UT19OUyhjYWNoZV9kZWNheV90aWNrcykpICYmCisJCSFodF9zaWJsaW5ncyh0aGlzX2Nw
dSwgdGFza19jcHUodHNrKSkpCisJCQlyZXR1cm4gMDsKIAlpZiAodGFza19ydW5uaW5nKHJxLCB0
c2spKQogCQlyZXR1cm4gMDsKIAlpZiAoIWNwdV9pc3NldCh0aGlzX2NwdSwgdHNrLT5jcHVzX2Fs
bG93ZWQpKQpAQCAtMTE5MywxNSArMTE5OSwyMyBAQCBzdGF0aWMgdm9pZCBsb2FkX2JhbGFuY2Uo
cnVucXVldWVfdCAqdGhpCiAJaW1iYWxhbmNlIC89IDI7CiAKIAkvKgorCSAqIEZvciBoeXBlcnRo
cmVhZCBzaWJsaW5ncyB0YWtlIHRhc2tzIGZyb20gdGhlIGFjdGl2ZSBhcnJheQorCSAqIHRvIGdl
dCBjYWNoZS13YXJtIHRhc2tzIHNpbmNlIHRoZXkgc2hhcmUgY2FjaGVzLgorCSAqLworCWlmICho
dF9zaWJsaW5ncyh0aGlzX2NwdSwgYnVzaWVzdC0+Y3B1KSkKKwkJYXJyYXkgPSBidXNpZXN0LT5h
Y3RpdmU7CisJLyoKIAkgKiBXZSBmaXJzdCBjb25zaWRlciBleHBpcmVkIHRhc2tzLiBUaG9zZSB3
aWxsIGxpa2VseSBub3QgYmUKIAkgKiBleGVjdXRlZCBpbiB0aGUgbmVhciBmdXR1cmUsIGFuZCB0
aGV5IGFyZSBtb3N0IGxpa2VseSB0bwogCSAqIGJlIGNhY2hlLWNvbGQsIHRodXMgc3dpdGNoaW5n
IENQVXMgaGFzIHRoZSBsZWFzdCBlZmZlY3QKIAkgKiBvbiB0aGVtLgogCSAqLwotCWlmIChidXNp
ZXN0LT5leHBpcmVkLT5ucl9hY3RpdmUpCi0JCWFycmF5ID0gYnVzaWVzdC0+ZXhwaXJlZDsKLQll
bHNlCi0JCWFycmF5ID0gYnVzaWVzdC0+YWN0aXZlOworCWVsc2UgeworCQlpZiAoYnVzaWVzdC0+
ZXhwaXJlZC0+bnJfYWN0aXZlKQorCQkJYXJyYXkgPSBidXNpZXN0LT5leHBpcmVkOworCQllbHNl
CisJCQlhcnJheSA9IGJ1c2llc3QtPmFjdGl2ZTsKKwl9CiAKIG5ld19hcnJheToKIAkvKiBTdGFy
dCBzZWFyY2hpbmcgYXQgcHJpb3JpdHkgMDogKi8KQEAgLTEyMTIsOSArMTIyNiwxNiBAQCBza2lw
X2JpdG1hcDoKIAllbHNlCiAJCWlkeCA9IGZpbmRfbmV4dF9iaXQoYXJyYXktPmJpdG1hcCwgTUFY
X1BSSU8sIGlkeCk7CiAJaWYgKGlkeCA+PSBNQVhfUFJJTykgewotCQlpZiAoYXJyYXkgPT0gYnVz
aWVzdC0+ZXhwaXJlZCkgewotCQkJYXJyYXkgPSBidXNpZXN0LT5hY3RpdmU7Ci0JCQlnb3RvIG5l
d19hcnJheTsKKwkJaWYgKGh0X3NpYmxpbmdzKHRoaXNfY3B1LCBidXNpZXN0LT5jcHUpKXsKKwkJ
CWlmIChhcnJheSA9PSBidXNpZXN0LT5hY3RpdmUpIHsKKwkJCQlhcnJheSA9IGJ1c2llc3QtPmV4
cGlyZWQ7CisJCQkJZ290byBuZXdfYXJyYXk7CisJCQl9CisJCX0gZWxzZSB7CisJCQlpZiAoYXJy
YXkgPT0gYnVzaWVzdC0+ZXhwaXJlZCkgeworCQkJCWFycmF5ID0gYnVzaWVzdC0+YWN0aXZlOwor
CQkJCWdvdG8gbmV3X2FycmF5OworCQkJfQogCQl9CiAJCWdvdG8gb3V0X3VubG9jazsKIAl9CkBA
IC0yODEyLDYgKzI4MzMsNyBAQCB2b2lkIF9faW5pdCBzY2hlZF9pbml0KHZvaWQpCiAJCXByaW9f
YXJyYXlfdCAqYXJyYXk7CiAKIAkJcnEgPSBjcHVfcnEoaSk7CisJCXJxLT5jcHUgPSAodW5zaWdu
ZWQgbG9uZykoaSk7CiAJCXJxLT5hY3RpdmUgPSBycS0+YXJyYXlzOwogCQlycS0+ZXhwaXJlZCA9
IHJxLT5hcnJheXMgKyAxOwogCQlzcGluX2xvY2tfaW5pdCgmcnEtPmxvY2spOwo=

---MOQ107153610196f12ccd12b5aa106119e67cf1aac220--
