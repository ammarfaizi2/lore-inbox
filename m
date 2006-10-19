Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423327AbWJSMUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423327AbWJSMUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423325AbWJSMUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:20:16 -0400
Received: from natblert.rzone.de ([81.169.145.181]:65000 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1423324AbWJSMUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:20:14 -0400
Date: Thu, 19 Oct 2006 14:18:36 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: revert mv643xx change from ubuntu tree
Message-ID: <20061019121836.GA26319@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Somehow the Ubuntu guys managed to sneak this compile error into the
tree:

commit ce9e3d9953c8cb67001719b5516da2928e956be4

      [mv643xx] Add pci device table for auto module loading.

drivers/net/mv643xx_eth.c:1560: error: array type has incomplete element type
drivers/net/mv643xx_eth.c:1561: warning: implicit declaration of function ‘PCI_DEVICE’
drivers/net/mv643xx_eth.c:1561: error: ‘PCI_VENDOR_ID_MARVELL’ undeclared here (not in a function)
drivers/net/mv643xx_eth.c:1561: error: ‘PCI_DEVICE_ID_MARVELL_MV64360’ undeclared here (not in a function)


This change is also wrong, the autoloading works perfect with 2.6.18,
no need to add random PCI ids.

http://ozlabs.org/pipermail/linuxppc-dev/2006-October/026544.html

Please revert this change and route changes via jgarzik etc...
