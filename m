Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTFYKel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTFYKeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:34:24 -0400
Received: from b107155.adsl.hansenet.de ([62.109.107.155]:37822 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264432AbTFYKZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:25:07 -0400
Message-ID: <3EF97B98.7020407@portrix.net>
Date: Wed, 25 Jun 2003 12:38:16 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net, psavo@iki.fi
Subject: [PATCH] export flush_tlb_all for drm modules
Content-Type: multipart/mixed;
 boundary="------------000600010202090302040102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600010202090302040102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This adds an export for flush_tlb_all to i386_ksyms.c. The drm modules
miss this, when compiling for SMP.
Original fix from Pasi Savolainen, but for some reason this was not
included until now (2.5.73-mm1).
His comment:
  > drivers/char/drm/drm_memory.h needs this to compile as module (at
  > least)on SMP, where flush_tlb_all() isn't a inline macro.

Rediffed against 2.5.73-mm1. Tested loading of the module on UP/k7 with 
SMP config. I only have a R300 board, so I can't really test the driver.
I think the other drm modules should also be loadable again with this patch.

Thanks,

Jan



--------------000600010202090302040102
Content-Type: text/plain;
 name="export_flush_tlb_all"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_flush_tlb_all"

--- linux-mm/arch/i386/kernel/i386_ksyms.c	2003-05-31 14:14:59.000000000 +0200
+++ 2.5.73-mm1/arch/i386/kernel/i386_ksyms.c	2003-06-25 09:34:57.000000000 +0200
@@ -159,6 +159,7 @@
 
 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
+EXPORT_SYMBOL(flush_tlb_all);
 #endif
 
 #ifdef CONFIG_X86_IO_APIC


--------------000600010202090302040102--

