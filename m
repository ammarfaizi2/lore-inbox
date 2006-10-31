Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423467AbWJaPGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423467AbWJaPGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423472AbWJaPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:06:18 -0500
Received: from junsun.net ([66.29.16.26]:7947 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1423467AbWJaPGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:06:18 -0500
Date: Tue, 31 Oct 2006 07:06:12 -0800
From: Jun Sun <jsun@junsun.net>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org
Subject: Re: reserve memory in low physical address - possible?
Message-ID: <20061031150612.GA14272@srv.junsun.net>
References: <20061031072203.GA10744@srv.junsun.net> <20061031081239.GA9539@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031081239.GA9539@linux-sh.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:12:39PM +0900, Paul Mundt wrote:
> On Mon, Oct 30, 2006 at 11:22:03PM -0800, Jun Sun wrote:
> > I understand it is possible to reserve some memory at the end by
> > specifying "mem=xxxM" option in kernel command line.  I looked into
> > "memmap=xxxM" option but it appears not helpful for what I want.
> > 
> memmap takes multiple arguments, including the start address for the
> memory map. You could also bump min_low_pfn manually if memmap= isn't
> suitable for you, something like:
> 
> 	magic_space = PFN_UP(init_pg_tables_end);
> 	min_low_pfn = magic_space + magic_size;
> 
> (assuming magic_size is rounded up already), should work fine. Though
> memmap= already takes care of most of this for you, could you explain why
> it's unsuitable?

That is fair question. I got that conclusion by a quick test with
"memmap=" and kernel did not boot. :)

Now think about it, it could be because the loader  (or the real-mode
part of kernel) has not been modified to deal with the initial gap.
Can someone confirm that and give some hints on how to do this?

Thanks.

Jun
