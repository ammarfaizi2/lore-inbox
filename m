Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTDYKoO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbTDYKoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:44:14 -0400
Received: from [12.47.58.68] ([12.47.58.68]:27824 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263859AbTDYKoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:44:13 -0400
Date: Fri, 25 Apr 2003 03:57:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.68 2/2] i_size atomic access
Message-Id: <20030425035727.6f107236.akpm@digeo.com>
In-Reply-To: <20030425014208.GC26194@dualathlon.random>
References: <1051230056.2448.16.camel@ibm-c.pdx.osdl.net>
	<20030424180503.2c2a8bea.akpm@digeo.com>
	<20030425014208.GC26194@dualathlon.random>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2003 10:56:17.0333 (UTC) FILETIME=[4BFAEE50:01C30B19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Apr 24, 2003 at 06:05:03PM -0700, Andrew Morton wrote:
> > And if the race _does_ hit, what is the effect?  Assuming stat() was fixed
> > with i_sem, I don't think the race has a very serious effect.  We won't
> 
> writepage needs it too to avoid returning -EIO and I doubt you want to
> take the i_sem in writepage

Well the -EIO thing is bogus really, but yes.  The writepage will not hit
disk *at all*.  That's a problem.

We modify i_size in very few places - an alternative might be to maintain a
parallel unsigned long i_size>>PAGE_CACHE_SIZE in the inode and use that in
critical places.  Sounds messy though.

Ho hum.  ugh.

