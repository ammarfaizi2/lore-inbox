Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUEMIvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUEMIvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbUEMIvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:51:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32774 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263881AbUEMIvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:51:05 -0400
Date: Thu, 13 May 2004 09:51:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: namespace pollution
Message-ID: <20040513095102.A5502@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the threads on lkml just highlighted this issue:

It appears that we have namespace issues.  "set_cr" is in use by both ARM
and ATM.  I'll cook up a patch later today (if I remember.)

$ grep set_cr drivers/atm include/asm-arm -r
drivers/atm/horizon.c:  int set_cr (void) {
drivers/atm/horizon.c:      PRINTD (DBG_QOS, "set_cr internal failure: d=%u p=%u",
drivers/atm/horizon.c:    return set_cr ();
drivers/atm/horizon.c:      return set_cr ();
drivers/atm/horizon.c:  return set_cr ();
include/asm-arm/system.h:#define set_cr(x) \

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
