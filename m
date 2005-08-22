Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVHVUos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVHVUos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHVUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:44:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41959 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751171AbVHVUoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:44:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=tkzYj76hZAf79Q6JFpmLZM8ZBLJm2gDdVH7lSUdMa6iyuVM8Gm59bYrOo7eh9nsXolbttmvq+WvHkIDzmwlVGEci9XyPY4DucJ6HoUO8/UKICSRxJxBk4OojMI0+fc35YccNFDtwkWSVELNXatah6w8gQXsyunWVrFO2FwYTBUU=
Message-ID: <9e473391050822094451d11b58@mail.gmail.com>
Date: Mon, 22 Aug 2005 12:44:01 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Subject: Re: 2.6.13-rc6-mm1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050822143713.GA12947@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_823_2440857.1124729041155"
References: <20050821222229.GC6935@ens-lyon.fr>
	 <9e47339105082115347bde79bb@mail.gmail.com>
	 <20050822143713.GA12947@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_823_2440857.1124729041155
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 8/22/05, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> On Sun, Aug 21, 2005 at 06:34:48PM -0400, Jon Smirl wrote:
> > This should fix it, but I'm not on a machine where I can test it. Can
> > you give it a try and let me know?
> >
>=20
> it works ok.
> But there is still at least one problem: if ops->store returns an error,
> then there will be a substraction and the write will loop (i could do it
> with a store wich returned EINVAL and a 22 length string).
>=20
> I don't know if you can put a '\0' at buffer->page[count] if
> count =3D=3D PAGE_SIZE.
>=20
> Moreover, i think it is more correct to add only the leading
> whitespace from the count because if the ops->store doesn't read
> everything it will do something weird:
>=20
> For example, if we have ' 123    ' and ops->store read only one char,
> then the function will return 7 (1 leading + 4 trailing + 1 read).  For
> the next call the buffer will be filled only by spaces which is
> incorrect (it should be '23    ').

The attached version tries to fix these issues. I am still not
somewhere where I can test, so please check it out.

--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_823_2440857.1124729041155
Content-Type: text/x-diff; name="gregkh-driver-sysfs-strip_leading_trailing_whitespace-3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gregkh-driver-sysfs-strip_leading_trailing_whitespace-3.patch"

ZGlmZiAtLWdpdCBhL2ZzL3N5c2ZzL2ZpbGUuYyBiL2ZzL3N5c2ZzL2ZpbGUuYwotLS0gYS9mcy9z
eXNmcy9maWxlLmMKKysrIGIvZnMvc3lzZnMvZmlsZS5jCkBAIC02LDYgKzYsNyBAQAogI2luY2x1
ZGUgPGxpbnV4L2Zzbm90aWZ5Lmg+CiAjaW5jbHVkZSA8bGludXgva29iamVjdC5oPgogI2luY2x1
ZGUgPGxpbnV4L25hbWVpLmg+CisjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KICNpbmNsdWRlIDxh
c20vdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9zZW1hcGhvcmUuaD4KIApAQCAtMjA3LDggKzIw
OCw0MSBAQCBmbHVzaF93cml0ZV9idWZmZXIoc3RydWN0IGRlbnRyeSAqIGRlbnRyCiAJc3RydWN0
IGF0dHJpYnV0ZSAqIGF0dHIgPSB0b19hdHRyKGRlbnRyeSk7CiAJc3RydWN0IGtvYmplY3QgKiBr
b2JqID0gdG9fa29iaihkZW50cnktPmRfcGFyZW50KTsKIAlzdHJ1Y3Qgc3lzZnNfb3BzICogb3Bz
ID0gYnVmZmVyLT5vcHM7CisJc2l6ZV90IHdzX2NvdW50ID0gY291bnQsIGxlYWRpbmcgPSAwOwor
CWludCByZXQgPSAwOworCWNoYXIgKng7CiAKLQlyZXR1cm4gb3BzLT5zdG9yZShrb2JqLGF0dHIs
YnVmZmVyLT5wYWdlLGNvdW50KTsKKwkvKiBsb2NhdGUgdHJhaWxpbmcgd2hpdGUgc3BhY2UgKi8K
Kwl3aGlsZSAoKHdzX2NvdW50ID4gMCkgJiYgaXNzcGFjZShidWZmZXItPnBhZ2Vbd3NfY291bnQg
LSAxXSkpCisJCXdzX2NvdW50LS07CisJaWYgKHdzX2NvdW50ID09IDApCisJCXJldHVybiBjb3Vu
dDsKKworCS8qIGxvY2F0ZSBsZWFkaW5nIHdoaXRlIHNwYWNlICovCisJeCA9IGJ1ZmZlci0+cGFn
ZTsKKwl3aGlsZSAoaXNzcGFjZSgqeCkpCisJCXgrKzsKKwlsZWFkaW5nID0geCAtIGJ1ZmZlci0+
cGFnZTsKKwl3c19jb3VudCAtPSBsZWFkaW5nOworCisJLyogaW50ZXJmYWNlIGlzIHN0aWxsIGFt
Ymlnb3VzIGFib3V0IHRoaXMgKi8KKwkvKiBzdHJpbmcgaXMgYm90aCBwYXNzZWQgYnkgbGVuZ3Ro
IGFuZCB0ZXJtaW5hdGVkICovCisJaWYgKHdzX2NvdW50ICE9IFBBR0VfU0laRSkKKwkJeFt3c19j
b3VudF0gPSAnXDAnOworCisJcmV0ID0gb3BzLT5zdG9yZShrb2JqLCBhdHRyLCB4LCB3c19jb3Vu
dCk7CisKKwkvKiBpcyBpdCBhbiBlcnJvcj8gKi8KKwlpZiAocmV0IDwgMCkgCisJCXJldHVybiBy
ZXQ7CisKKwkvKiB0aGUgd2hvbGUgc3RyaW5nIHdhcyBjb25zdW1lZCAqLworCWlmIChyZXQgPT0g
d3NfY291bnQpCisJCXJldHVybiBjb3VudDsKKworCS8qIG9ubHkgcGFydCBvZiB0aGUgc3RyaW5n
IHdhcyBjb25zdW1lZCAqLworCS8qIHJldHVybiBjb3VudCBjYW4gbm90IGluY2x1ZGUgdHJhaWxp
bmcgc3BhY2UgKi8KKwlyZXR1cm4gbGVhZGluZyArIHJldDsKIH0KIAogCg==
------=_Part_823_2440857.1124729041155--
