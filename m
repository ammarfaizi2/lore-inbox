Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUFUEDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUFUEDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 00:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFUEDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 00:03:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:13457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265282AbUFUEDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 00:03:48 -0400
Date: Sun, 20 Jun 2004 21:02:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
Message-Id: <20040620210233.1e126ddc.akpm@osdl.org>
In-Reply-To: <40D657B7.8040807@pobox.com>
References: <40D64DF7.5040601@pobox.com>
	<40D657B7.8040807@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Jeff Garzik wrote:
> > 
> > Something is definitely screwy with the latest -bk.  I updated from a 
> > kernel ~1 week ago, and all timer-related stuff is moving at a vastly 
> > increased rate.  My guess is twice as fast.  Most annoying is the system 
> > clock advances at twice normal rate, and keyboard repeat is so sensitive 
> > I am spending quite a bit of time typing this message, what with having 
> > to delettte (<== example) extra characters.  Double-clicking is also 
> > broken :(
> 
> Looks like disabling CONFIG_ACPI fixes things.  Narrowing down cset now...
> 

Try this.


--- 25/arch/i386/kernel/mpparse.c~i386-double-clock-speed-fix	2004-06-20 18:04:47.409952912 -0700
+++ 25-akpm/arch/i386/kernel/mpparse.c	2004-06-20 18:05:13.034057456 -0700
@@ -1017,7 +1017,8 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
+				(mp_irqs[idx].mpc_dstapic ==
+					mp_ioapics[ioapic].mpc_apicid) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
_

