Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUFAQqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUFAQqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUFAQqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:46:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35335 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265027AbUFAQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:46:28 -0400
Date: Tue, 1 Jun 2004 17:46:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.6.7-rc2: mpage_writepage
Message-ID: <20040601174625.B31301@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040601150025.A31301@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040601150025.A31301@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jun 01, 2004 at 03:00:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 03:00:25PM +0100, Russell King wrote:
> I've been trying to look at a cache problem on ARM PXA, but unfortunately
> hit the following problem:
> 
> Opening 'l/testfile'
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> PC is at 0x0
> LR is at mpage_writepage+0x1fc/0x5e0

Ok, I intend to work around this bug by the following:

--- orig/fs/mpage.c	Thu Apr 22 15:28:27 2004
+++ linux/fs/mpage.c	Tue Jun  1 17:44:11 2004
@@ -619,7 +619,7 @@
 	writepage = NULL;
 	if (get_block == NULL)
 		writepage = mapping->a_ops->writepage;
-
+if (!get_block && !writepage) return 0; /* save us from ramfs */
 	pagevec_init(&pvec, 0);
 	if (wbc->sync_mode == WB_SYNC_NONE) {
 		index = mapping->writeback_index; /* Start from prev offset */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
