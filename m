Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWEVGTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWEVGTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEVGTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:19:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:723 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932159AbWEVGTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:19:10 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 16:18:45 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Don Dupuis" <dondster@gmail.com>
Subject: [PATCH 000 of 2] md: Introduction
Message-ID: <20060522161259.2792.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches to fix two possibly Oopses in md/raid
Both are suitable for 2.6.17.

Both involve indexing off the end of the array, and only cause a
problem if the ends up hitting a non-mapped page.

The first only affects raid0 is fairly rare put possible circumstances.

The second can affect all users of bio_split: linear, raid0, raid10

Thanks to Don Dupuis for hitting these bugs!

 [PATCH 001 of 2] md: Fix possible oops when starting a raid0 array
 [PATCH 002 of 2] md: Make sure bi_max_vecs is set properly in bio_split
