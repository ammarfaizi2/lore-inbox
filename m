Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVLMVok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVLMVok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLMVoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:44:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26584 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932385AbVLMVoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:44:39 -0500
Date: Tue, 13 Dec 2005 13:44:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213134419.175821cd.pj@sgi.com>
In-Reply-To: <439EF75D.50206@cosmosbay.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> I do think we should have defined a special section for very hot (and written) 
> spots. It's more easy to locate thos hot spots than 'mostly read and shared by 
> all cpus without cache ping pongs' places...

Should we do something like:
 1) identify the hot write spots, to arrange them by access pattern,
	as Christoph considered, in another reply on this thread.
 2) identify the hot read, cold write spots, to bunch them up away from (1)
 3) leave the rest as "inert filler" (aka "cannon fodder", in my previous
	reply), but unmarked in any case.
 4) change the word "__read_mostly" to "__hot_read_cold_write", to more
	accurately fit item (2).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
