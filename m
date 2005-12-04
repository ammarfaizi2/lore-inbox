Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVLDF4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLDF4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 00:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLDF4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 00:56:39 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:34975 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750724AbVLDF4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 00:56:38 -0500
Date: Sun, 4 Dec 2005 14:06:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051204060610.GA3539@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
	npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201214931.2dbc35fe.akpm@osdl.org> <20051202151352.GA3707@dmt.cnet> <20051202133917.1ebbe851.akpm@osdl.org> <20051203002614.GA3140@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203002614.GA3140@dmt.cnet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 10:26:14PM -0200, Marcelo Tosatti wrote:
> It seems very fragile (Wu's patches attempt to address that) in general: you
> tweak it here and watch it go nuts there.

The patch still has problems, and it can lead to more page allocations in
remote nodes.

For NUMA systems, basicly HPC applications want locality, and file servers
want cache consistency. More worse two types of applications can coexist in one
single system. The general solution may be classifying pages into two types:

local  pages: mostly local accessed, and low latency is first priority
global pages: for consistent file caching

Reclaims from global pages should be balanced globally to make a seamlessly
single global cache. We can allocate special zones to hold the global pages,
and make the reclaims from them in sync. Nick, are you working on this?

Thanks,
Wu
