Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWDXSlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWDXSlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWDXSlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:41:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751109AbWDXSlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:41:06 -0400
Date: Mon, 24 Apr 2006 11:41:05 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: better leve triggered IRQ management needed
Message-ID: <20060424114105.113eecac@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing repeated problems with misconfigured systems that have shared IRQ
devices configured for edge-triggered. Also, network devices using NAPI won't
work reliably on edge-triggered IRQ's.  The kernel IRQ architecture doesn't
have sufficient information to detect this at boot time.  
We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.

Right now the concept of level vs edge triggered is buried in things like ELCR for old
PIC, and other stuff for IO-APIC.  There is a IRQ_LEVEL flag in the descriptor field
but nothing sets it or uses it.

Haven't even looked at non i386 arch's but probably even more confusion there.

