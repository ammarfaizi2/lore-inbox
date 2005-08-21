Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVHUWfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVHUWfB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVHUWfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:35:01 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:51951 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbVHUWfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:35:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=NxKubyLV1MqAC00Af62xRyRBD2psw30HB+akDcIE5odVJmqltM5LZDiS2+kaw8YEVxeLpH2addbshf8QUoiui3O5/6PrR9cxnSB38+pbKFF3axqPHiLzQlqTO+29+N5syDqHTbFkkxEfJTZ6229sogJFzCCwIjTMMXhlkIFx24k=
Message-ID: <9e47339105082115347bde79bb@mail.gmail.com>
Date: Sun, 21 Aug 2005 18:34:48 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Subject: Re: 2.6.13-rc6-mm1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050821222229.GC6935@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8362_1537151.1124663688891"
References: <20050821222229.GC6935@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_8362_1537151.1124663688891
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This should fix it, but I'm not on a machine where I can test it. Can
you give it a try and let me know?

On 8/21/05, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> ----- Forwarded message from Benoit Boissinot <benoit.boissinot@ens-lyon.=
org> -----
> sorry, i forgot to reply all...
>=20
> From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
> To: Jon Smirl <jonsmirl@gmail.com>
> Subject: Re: 2.6.13-rc6-mm1
> User-Agent: Mutt/1.5.10i
>=20
> On Sun, Aug 21, 2005 at 06:11:57PM -0400, Jon Smirl wrote:
> > On 8/21/05, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> > > On Sun, Aug 21, 2005 at 01:40:31PM -0400, Jon Smirl wrote:
> > > > On 8/21/05, Benoit Boissinot <bboissin@gmail.com> wrote:
> > > > [snip]
> > > >
> > > > Somewhere there is a mistake in the white space processing code of =
the
> > > > firmware driver. Before this patch we had inconsistent handling of
> > > > whitespace and sysfs attributes. This patch forces it to be consist=
ent
> > > > and will shake out all of the places in the drivers where it is
> > > > handled wrong. Sysfs attributes are now stripped of leading and
> > > > trailing white space before being handed to the device driver.
> > >
> > > ok, i found it. If i do echo 1, it will read '1\n', will
> > > remove the '\n' and send '1' to ops->store.
> > > Then it will re-read '\n' and send '' to ops->store.
> > > And it will loop...
> >
> > Look at the length being passed in, isn't it set to zero for the second=
 case?
> >
> yes, it is set to zero, but the '\n' will be stripped and stay in the buf=
fer.
> Since flush_write_buffer returns 0, ppos will not be incremented and we
> have an endless loop.
>=20
> --
> powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
>=20
> ----- End forwarded message -----
>=20
> --
> powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_8362_1537151.1124663688891
Content-Type: text/x-diff; name="gregkh-driver-sysfs-strip_leading_trailing_whitespace-2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gregkh-driver-sysfs-strip_leading_trailing_whitespace-2.patch"

ZGlmZiAtLWdpdCBhL2ZzL3N5c2ZzL2ZpbGUuYyBiL2ZzL3N5c2ZzL2ZpbGUuYwotLS0gYS9mcy9z
eXNmcy9maWxlLmMKKysrIGIvZnMvc3lzZnMvZmlsZS5jCkBAIC02LDYgKzYsNyBAQAogI2luY2x1
ZGUgPGxpbnV4L2Zzbm90aWZ5Lmg+CiAjaW5jbHVkZSA8bGludXgva29iamVjdC5oPgogI2luY2x1
ZGUgPGxpbnV4L25hbWVpLmg+CisjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KICNpbmNsdWRlIDxh
c20vdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9zZW1hcGhvcmUuaD4KIApAQCAtMjA3LDggKzIw
OCwyOCBAQCBmbHVzaF93cml0ZV9idWZmZXIoc3RydWN0IGRlbnRyeSAqIGRlbnRyCiAJc3RydWN0
IGF0dHJpYnV0ZSAqIGF0dHIgPSB0b19hdHRyKGRlbnRyeSk7CiAJc3RydWN0IGtvYmplY3QgKiBr
b2JqID0gdG9fa29iaihkZW50cnktPmRfcGFyZW50KTsKIAlzdHJ1Y3Qgc3lzZnNfb3BzICogb3Bz
ID0gYnVmZmVyLT5vcHM7CisJaW50IHdzX2NvdW50ID0gY291bnQ7CisJY2hhciAqeDsKIAotCXJl
dHVybiBvcHMtPnN0b3JlKGtvYmosYXR0cixidWZmZXItPnBhZ2UsY291bnQpOworCS8qIGxvY2F0
ZSB0cmFpbGluZyB3aGl0ZSBzcGFjZSAqLworCXdoaWxlICgoY291bnQgPiAwKSAmJiBpc3NwYWNl
KGJ1ZmZlci0+cGFnZVtjb3VudCAtIDFdKSkKKwkJY291bnQtLTsKKworCS8qIGxvY2F0ZSBsZWFk
aW5nIHdoaXRlIHNwYWNlICovCisJeCA9IGJ1ZmZlci0+cGFnZTsKKwlpZiAoY291bnQgPiAwKSB7
CisJCXdoaWxlIChpc3NwYWNlKCp4KSkKKwkJCXgrKzsKKwkJY291bnQgLT0gKHggLSBidWZmZXIt
PnBhZ2UpOworCX0KKwkvKiB0ZXJtaW5hdGUgdGhlIHN0cmluZyAqLworCXhbY291bnRdID0gJ1ww
JzsKKwl3c19jb3VudCAtPSBjb3VudDsKKworCWlmIChjb3VudCAhPSAwKQorCQljb3VudCA9IG9w
cy0+c3RvcmUoa29iaiwgYXR0ciwgeCwgY291bnQpOworCisJcmV0dXJuIGNvdW50ICsgd3NfY291
bnQ7CiB9CiAKIAo=
------=_Part_8362_1537151.1124663688891--
