Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbTIJJBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbTIJJBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:01:30 -0400
Received: from waste.org ([209.173.204.2]:18114 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264772AbTIJJB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:01:26 -0400
Date: Wed, 10 Sep 2003 04:01:21 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-ID: <20030910090121.GH4489@waste.org>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel> <p73znhdhxkx.fsf@oldwotan.suse.de> <20030910082435.GG4489@waste.org> <20030910082908.GE29485@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910082908.GE29485@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:29:08AM +0200, Andi Kleen wrote:
> > No, haven't encountered it. Which lock are we talking about, specifically?
> 
> The hardware register lock of the low level device drivers.
> 
> It's a different lock for each driver.

I was afraid you were getting at something like that. I've been
developing this on UP and the drivers I've been playing with aren't
too chatty so nothing's shown up. 

And no, I don't think there's much that can be done to fix it, short
of putting in deadlock avoidance of some sort or auditing drivers. We
run a risk of infinite recursion if we manage to avoid the deadlock
anyway.

My current plan is to hope that such printks are rare except in
network driver development, in which case using netconsole or kgdb-o-e
is asking for trouble anyway.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
