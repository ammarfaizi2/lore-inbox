Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbUCYRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbUCYRrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:47:15 -0500
Received: from colino.net ([62.212.100.143]:12272 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S263507AbUCYRrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:47:07 -0500
Date: Thu, 25 Mar 2004 18:46:20 +0100
From: Colin Leroy <colin@colino.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sf.net>
Subject: [PATCH] Re: [linux-usb-devel] Re: [OOPS] reproducible oops with
 2.6.5-rc2-bk3
Message-Id: <20040325184620.3b6b070c@jack.colino.net>
In-Reply-To: <Pine.LNX.4.44L0.0403251153110.1083-100000@ida.rowland.org>
References: <13c901c41287$d29bb040$3cc8a8c0@epro.dom>
	<Pine.LNX.4.44L0.0403251153110.1083-100000@ida.rowland.org>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__25_Mar_2004_18_46_20_+0100_e+ldxy0l7YsI6t.p"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__25_Mar_2004_18_46_20_+0100_e+ldxy0l7YsI6t.p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 25 Mar 2004 at 11h03, Alan Stern wrote:

Hi, 

Found out !
cdc-acm wants both interfaces to be ready (cur_altsetting initialized) when acm_probe() is called. Hence, we have to make two parts out of the loop in message.c::usb_set_configuration(): one to init things, one to register them. 

The attached patch does that. It fixes the oops, and doesn't break any of my USB peripheral (printer, scanner, mouse, and diskonkey).

I hope it's fine enough to go in :)
-- 
Colin

--Multipart=_Thu__25_Mar_2004_18_46_20_+0100_e+ldxy0l7YsI6t.p
Content-Type: application/octet-stream;
 name="cdc-acm.oops.patch"
Content-Disposition: attachment;
 filename="cdc-acm.oops.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvdXNiL2NvcmUvbWVzc2FnZS5jLm9yaWcJMjAwNC0wMy0yNSAxODozNDowNC4w
MDAwMDAwMDAgKzAxMDAKKysrIGRyaXZlcnMvdXNiL2NvcmUvbWVzc2FnZS5jCTIwMDQtMDMtMjUg
MTg6NDI6NDEuMjY3Njk3MjI0ICswMTAwCkBAIC0xMTc4LDEwICsxMTc4LDE3IEBACiAJCQkJIGRl
di0+YnVzLT5idXNudW0sIGRldi0+ZGV2cGF0aCwKIAkJCQkgY29uZmlndXJhdGlvbiwKIAkJCQkg
YWx0LT5kZXNjLmJJbnRlcmZhY2VOdW1iZXIpOworCQl9CisJCQorCQkvKiBhbGwgaW50ZXJmYWNl
cyBhcmUgaW5pdGlhbGl6ZWQsIHdlIGNhbiBub3cgCisJCSAqIHJlZ2lzdGVyIHRoZW0KKwkJICov
CisJCWZvciAoaSA9IDA7IGkgPCBjcC0+ZGVzYy5iTnVtSW50ZXJmYWNlczsgKytpKSB7CisJCQlz
dHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZiA9IGNwLT5pbnRlcmZhY2VbaV07CiAJCQlkZXZfZGJn
ICgmZGV2LT5kZXYsCiAJCQkJInJlZ2lzdGVyaW5nICVzIChjb25maWcgIyVkLCBpbnRlcmZhY2Ug
JWQpXG4iLAogCQkJCWludGYtPmRldi5idXNfaWQsIGNvbmZpZ3VyYXRpb24sCi0JCQkJYWx0LT5k
ZXNjLmJJbnRlcmZhY2VOdW1iZXIpOworCQkJCWludGYtPmN1cl9hbHRzZXR0aW5nLT5kZXNjLmJJ
bnRlcmZhY2VOdW1iZXIpOwogCQkJZGV2aWNlX3JlZ2lzdGVyICgmaW50Zi0+ZGV2KTsKIAkJCXVz
Yl9jcmVhdGVfZHJpdmVyZnNfaW50Zl9maWxlcyAoaW50Zik7CiAJCX0K

--Multipart=_Thu__25_Mar_2004_18_46_20_+0100_e+ldxy0l7YsI6t.p--
