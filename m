Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTEOT1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTEOT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:27:15 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:58325 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264201AbTEOT1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:27:05 -0400
Date: Thu, 15 May 2003 15:39:55 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5->2.4 backport: PCMCIA crashes without CONFIG_ISA
Message-ID: <Pine.LNX.4.55.0305151523570.2679@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1370439195-1053026735=:2679"
Content-ID: <Pine.LNX.4.55.0305151525380.2679@marabou.research.att.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1370439195-1053026735=:2679
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.55.0305151525381.2679@marabou.research.att.com>

Hello!

My patch to fix a crash in validate_mem() (drivers/pcmcia/rsrc_mgr.c)
without CONFIG_ISA defined
(http://lists.infradead.org/pipermail/linux-pcmcia/2003-April/000039.html)
has been in the 2.5 kernels for some time, and it turns out that it needs
to be applied to 2.4.x kernels as well.

The patch against 2.4.21-rc2-ac2 is attached.

validate_mem() traverses memory regions and calls do_mem_probe() on them.
do_mem_probe() can free the current region.  That's why the pointer to the
next region should be preserved before do_mem_probe() is called.

There are two versions of validate_mem().  The one used when CONFIG_ISA is
defined does the right thing.  However, this fix has not been propagated
to the simplified version of validate_mem(), which is used without
CONFIG_ISA defined.

The backport has been published in the PCMCIA mailing list:
http://lists.infradead.org/pipermail/linux-pcmcia/2003-May/000068.html

-- 
Regards,
Pavel Roskin
--8323328-1370439195-1053026735=:2679
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="pcmcia_no_isa.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0305151525350.2679@marabou.research.att.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="pcmcia_no_isa.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9wY21jaWEvcnNyY19tZ3IuYw0KKysr
IGxpbnV4L2RyaXZlcnMvcGNtY2lhL3JzcmNfbWdyLmMNCkBAIC00MTksMTQg
KzQxOSwxNyBAQCB2b2lkIHZhbGlkYXRlX21lbShpbnQgKCppc192YWxpZCko
dV9sb25nDQogdm9pZCB2YWxpZGF0ZV9tZW0oaW50ICgqaXNfdmFsaWQpKHVf
bG9uZyksIGludCAoKmRvX2Nrc3VtKSh1X2xvbmcpLA0KIAkJICBpbnQgZm9y
Y2VfbG93LCBzb2NrZXRfaW5mb190ICpzKQ0KIHsNCi0gICAgcmVzb3VyY2Vf
bWFwX3QgKm07DQorICAgIHJlc291cmNlX21hcF90ICptLCAqbjsNCiAgICAg
c3RhdGljIGludCBkb25lID0gMDsNCiAgICAgDQogICAgIGlmICghcHJvYmVf
bWVtIHx8IGRvbmUrKykNCiAJcmV0dXJuOw0KLSAgICBmb3IgKG0gPSBtZW1f
ZGIubmV4dDsgbSAhPSAmbWVtX2RiOyBtID0gbS0+bmV4dCkNCisNCisgICAg
Zm9yIChtID0gbWVtX2RiLm5leHQ7IG0gIT0gJm1lbV9kYjsgbSA9IG4pIHsN
CisJbiA9IG0tPm5leHQ7DQogCWlmIChkb19tZW1fcHJvYmUobS0+YmFzZSwg
bS0+bnVtLCBpc192YWxpZCwgZG9fY2tzdW0sIHMpKQ0KIAkgICAgcmV0dXJu
Ow0KKyAgICB9DQogfQ0KIA0KICNlbmRpZiAvKiBDT05GSUdfSVNBICovDQo=

--8323328-1370439195-1053026735=:2679--
