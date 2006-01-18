Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWARKkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWARKkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWARKkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:40:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15841 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932440AbWARKkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:40:31 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>
Message-Id: <20060118024106.10241.69438.sendpatchset@linux.site>
Subject: [patch 0/4] mm: de-skew page refcount
Date: Wed, 18 Jan 2006 11:40:25 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset (against 2.6.16-rc1 + migrate race fixes) uses the new
atomic ops to do away with the offset page refcounting, and simplify the race
that it was designed to cover.

This allows some nice optimisations, and in the page freeing path we end up
saving 2 atomic ops including a spin_lock_irqsave in the !PageLRU case, and 1
or 2 atomic ops in the PageLRU case.

Andrew's previous feedback has been incorporated (less BUG_ONs in fastpaths
and more detail in changelogs).

Anyone spot any holes or races?

Thanks,
Nick
