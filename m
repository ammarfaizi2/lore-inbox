Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUGNX7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUGNX7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGNX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:59:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:17313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265098AbUGNX7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:59:47 -0400
Date: Wed, 14 Jul 2004 15:44:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-Id: <20040714154427.14234822.akpm@osdl.org>
In-Reply-To: <1089848823.15336.3895.camel@abyss.home>
References: <1089771823.15336.2461.camel@abyss.home>
	<20040714031701.GT974@dualathlon.random>
	<1089776640.15336.2557.camel@abyss.home>
	<20040713211721.05781fb7.akpm@osdl.org>
	<1089848823.15336.3895.camel@abyss.home>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> wrote:
>
> > 
> > wrt this OOM problem: it's possible that your ZONE_NORMAL got filled with
> > anonymous memory which the VM is unable to do anything about.  If you're
> > going to run a highmem box swapless then you should tune the kernel so that
> > it doesn't use so much ZONE_NORMAL memory for anonymous pages.
> 
> My concern is mainly users which normally run kernel with default
> settings. Things should work for them as well. 

Yes, it could be that the default value of zero for lower_zone_protection
is not appropriate.

> To be honest I do not really understand this OOM without swap problem at
> all, why is it possible to move pages from ZONE_NORMAL to swap but not
> to other zones ? 

If the kernel has no swap there is nothing it can do with an anonymous page
(ie: the thing whcih malloc() gives you).  It is effectively pinned memory,
because there's nowhere we can write it to get rid of it.

If you end up pinning all of your ZONE_NORMAL pages with anonymous memory,
further GFP_KERNEL allocation attempts will go oom.

