Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVCKU4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVCKU4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVCKUy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:54:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30224
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261519AbVCKUxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:53:11 -0500
Date: Fri, 11 Mar 2005 21:53:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 fix for write throttling on x86 >1G
Message-ID: <20050311205309.GD9270@opteron.random>
References: <20050311061035.GZ26348@opteron.random> <20050311160413.GK4816@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311160413.GK4816@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

On Fri, Mar 11, 2005 at 01:04:13PM -0300, Marcelo Tosatti wrote:
> Out of curiosity, that was SuSE not mainline ? 

yep.

> Do we really want to limit dirty cache to low mem on HIGHIO capable 
> machines? I'm afraid doing so might hurt performance on such systems.
> 
> I think it might be wise to have nr_free_buffer_pages() take highmem
> into account if CONFIG_HIGHIO is set ?

The problem is the buffercache/blkdev-pagecache: it simply can't go in
highmem. A similar fix happened recently in 2.6 for the same reasons,
but in 2.6 we allowed it with some logic specific for the
blkdev-pagecache.

nr_free_buffer_pages() was never intended to take highmem into account,
that's why there's the GFP_USER thing already, except we didn't loop
into the zonelist, so I didn't try to make a fix similar to 2.6.
