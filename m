Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVAXAWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVAXAWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVAXAWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:22:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261385AbVAXAWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:22:53 -0500
Date: Mon, 24 Jan 2005 11:21:29 +1100
From: Nathan Scott <nathans@sgi.com>
To: Matt Mackall <mpm@selenic.com>, Andreas Gruenbacher <agruen@suse.de>
Cc: Andi Kleen <ak@muc.de>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050124112129.C1545508@wobbly.melbourne.sgi.com>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de> <20050123042930.GI3867@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050123042930.GI3867@waste.org>; from mpm@selenic.com on Sat, Jan 22, 2005 at 08:29:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 08:29:30PM -0800, Matt Mackall wrote:
> On Sun, Jan 23, 2005 at 03:39:34AM +0100, Andi Kleen wrote:
> 
> c) the three-way median selection does help avoid worst-case O(n^2)
> behavior, which might potentially be triggerable by users in places
> like XFS where this is used

XFS's needs are simple - we're just sorting dirents within a
single directory block or smaller, and sorting EA lists/ACLs -
all of which are small arrays, so a qsort optimised for small
arrays suits XFS well.  Take care not to put any arrays on the
stack though, else the CONFIG_4KSTACKS punters won't be happy.

cheers.

-- 
Nathan
