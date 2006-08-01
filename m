Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWHAU1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWHAU1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWHAU1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:27:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:4021 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161041AbWHAU1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:27:39 -0400
From: Neil Brown <neilb@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Date: Wed, 2 Aug 2006 06:27:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17615.47401.552607.980993@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 9] md: Factor out part of raid10d into a separate
 function.
In-Reply-To: message from Bill Davidsen on Tuesday August 1
References: <20060731172842.24323.patches@notabene>
	<1060731073208.24470@suse.de>
	<44CF8C2D.2010900@tmr.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 1, davidsen@tmr.com wrote:
> don't think this is better, NeilBrown wrote:
> 
> >raid10d has toooo many nested block, so take the fix_read_error
> >functionality out into a separate function.
> >  
> >
> 
> Definite improvement in readability. Will all versions of the compiler 
> do something appropriate WRT inlining or not?

As the separated function is called about once in a blue moon, it
hardly matters.  I'd probably rather it wasn't inlined so as to be
sure it doesn't clutter the L-1 cache when it isn't needed, but that's
the sort of thing I really want to leave to the compiler.

Maybe it would be good to stick an 'unlikely' or 'likely' in raid10d
to tell the compiler how likely a read error is...

NeilBrown
