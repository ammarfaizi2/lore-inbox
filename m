Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933053AbWKNAWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053AbWKNAWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933240AbWKNAW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:22:29 -0500
Received: from ns1.suse.de ([195.135.220.2]:30105 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933053AbWKNAW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:22:29 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 14 Nov 2006 11:22:23 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 4] md: Various fixes for new cache-bypassing-reads in raid5/6
Message-ID: <20061114111600.31061.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches which enable reading from raid5 without going through the
stripe cache have a bug which causes corruption when reading from a
raid6.
It might be appropriate to put out a hotfix for rc5-mm1 which reverts

   md-enable-bypassing-cache-for-reads.patch

The follow 4 patches fix this bug and a few other bugs I found while
re-reviewing and re-testing this code.  There are actually about 9
separate bugs here, but I grouped some of them to avoid having lots
of tiny patches.

NeilBrown



 [PATCH 001 of 4] md: Fix innocuous bug in raid6 stripe_to_pdidx
 [PATCH 002 of 4] md: Fix newly introduced read-corruption with raid6.
 [PATCH 003 of 4] md: Misc fixes for aligned-read handling.
 [PATCH 004 of 4] md: Fix a couple more bugs in raid5/6 aligned reads
