Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVAFRSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVAFRSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVAFRSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:18:11 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:29734 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262918AbVAFRRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:17:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=FQxG57QGBfNKvgeqfTMbKO5steS+TDybDVliej8cEeOdBj7inx9/ldWMmoaM1wl1ctbgLVEp4v3HKt+BJhdG6MNbkh3XUS9WpaXxoMbhmCaYBdP5PalzoO00g87i+gxmeGLTCFBZYz0Svlw7o9wX0qOYDW0n9AOsMvkgGRNST1A=
Message-ID: <9e47339105010609175dabc381@mail.gmail.com>
Date: Thu, 6 Jan 2005 12:17:33 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: chasing the four level page table
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM driver contains this routine:

drivers/char/drm/drm_memory.h

static inline unsigned long
drm_follow_page (void *vaddr)
{
	pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
	pud_t *pud = pud_offset(pgd, (unsigned long) vaddr);
	pmd_t *pmd = pmd_offset(pud, (unsigned long) vaddr);
	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
	return pte_pfn(*ptep) << PAGE_SHIFT;
}

No other driver needs to chase the page table like this so there is
probably some other way to achieve this. Can someone who knows more
about the VM system tell me if there is a way to eliminate this code?

If there are any VM/AGP experts with some free time, drm_memory.h
could use some rewriting to make it pass sparse checks.

-- 
Jon Smirl
jonsmirl@gmail.com
