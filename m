Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbTIKUkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbTIKUkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:40:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:35809 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261517AbTIKUj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:39:59 -0400
Message-Id: <5.0.2.1.2.20030911222745.02e59ec0@pop.kundenserver.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 11 Sep 2003 22:47:31 +0200
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
From: Sancho Dauskardt <sda@bdit.de>
Subject: Re: FAT statfs loop abort on read-error
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <87wuetnkjw.fsf@devron.myhome.or.jp>
References: <5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
 <20030706102410.2becd137.rddunlap@osdl.org>
 <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
 <20030706102410.2becd137.rddunlap@osdl.org>
 <5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_23852390==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_23852390==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Hi,

  It's a while back, but now here's a patch that "works for me".
Once applied, we get a nice -EIO when doing a df / statfs() on a mounted 
FAT partition with removed media (without this would hang for minutes).

The change will affect anybody calling fat_access() (the cvf stuff, other 
fat-dependent modules).

Applies on 2.4.19 .. 2.4.22 for me.

Thanks,
- sda

At 23:46 08.07.03 +0900, OGAWA Hirofumi wrote:
>Sancho Dauskardt <sda@bdit.de> writes:
>
> > >I don't know anybody ported dmsdos to 2.4. The cvf stuff was removed
> > >and many error handlings was fixed on 2.5.x. So, personally I think to
> > >remove the cvf stuff and backport the some parts of fat driver to 2.4
> > >is good.
> >
> > OK, the 100k diff between 2.4.21/fs/fat and 2.5.74 didn't really help
> > me understand what's really changed (other than the cvf removal).
> > Should I attempt to brute-force backport fs/fat/* in one large patch,
> > or incrementally re-apply the 2.5 changes to 2.4 ?
>
>I submited the some patch to marcelo several times about one year ago,
>however, unfortunately those patches was ignored.
>
>So, one large patch may not be applied. And incremental ways is more
>safety, I think. (Probably, we need to address the difference of vfs
>and umsdos)
>
> > Or, as you write 'some parts', which parts would that be ?
>
>I thought that the patches of only bug fix is probably easy to be
>applied.


--=====================_23852390==_
Content-Type: application/octet-stream; name="patch_2.4.21-fat-statfs-loop-abort.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch_2.4.21-fat-statfs-loop-abort.diff"

ZGlmZiAtdXJOIC1YIGRvbnRkaWZmLnR4dCBsaW51eC0yLjQuMjEtNjQwbC1uZXQvZnMvZmF0L2Nh
Y2hlLmMgbGludXgtMi40LjIxL2ZzL2ZhdC9jYWNoZS5jCi0tLSBsaW51eC0yLjQuMjEtNjQwbC1u
ZXQvZnMvZmF0L2NhY2hlLmMJRnJpIE9jdCAxMiAyMjo0ODo0MiAyMDAxCisrKyBsaW51eC0yLjQu
MjEvZnMvZmF0L2NhY2hlLmMJVHVlIFNlcCAgOSAxMzoxMDozMCAyMDAzCkBAIC01Niw3ICs1Niw3
IEBACiAJYiA9IE1TRE9TX1NCKHNiKS0+ZmF0X3N0YXJ0ICsgKGZpcnN0ID4+IHNiLT5zX2Jsb2Nr
c2l6ZV9iaXRzKTsKIAlpZiAoIShiaCA9IGZhdF9icmVhZChzYiwgYikpKSB7CiAJCXByaW50aygi
YnJlYWQgaW4gZmF0X2FjY2VzcyBmYWlsZWRcbiIpOwotCQlyZXR1cm4gMDsKKwkJcmV0dXJuIC0y
OwkJLyogISEhISEhISEhISEhISAqLwogCX0KIAlpZiAoKGZpcnN0ID4+IHNiLT5zX2Jsb2Nrc2l6
ZV9iaXRzKSA9PSAobGFzdCA+PiBzYi0+c19ibG9ja3NpemVfYml0cykpIHsKIAkJYmgyID0gYmg7
CkBAIC02NCw3ICs2OCw3IEBACiAJCWlmICghKGJoMiA9IGZhdF9icmVhZChzYiwgYisxKSkpIHsK
IAkJCWZhdF9icmVsc2Uoc2IsIGJoKTsKIAkJCXByaW50aygiMm5kIGJyZWFkIGluIGZhdF9hY2Nl
c3MgZmFpbGVkXG4iKTsKLQkJCXJldHVybiAwOworCQkJcmV0dXJuIC0yOwkvKiAhISEhISEhISAq
LwogCQl9CiAJfQogCWlmIChNU0RPU19TQihzYiktPmZhdF9iaXRzID09IDMyKSB7CkBAIC0yODMs
OCArMjg3LDggQEAKIAljb3VudCA9IDA7CiAJZm9yIChmYXRfY2FjaGVfbG9va3VwKGlub2RlLGNs
dXN0ZXIsJmNvdW50LCZucik7IGNvdW50IDwgY2x1c3RlcjsKIAkgICAgY291bnQrKykgewotCQlp
ZiAoKG5yID0gZmF0X2FjY2Vzcyhpbm9kZS0+aV9zYixuciwtMSkpID09IC0xKSByZXR1cm4gMDsK
LQkJaWYgKCFucikgcmV0dXJuIDA7CisJCW5yID0gZmF0X2FjY2Vzcyhpbm9kZS0+aV9zYixuciwt
MSk7CisJCWlmIChuciA8PSAwKSByZXR1cm4gMDsJCS8qIDA9bGFzdCwgLTE9ZW5kIC0yPWVycm9y
ICovCiAJfQogCWZhdF9jYWNoZV9hZGQoaW5vZGUsY2x1c3Rlcixucik7CiAJcmV0dXJuIG5yOwpA
QCAtMzI4LDcgKzMzMiwxMyBAQAogCWxhc3QgPSAwOwogCXdoaWxlIChza2lwLS0pIHsKIAkJbGFz
dCA9IG5yOwotCQlpZiAoKG5yID0gZmF0X2FjY2Vzcyhpbm9kZS0+aV9zYixuciwtMSkpID09IC0x
KSByZXR1cm4gMDsKKwkJbnIgPSBmYXRfYWNjZXNzKGlub2RlLT5pX3NiLG5yLC0xKTsKKworCQlp
ZiAobnIgPT0gLTEpIHJldHVybiAwOworCQlpZiAobnIgPT0gLTIpIHsKKwkJCXByaW50aygiZmF0
X2ZyZWU6IHJlYWQgZXJyb3JcbiIpOworCQkJcmV0dXJuIC1FSU87CisJCX0KIAkJaWYgKCFucikg
ewogCQkJcHJpbnRrKCJmYXRfZnJlZTogc2tpcHBlZCBFT0ZcbiIpOwogCQkJcmV0dXJuIC1FSU87
CkBAIC0zNDQsNyArMzU0LDcgQEAKIAkJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7CiAJfQogCWxv
Y2tfZmF0KGlub2RlLT5pX3NiKTsKLQl3aGlsZSAobnIgIT0gLTEpIHsKKwl3aGlsZSAobnIgPj0g
MCkgewkJLyogIT0gLTEgKi8KIAkJaWYgKCEobnIgPSBmYXRfYWNjZXNzKGlub2RlLT5pX3NiLG5y
LDApKSkgewogCQkJZmF0X2ZzX3BhbmljKGlub2RlLT5pX3NiLCJmYXRfZnJlZTogZGVsZXRpbmcg
YmV5b25kIEVPRiIpOwogCQkJYnJlYWs7CmRpZmYgLXVyTiAtWCBkb250ZGlmZi50eHQgbGludXgt
Mi40LjIxLTY0MGwtbmV0L2ZzL2ZhdC9pbm9kZS5jIGxpbnV4LTIuNC4yMS9mcy9mYXQvaW5vZGUu
YwotLS0gbGludXgtMi40LjIxLTY0MGwtbmV0L2ZzL2ZhdC9pbm9kZS5jCVNhdCBBdWcgIDMgMDI6
Mzk6NDUgMjAwMgorKysgbGludXgtMi40LjIxL2ZzL2ZhdC9pbm9kZS5jCVR1ZSBTZXAgIDkgMTM6
MTA6MjggMjAwMwpAQCAtODIwLDcgKzgyMCw3IEBACiAKIGludCBmYXRfc3RhdGZzKHN0cnVjdCBz
dXBlcl9ibG9jayAqc2Isc3RydWN0IHN0YXRmcyAqYnVmKQogewotCWludCBmcmVlLG5yOworCWlu
dCBmcmVlLG5yLGU7CiAgICAgICAgCiAJaWYgKE1TRE9TX1NCKHNiKS0+Y3ZmX2Zvcm1hdCAmJgog
CSAgICBNU0RPU19TQihzYiktPmN2Zl9mb3JtYXQtPmN2Zl9zdGF0ZnMpCkBAIC04MzIsOCArODMy
LDE4IEBACiAJCWZyZWUgPSBNU0RPU19TQihzYiktPmZyZWVfY2x1c3RlcnM7CiAJZWxzZSB7CiAJ
CWZyZWUgPSAwOwotCQlmb3IgKG5yID0gMjsgbnIgPCBNU0RPU19TQihzYiktPmNsdXN0ZXJzKzI7
IG5yKyspCi0JCQlpZiAoIWZhdF9hY2Nlc3Moc2IsbnIsLTEpKSBmcmVlKys7CisJCWZvciAobnIg
PSAyOyBuciA8IE1TRE9TX1NCKHNiKS0+Y2x1c3RlcnMrMjsgbnIrKyl7CisJCQllID0gZmF0X2Fj
Y2VzcyhzYixuciwtMSk7CisJCQlpZighZSkKKwkJCQlmcmVlKys7CisKKwkJCWlmKCBlID09IC0y
ICl7CisJCQkJcHJpbnRrKCJDYW4ndCBmYXRfYWNjZXNzIHNlY3RvciAlZCwgJWQuXG4iLG5yLGUp
OworCQkJCXVubG9ja19mYXQoc2IpOworCQkJCXJldHVybiAtRUlPOworCQkJfQorCQl9CisJCQog
CQlNU0RPU19TQihzYiktPmZyZWVfY2x1c3RlcnMgPSBmcmVlOwogCX0KIAl1bmxvY2tfZmF0KHNi
KTsKZGlmZiAtdXJOIC1YIGRvbnRkaWZmLnR4dCBsaW51eC0yLjQuMjEtNjQwbC1uZXQvZnMvZmF0
L21pc2MuYyBsaW51eC0yLjQuMjEvZnMvZmF0L21pc2MuYwotLS0gbGludXgtMi40LjIxLTY0MGwt
bmV0L2ZzL2ZhdC9taXNjLmMJRnJpIE9jdCAxMiAyMjo0ODo0MiAyMDAxCisrKyBsaW51eC0yLjQu
MjEvZnMvZmF0L21pc2MuYwlUdWUgU2VwICA5IDEzOjE5OjA0IDIwMDMKQEAgLTE2NSw3ICsxNjUs
NyBAQAogCWlmICgoY3VyciA9IE1TRE9TX0koaW5vZGUpLT5pX3N0YXJ0KSAhPSAwKSB7CiAJCWZh
dF9jYWNoZV9sb29rdXAoaW5vZGUsIElOVF9NQVgsICZsYXN0LCAmY3Vycik7CiAJCWZpbGVfY2x1
c3RlciA9IGxhc3Q7Ci0JCXdoaWxlIChjdXJyICYmIGN1cnIgIT0gLTEpeworCQl3aGlsZSAoIGN1
cnIgPiAwKXsJLyogd2FzIChjdXJyICYmIGN1cnIgIT0gLTEpLCBub3cgLTIgPT0gZXJyb3IgKi8K
IAkJCWZpbGVfY2x1c3RlcisrOwogCQkJaWYgKCEoY3VyciA9IGZhdF9hY2Nlc3Moc2IsIGxhc3Qg
PSBjdXJyLC0xKSkpIHsKIAkJCQlmYXRfZnNfcGFuaWMoc2IsICJGaWxlIHdpdGhvdXQgRU9GIik7
Cg==
--=====================_23852390==_--

