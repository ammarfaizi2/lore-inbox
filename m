Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUDHQQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUDHQQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:16:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45992
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262027AbUDHQQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:16:11 -0400
Date: Thu, 8 Apr 2004 18:16:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408161610.GF31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain> <1081435237.1885.144.camel@mulgrave> <20040408151415.GB31667@dualathlon.random> <1081438124.2105.207.camel@mulgrave> <20040408153412.GD31667@dualathlon.random> <1081439244.2165.236.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081439244.2165.236.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 10:47:23AM -0500, James Bottomley wrote:
> candidate for being in interrupt (even though most drivers should be
> offloading to softirq/tasklets).

softirq tasklets would be unsafe too, oh well, if you take it really
from irq context (irq/softirq/tasklet) then just a spinlock isn't
enough, it'd need to be an irq safe lock or whatever similar plus you
must be sure to never generate exceptions triggering the call inside the
critical section. sounds like we need some per-arch abstraction to cover
this, we for sure don't want an irq spinlock for this, then we can as
well leave the semaphore for all archs but parisc.
