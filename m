Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTF3QQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTF3QQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:16:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265085AbTF3QQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:16:41 -0400
Date: Mon, 30 Jun 2003 17:31:01 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] ethtool_ops
Message-ID: <20030630163101.GI31618@parcelfarce.linux.theplanet.co.uk>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D8CD@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D8CD@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry for the delayed reply; PCI domain work got a lot more important
for a while)

On Fri, Jun 06, 2003 at 01:17:46PM -0700, Feldman, Scott wrote:
> * On get_gregs, for example, would it make sense to ->get_drvinfo
>   so you'll know regdump_len and therefore can kmalloc an ethtool_regs
>   with enough space to pass to ->get_regs?  Keep the kmalloc and
>   kfree together.  Same for self_test, get_strings, and get_stats.
>   For get_strings, size = max{n_stats, testinfo_len)*sizeof(u64).

That would be one possibility, but get_drvinfo is quite heavyweight.
I think I'd prefer to not do that unless there's a strong feeling about
thing.

> * If the above is done, can we have one function type for the
> ethtool_ops
>   functions?  int f(struct netdev *, struct ethtool_cmd *).  The 
>   drawback is the driver needs to cast to the specific ethtool_* struct.

Definitely not -- the point is adding type safety.

> * Can we get an HAVE_ETHTOOL_OPS defined in netdevice.h to support
>   backward compat?

I'm hoping to avoid that by getting compatibility code merged into 2.4.22.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
