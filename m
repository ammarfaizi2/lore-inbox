Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWBUPh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWBUPh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWBUPh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:37:27 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:34700 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932536AbWBUPh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:37:26 -0500
Message-ID: <43FB33C0.2090004@keyaccess.nl>
Date: Tue, 21 Feb 2006 16:37:36 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adam Belay <abelay@MIT.EDU>
CC: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp	cards)
 broken in 2.6.16-rc4
References: <43F9F9F2.4070203@keyaccess.nl> <1140499646.21116.30.camel@localhost.localdomain>
In-Reply-To: <1140499646.21116.30.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------030103000103000007020709"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030103000103000007020709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Adam Belay wrote:

[ pnp_card_driver.remove() not called ]

> Hopefully this email account will work better.  In any case, thanks
> for bringing this bug to my attention.  I may have stumbled across it
> a couple days ago, and would appreciate if you would try this patch: 
> (there may be some fuzz)

Reject even. I've attached this patch regenerated against 2.6.16-rc4.

> -       if (drv->link.driver.probe) {
> -               if (drv->link.driver.probe(&dev->dev)) {

> +       if (pnp_bus_type.probe(&dev->dev)) {

Yes, this works, thanks. If it's also the correct fix, I guess this 
should go into 2.6.16?

I by the way also tested with a driver that uses pnp_driver instead of 
pnp_card_driver, and that also works.

> It's possible that the attach mechanism isn't working correctly
> because of recent driver model changes.  If this is the case, it
> would also explain the detach-not-called issues.

The bustype stuff...

Rene.


--------------030103000103000007020709
Content-Type: text/plain;
 name="pnp_bus_type_adam.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pnp_bus_type_adam.diff"

SW5kZXg6IGxvY2FsL2RyaXZlcnMvcG5wL2NhcmQuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsb2Nh
bC5vcmlnL2RyaXZlcnMvcG5wL2NhcmQuYwkyMDA2LTAyLTExIDAwOjM0OjAxLjAwMDAwMDAw
MCArMDEwMAorKysgbG9jYWwvZHJpdmVycy9wbnAvY2FyZC5jCTIwMDYtMDItMjEgMTQ6MDY6
MjEuMDAwMDAwMDAwICswMTAwCkBAIC0zMDMsMTMgKzMwMywxMSBAQCBmb3VuZDoKIAlkb3du
X3dyaXRlKCZkZXYtPmRldi5idXMtPnN1YnN5cy5yd3NlbSk7CiAJZGV2LT5jYXJkX2xpbmsg
PSBjbGluazsKIAlkZXYtPmRldi5kcml2ZXIgPSAmZHJ2LT5saW5rLmRyaXZlcjsKLQlpZiAo
ZHJ2LT5saW5rLmRyaXZlci5wcm9iZSkgewotCQlpZiAoZHJ2LT5saW5rLmRyaXZlci5wcm9i
ZSgmZGV2LT5kZXYpKSB7Ci0JCQlkZXYtPmRldi5kcml2ZXIgPSBOVUxMOwotCQkJZGV2LT5j
YXJkX2xpbmsgPSBOVUxMOwotCQkJdXBfd3JpdGUoJmRldi0+ZGV2LmJ1cy0+c3Vic3lzLnJ3
c2VtKTsKLQkJCXJldHVybiBOVUxMOwotCQl9CisJaWYgKHBucF9idXNfdHlwZS5wcm9iZSgm
ZGV2LT5kZXYpKSB7CisJCWRldi0+ZGV2LmRyaXZlciA9IE5VTEw7CisJCWRldi0+Y2FyZF9s
aW5rID0gTlVMTDsKKwkJdXBfd3JpdGUoJmRldi0+ZGV2LmJ1cy0+c3Vic3lzLnJ3c2VtKTsK
KwkJcmV0dXJuIE5VTEw7CiAJfQogCWRldmljZV9iaW5kX2RyaXZlcigmZGV2LT5kZXYpOwog
CXVwX3dyaXRlKCZkZXYtPmRldi5idXMtPnN1YnN5cy5yd3NlbSk7Cg==
--------------030103000103000007020709--
