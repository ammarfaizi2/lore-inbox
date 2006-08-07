Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWHGCya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWHGCya (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWHGCya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:54:30 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:26585 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750931AbWHGCya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:54:30 -0400
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 12:54:27 +1000
Message-Id: <1154919267.21647.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-06 at 18:22 +0100, Hugh Dickins wrote:
> but I wonder how many other early_param
> "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> shows many such, i386 shows only one, I've not followed it up further.

Thanks Hugh.

Andrew, here's that i386 fix:

Subject: Fix acpi_sci early_param

Unlike __setup which just does prefix matching, early_param does actual
command-line parsing (as module_param), so no "=" is needed or desired.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

--- linux-2.6.18-rc3-mm2/arch/i386/kernel/acpi/boot.c.~1~	2006-08-07 12:40:14.000000000 +1000
+++ linux-2.6.18-rc3-mm2/arch/i386/kernel/acpi/boot.c	2006-08-07 12:49:42.000000000 +1000
@@ -1292,4 +1292,4 @@
 		return -EINVAL;
 	return 0;
 }
-early_param("acpi_sci=", setup_acpi_sci);
+early_param("acpi_sci", setup_acpi_sci);

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

