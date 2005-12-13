Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVLMWfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVLMWfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVLMWfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:35:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4078 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030270AbVLMWfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:35:21 -0500
Date: Tue, 13 Dec 2005 14:35:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213143500.96c9aecd.pj@sgi.com>
In-Reply-To: <439F2F39.3090800@cosmosbay.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
	<20051213120814.f7e1d73d.pj@sgi.com>
	<439F2F39.3090800@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> But the initial pointer *should* be in a cache line shared by all cpus to get 
> best performance. 

No - not if that pointer is seldom used.  Then its location does not
directly affect performance at all, and better for it to be used as
"inert filler" to fill out cache lines of words that are write hot.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
