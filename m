Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUIBNiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUIBNiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUIBNiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:38:21 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40334 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268322AbUIBNiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:38:13 -0400
Subject: Proposal: Changing enable_irq/disable_irq to be two argument.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094128566.4966.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 13:36:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been putting together some patches to deal with stuck interrupts
more intelligently. Instead of just deciding an interrupt is stuck the
code tries to respond to stuck interrupts by running every shared IRQ
handler registered. This is generally safe because SHIRQ handlers have
to check if their hardware caused the interrupt anyway. It breaks for
the corner case of disable_irq() on a shared interrupt.

Fixing this needs enable/disable_irq() to take the cookie we passed to
request/free_irq. At that point we can both disable the irq and skip the
handler when doing recovery.

Even without this change the hack test version of the change is working
very well on test hardware that previously never ran Linux properly
because of broken IRQ routing tables. Clearly it needs to be a user
enabled option because it harms performance, we need to trap any bugs we
cause in this area and to continue to provide appropriate pain to
offending hardware vendors.

Alan

