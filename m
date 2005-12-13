Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVLMI1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVLMI1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVLMIZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:62851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932557AbVLMIY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:58 -0500
Date: Tue, 13 Dec 2005 00:22:11 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       bunk@stusta.de, Markus.Lidel@shadowconnect.com
Subject: [patch 02/26] drivers/message/i2o/pci.c: fix a use-after-free
Message-ID: <20051213082211.GC5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="message-i2o-pci-fix-null-pointer-deref.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Adrian Bunk <bunk@stusta.de>

The Coverity checker spotted this obvious use-after-free

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/message/i2o/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.3.orig/drivers/message/i2o/pci.c
+++ linux-2.6.14.3/drivers/message/i2o/pci.c
@@ -421,8 +421,8 @@ static int __devinit i2o_pci_probe(struc
 	i2o_pci_free(c);
 
       free_controller:
-	i2o_iop_free(c);
 	put_device(c->device.parent);
+	i2o_iop_free(c);
 
       disable:
 	pci_disable_device(pdev);

--
