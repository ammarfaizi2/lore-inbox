Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSJZHzY>; Sat, 26 Oct 2002 03:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261945AbSJZHzY>; Sat, 26 Oct 2002 03:55:24 -0400
Received: from sc-66-75-112-104.socal.rr.com ([66.75.112.104]:18438 "EHLO
	home.blackbean.org") by vger.kernel.org with ESMTP
	id <S261934AbSJZHzX>; Sat, 26 Oct 2002 03:55:23 -0400
Date: Sat, 26 Oct 2002 01:04:47 -0700
From: Jim Radford <radford@blackbean.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI should use bios if direct is not detected
Message-ID: <20021026010447.A5468@home.socal.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.10 the pci subsystem stopped using the bios to access the PCI
config space when no direct method is detected even though it does
detect that it *can* use the bios leaving my machine PCI-less :-(.
This patch restores the older saner behavior and shouldn't affect any
working system.

-Jim

diff -Nru linux-2.5.44/arch/i386/pci/direct.c linux-2.5.44-bios/arch/i386/pci/direct.c
--- linux-2.5.44/arch/i386/pci/direct.c    Sat Oct 26 00:39:23 2002
+++ linux-2.5.44-bios/arch/i386/pci/direct.c    Sat Oct 26 00:39:23 2002
@@ -261,7 +261,6 @@
        }

        local_irq_restore(flags);
-       pci_root_ops = NULL;
        return 0;
 }

