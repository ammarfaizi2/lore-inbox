Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVHBXKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVHBXKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVHBXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 19:10:23 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:24045 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261918AbVHBXJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 19:09:35 -0400
Date: Wed, 3 Aug 2005 03:09:03 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Erik Waling <erikw@acc.umu.se>,
       acpi-devel@lists.sourceforge.net
Subject: [patch 2/2] ACPI: increase PCIBIOS_MIN_IO on x86
Message-ID: <20050803030903.E18001@jurassic.park.msu.ru>
References: <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru> <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org> <20050803011337.A18001@jurassic.park.msu.ru> <20050802212143.GA8738@kroah.com> <20050803014757.B18001@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021456070.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0508021456070.3341@g5.osdl.org>; from torvalds@osdl.org on Tue, Aug 02, 2005 at 02:57:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have increased PCIBIOS_MIN_IO to 0x4000, but still want
motherboard resources to be allocated properly. So we need
to state 0x1000 (according to the comment) limit explicitely.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

--- 2.5.13-rc5/drivers/acpi/motherboard.c	Fri Jun 17 23:48:29 2005
+++ linux/drivers/acpi/motherboard.c	Wed Aug  3 02:54:05 2005
@@ -43,7 +43,7 @@ ACPI_MODULE_NAME		("acpi_motherboard")
  */
 #define IS_RESERVED_ADDR(base, len) \
 	(((len) > 0) && ((base) > 0) && ((base) + (len) < IO_SPACE_LIMIT) \
-	&& ((base) + (len) > PCIBIOS_MIN_IO))
+	&& ((base) + (len) > 0x1000))
 
 /*
  * Clearing the flag (IORESOURCE_BUSY) allows drivers to use
