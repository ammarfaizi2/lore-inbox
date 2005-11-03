Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVKCOt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVKCOt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKCOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:49:28 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:58569 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030207AbVKCOt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:49:27 -0500
Date: Thu, 3 Nov 2005 07:49:26 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103144926.GV23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This series of four patches are the first step towards making NO_IRQ a
pervasive concept.  It's bundled up in a git tree for your convenience
(unless I bodged it up, in which case it's your inconvenience).

git://git.kernel.org/pub/scm/linux/kernel/git/willy/misc-2.6.git no_irq

 - Check the irq number is within bounds in the functions which weren't
   already checking.
 - Introduce PCI_NO_IRQ and pci_valid_irq()
   Explicitly initialise pci_dev->irq with PCI_NO_IRQ, allowing us to change
   the value of PCI_NO_IRQ when all drivers have been audited.
 - Use pci_valid_irq() instead of a custom NO_IRQ definition.
   It probably didn't work on half a dozen architectures.
 - Move the definition of NO_IRQ from asm directories to <linux/hardirq.h>.
   Individual architectures can still override it if they want to, but all
   existing definitions were -1.

 drivers/pci/probe.c       |    7 +++++--
 drivers/pcmcia/pd6729.c   |    6 +-----
 include/asm-arm/irq.h     |    8 --------
 include/asm-arm26/irq.h   |    8 --------
 include/asm-frv/irq.h     |    3 ---
 include/asm-parisc/irq.h  |    2 --
 include/asm-powerpc/irq.h |    3 ---
 include/linux/hardirq.h   |   10 ++++++++++
 include/linux/pci.h       |    9 +++++++++
 kernel/irq/manage.c       |   15 +++++++++++++++
 10 files changed, 40 insertions(+), 31 deletions(-)

I'll follow this mail with the patches for other peoples benefits.  They
were previously posted to linux-arch with no responses.
