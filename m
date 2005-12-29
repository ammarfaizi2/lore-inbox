Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVL2LEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVL2LEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVL2LEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:04:14 -0500
Received: from iona.labri.fr ([147.210.8.143]:57218 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932585AbVL2LEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:04:12 -0500
Message-ID: <43B3C2C3.1070201@labri.fr>
Date: Thu, 29 Dec 2005 12:04:35 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.14.5] iounmap: bad address
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running a 2.6.14.5 on a Transmeta Crusoe laptop (Vaio PCG-C1MZ) and
I'm having some troubles with the iounmap function. Each time I'm
shutting down the machine or even just stopping the gdm daemon, I got
the following error log:

iounmap: bad address d7233000
 [iounmap+197/208] iounmap+0xc5/0xd0
 [page_remove_rmap+59/96] page_remove_rmap+0x3b/0x60
 [radeon_do_cleanup_cp+856/1056] radeon_do_cleanup_cp+0x358/0x420
 [radeon_do_release+165/288] radeon_do_release+0xa5/0x120
 [drm_takedown+43/960] drm_takedown+0x2b/0x3c0
 [drm_release+1010/1232] drm_release+0x3f2/0x4d0
 [__handle_mm_fault+447/464] __handle_mm_fault+0x1bf/0x1d0
 [__fput+176/400] __fput+0xb0/0x190
 [filp_close+82/144] filp_close+0x52/0x90
 [sys_close+124/128] sys_close+0x7c/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb

I guess the problem is located in arch/i386/mm/ioremap.c where:

write_lock(&vmlist_lock);
p = __remove_vm_area((void *)(PAGE_MASK & (unsigned long __force)addr));
if (!p) {
         printk(KERN_WARNING "iounmap: bad address %p\n", addr);
         dump_stack();
         goto out_unlock;
}

So, it seems that remove_vm_area is returning NULL, and I don't know
why... :-/

Can somebody help me out ?

Regards
-- 
Emmanuel Fleury

The highest goal of computer science is to automate that
which can be automated.
  -- D. L. VerLee
