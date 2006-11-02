Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWKBBvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWKBBvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbWKBBvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:51:44 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:6959 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750704AbWKBBvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:51:43 -0500
Message-ID: <45494F18.4000406@oracle.com>
Date: Wed, 01 Nov 2006 17:51:20 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jeff Moyer <jmoyer@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: lock refcount operations
References: <20061027181735.18631.43565.sendpatchset@tetsuo.zabbo.net>	<x49fyd9v9sy.fsf@segfault.boston.devel.redhat.com>	<45426D3F.3040304@oracle.com> <x49odrxnyyt.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49odrxnyyt.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> zach.brown> that path before the recent dio completion patch set.  We
> zach.brown> shouldn't expect significant performance regression from
> zach.brown> returning to the behaviour that existed before the completion
> zach.brown> clean up work. 
> 
> Are you going to quantify this at all?  I think we should.

I spotted some free time on an old dual athlon and got an initial look
at the cpu cost of the dio cleanup patches currently in -mm.

I ran two aio-stress instances doing O_DIRECT 64k sequential reads and
writes to an existing 1gig file on ext3 on an old pata drive.  I ran a
pair of cycle soakers measuring cpu load every second.  After trimming
out the 8 highest and lowest samples the remaining samples were
averaged.  I did this three times against 2.6.19-rc4-mm1 before and
after applying the dio-* patches.

before: 5.02% 5.23% 5.27%
after:  5.27% 5.33% 5.32%

So I'm not *gravely* concerned that we've regressed, but it'd be nice to
measure the impact of the dio-* patches on more capable hardware.

- z
