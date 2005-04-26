Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVDZQTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVDZQTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVDZQSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:18:04 -0400
Received: from open.hands.com ([195.224.53.39]:21155 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261666AbVDZQPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:15:50 -0400
Date: Tue, 26 Apr 2005 17:24:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [2.6.7.11, BUG] spin_lock_irqsave() unsafe for use with FIQ and no spin_lock_localsave() exists
Message-ID: <20050426162448.GD8817@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

like the subject says.

i utilised spin_lock_irqsave() with a FIQ handler, expecting to be able
to do this:

	spin_lock_irqsave(...)
	local_fiq_disable()
	spin_lock_restoreflags(...)

aaaannnd it caused some weirdo behaviour - not surprisingly because
spin_lock_irqsave() calls local_irq_save() which ONLY saves the
interrupt handler flags - NOT the FIQ handler flags.

a spin_lock_saveflags() which does exactly what spin_lock_irqsave() does
except it calls local_irq_save would be _greatly_ appreciated.

in linux/spinlock.h.

because i'm having to #define one anyway.

tia.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
