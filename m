Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUDHPr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDHPr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:47:29 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:55238 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261947AbUDHPr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:47:27 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <20040408153412.GD31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain>
	<1081435237.1885.144.camel@mulgrave>
	<20040408151415.GB31667@dualathlon.random>
	<1081438124.2105.207.camel@mulgrave> 
	<20040408153412.GD31667@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 10:47:23 -0500
Message-Id: <1081439244.2165.236.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 10:34, Andrea Arcangeli wrote:
> yes, the spinlock in struct address_space would be enough, and that's
> what 2.4 does too, Andrew changed it to a semaphore in 2.6 but it can be
> made a spinlock again. Then you can fix it (as far as you never call it
> from an irq and as far as you don't generate exceptions inside the
> critical section, but I'm sure you don't).

Well, yes, of course we do.  We're a sofware tlb arch, so we generate
exceptions on tlb misses, which can occur anywhere (even in critical
sections).  However, the exceptions are carefully crafted not to take
spinlocks, so everything should be safe.

I'm not sure about the no in irq assertion.  The biggest use of
flush_dcache_page is on the I/O return path ... that looks like a good
candidate for being in interrupt (even though most drivers should be
offloading to softirq/tasklets).

James




