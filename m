Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWHJQEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWHJQEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbWHJQEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:04:10 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:13785 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161359AbWHJQEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:04:08 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 0/14] Generic ioremap_page_range: introduction
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:32 +0200
Message-Id: <1155225826761-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

If this is acked by the relevant people, could you give it a spin
in -mm?

This is a resend of the generic ioremap_page_range() patchset with
one minor change noted below. As Andi Kleen pointed out, I should
send the patches directly to the arch maintainers, so I'm Cc'ing them
this time around. Hopefully at least -- I'm not 100% confident with
git-send-email yet, but I'm getting there :)

Some patches have already been acked, but I'm cc'ing the maintainer
anyway.

I've reverted the "implementation" patch to use the same
flush_cache_all()/flush_tlb_all() scheme used by i386 and most other
architectures and added a second patch that converts them to
flush_cache_vmap(). This way, if things fall apart during testing,
there's only a single patch to revert.

In addition to the generic ioremap_page_range() implementation, this
updates all architectures that were relatively trivial to convert.
Most of remaining architectures implement ioremap() as a no-op or
something close. Exceptions are m68k, powerpc and sparc.

m68k has some CPU-dependent logic in the middle of the loop.

powerpc could probably use generic ioremap_page_range(), but doing so
would probably increase the code size, as the map_page() functions
have other users in addition to ioremap().

sparc maps in huge pages when possible. Better not touch it.

Oh, and I'm going to Taiwan next week, so I may be slow to respond.

Haavard
