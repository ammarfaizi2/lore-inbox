Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUIFAd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUIFAd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIFAd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:33:56 -0400
Received: from holomorphy.com ([207.189.100.168]:8341 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267368AbUIFAdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:33:55 -0400
Date: Sun, 5 Sep 2004 17:33:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lighten mmlist_lock
Message-ID: <20040906003348.GE3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0409052344350.3218-100000@localhost.localdomain> <20040905234101.GD3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905234101.GD3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 04:41:01PM -0700, William Lee Irwin III wrote:
> The ticketing scheme -based alternative only really has to involve a
> pgd coming into active use, so s/mmlist addition points/pgd reuse points/
> would be better here to retain instructions for anyone suffering from
> contention on pgd_lock how to address the issue with the new mmlist
> scheme. pgd_alloc() and pgd_free() actually appear to suffice, and it's
> also worth mentioning the ticketing scheme's MMU context switch and
> smp_call_function() requirements as well.
> So I'll send an update to that comment a bit later on.

Actually we should probably #ifdef the whole change_page_attr() mess
on CONFIG_AGP; any box that cares about the overhead will be headless
and thus able to remove the state maintenance on behalf of AGP. AGP's
introduction of physical aliases (i.e. 2 physical addresses aliasing
the same memory) without cache coherency protocol support was beyond
insane and people should be able to opt out of the overhead when they
don't want or need AGP support.


-- wli
