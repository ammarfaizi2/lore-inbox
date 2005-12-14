Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbVLNECx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbVLNECx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 23:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVLNECx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 23:02:53 -0500
Received: from ns2.suse.de ([195.135.220.15]:19136 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030428AbVLNECw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 23:02:52 -0500
Date: Wed, 14 Dec 2005 05:02:36 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: dada1@cosmosbay.com, clameter@engr.sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-ID: <20051214040236.GF23384@wotan.suse.de>
References: <20051212020211.1394bc17.pj@sgi.com> <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com> <439EF75D.50206@cosmosbay.com> <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com> <439F0B43.4080500@cosmosbay.com> <20051213130350.464a3054.pj@sgi.com> <439F3F6E.6010701@cosmosbay.com> <20051213142346.ccd3081a.pj@sgi.com> <20051213195457.4e2b31af.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213195457.4e2b31af.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But, boy oh boy, that synchronize_rcu() call sure takes it time.
> 
> My cpuset torture test was creating, destroying and abusing about 2600
> cpusets/sec before this change, and now it does about 144 cpusets/sec.
> 
> That cost 95% of the performance.  This only hits on the cost of
> attaching a task to a different cpuset (by writing its <pid> to
> some other cpuset 'tasks' file.)

That is why call_rcu.et.al. is a better interface if you want performance.
It runs the freeing batched in the background.

-Andi
