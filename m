Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUFXAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUFXAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFXAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:15:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:29629 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbUFXAP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:15:27 -0400
Date: Wed, 23 Jun 2004 17:18:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-Id: <20040623171818.39b73d52.akpm@osdl.org>
In-Reply-To: <20040624000308.GK1552@holomorphy.com>
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
	<20040623151659.70333c6d.akpm@osdl.org>
	<20040623223146.GG1552@holomorphy.com>
	<20040623153758.40e3a865.akpm@osdl.org>
	<20040623230730.GJ1552@holomorphy.com>
	<20040623163819.013c8585.akpm@osdl.org>
	<20040624000308.GK1552@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Jun 23, 2004 at 04:38:19PM -0700, Andrew Morton wrote:
> > I don't think it _is_ relevant.  Wev'e scanned the crap out of all the
> > eligible zones, found nothing swappable outable or otherwise reclaimable. 
> > That's as good a definition of oom as you're likely to get.  It takes care
> > of mlocked user memory too.
> 
> The actual net effect of all this is blowing away if (nr_swap_pages > 0)
> for __GFP_WIRED allocations. Removing those 2 lines (and the one line of
> whitespace next to it) will pass the test I observed failure in.

OK.

> It's a
> judgment call as to whether it's beneficial in general, as it does
> insulate userspace somewhat from needing to wait for slow IO being the
> ostensible cause of the allocation failure.

mm...  I can only see that happening if the IO system is retiring write
requests at much less than 10/sec, which seems unlikely.  Still, that can
be tuned around.

> RedHat vendor kernels have removed the check entirely

When telling us this sort of thing, please always specify the kernel version.

I assume you're referring to a 2.6 kernel?  If so, some thwapping might be
in order.
