Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVARBxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVARBxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVARBmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:42:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:42881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261163AbVARBZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:25:04 -0500
Date: Mon, 17 Jan 2005 17:25:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Chris Bookholt <cgbookho@ncsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: legacy_va_layout
Message-ID: <20050117172503.E469@build.pdx.osdl.net>
References: <41EC5B3A.4000004@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41EC5B3A.4000004@ncsu.edu>; from cgbookho@ncsu.edu on Mon, Jan 17, 2005 at 07:41:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Bookholt (cgbookho@ncsu.edu) wrote:
> Could anyone explain or refer me to some documentation that explains the 
> purpose of the legacy_va_layout sysctl option?
> 
> Essentially, I'm looking to understand how the legacy layout is 
> different from the current 2.6-series VA space layout.

The legacy mode splits a tasks vm into an area for heap, mmaps, and stack
at fixed points.  Notably, mmap space started at 0x40000000, and new
mappings were searched from there scanning upward.  While stack grew
down into that area and heap grew up into that area.

The non-legacy (flexmmap) approach, starts looking for mmap space just
below the largest possible (rlimit) stack size and scans downward.  This
gives the most possible space to either brk or mmap heavy applications,
since the space doesn't start off as fragmented.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
