Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbUDPXhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUDPXhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:37:06 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:18357 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263897AbUDPXfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:35:42 -0400
Date: Fri, 16 Apr 2004 19:35:38 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: rusty@rustcorp.com.au
Subject: [PATCH] Re: module_param() doesn't seem to work in 2.6.6-rc1
In-Reply-To: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>
Message-ID: <Pine.LNX.4.58.0404161911210.8865@marabou.research.att.com>
References: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1444551156-1082158538=:1692"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1444551156-1082158538=:1692
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 16 Apr 2004, Pavel Roskin wrote:

> A bigger problem is that the new parameters cannot be used on the modprobe
> command line.  I added this to orinoco.c:
>
> static int parmtest1, parmtest2;
> MODULE_PARM(parmtest1, "i");
> module_param(parmtest2, int, 644);

P.S. load_module() in kernel/module.c would not check new parameters if
old parameters are present.  In my tests old parameters were always
present.  Once I converted everything, the parameters started working
again.

Parsing both types of parameters may be non-trivial, and should not be
really needed.  However, a warning could have saved me some time.

The attached patch prints a warning if both new-style and obsolete
parameters are present in the module.  The warning is printed regardless
of whether any parameters are specified, which is intentional.

Several drivers under drivers/pcmcia have this problem.  The patch will be
posted to the pcmcia list.

-- 
Regards,
Pavel Roskin
--8323328-1444551156-1082158538=:1692
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="parm_warning.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404161935380.1692@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="parm_warning.diff"

LS0tIGxpbnV4Lm9yaWcva2VybmVsL21vZHVsZS5jDQorKysgbGludXgva2Vy
bmVsL21vZHVsZS5jDQpAQCAtMTU0MSw2ICsxNTQxLDEwIEBAIHN0YXRpYyBz
dHJ1Y3QgbW9kdWxlICpsb2FkX21vZHVsZSh2b2lkIF8NCiAJCQkJICAgICAg
LyBzaXplb2Yoc3RydWN0IG9ic29sZXRlX21vZHBhcm0pLA0KIAkJCQkgICAg
ICBzZWNoZHJzLCBzeW1pbmRleCwNCiAJCQkJICAgICAgKGNoYXIgKilzZWNo
ZHJzW3N0cmluZGV4XS5zaF9hZGRyKTsNCisJCWlmIChzZWNoZHJzW3NldHVw
aW5kZXhdLnNoX3NpemUpDQorCQkJcHJpbnRrKEtFUk5fV0FSTklORyAiJXM6
IElnbm9yaW5nIG5ldy1zdHlsZSAiDQorCQkJICAgICAgICJwYXJhbWV0ZXJz
IGluIHByZXNlbmNlIG9mIG9ic29sZXRlIG9uZXNcbiIsDQorCQkJICAgICAg
IG1vZC0+bmFtZSk7DQogCX0gZWxzZSB7DQogCQkvKiBTaXplIG9mIHNlY3Rp
b24gMCBpcyAwLCBzbyB0aGlzIHdvcmtzIHdlbGwgaWYgbm8gcGFyYW1zICov
DQogCQllcnIgPSBwYXJzZV9hcmdzKG1vZC0+bmFtZSwgbW9kLT5hcmdzLA0K

--8323328-1444551156-1082158538=:1692--
