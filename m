Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUEKTsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUEKTsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUEKTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:48:52 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:28878 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263551AbUEKTsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:48:42 -0400
Date: Tue, 11 May 2004 15:48:40 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] PCI debug compile fix in sis_router_probe()
Message-ID: <Pine.LNX.4.58.0405111538500.4292@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-685502234-1084304920=:4292"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-685502234-1084304920=:4292
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

I get a compile error when I define "DEBUG" in arch/i386/pci/pci.h.
Variable rt is not defined in sis_router_probe(), file
arch/i386/pci/irq.c.

Let's see if that debug statement is useful at all.  sis_router_probe() is
used in pirq_routers table.  Other functions used there, such as
via_router_probe(), don't print anything.

pirq_routers is only used in pirq_find_router(), which prints the actually
found router, including its name (such as "SIS"), vendor, device and PCI
name.  There is nothing sis_router_probe() could add to that.

The attached patch removes the unnecessary and wrong debug print in
sis_router_probe().  The patch is against Linux 2.6.6.

-- 
Regards,
Pavel Roskin
--8323328-685502234-1084304920=:4292
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pci_debug_sis.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0405111548400.4292@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="pci_debug_sis.diff"

LS0tIGFyY2gvaTM4Ni9wY2kvaXJxLmMNCisrKyBhcmNoL2kzODYvcGNpL2ly
cS5jDQpAQCAtNTQwLDggKzU0MCw2IEBAIHN0YXRpYyBfX2luaXQgaW50IHNp
c19yb3V0ZXJfcHJvYmUoc3RydWMNCiAJci0+bmFtZSA9ICJTSVMiOw0KIAly
LT5nZXQgPSBwaXJxX3Npc19nZXQ7DQogCXItPnNldCA9IHBpcnFfc2lzX3Nl
dDsNCi0JREJHKCJQQ0k6IERldGVjdGluZyBTaVMgcm91dGVyIGF0ICUwMng6
JTAyeFxuIiwNCi0JICAgIHJ0LT5ydHJfYnVzLCBydC0+cnRyX2RldmZuKTsN
CiAJcmV0dXJuIDE7DQogfQ0KIA0K

--8323328-685502234-1084304920=:4292--
