Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbTGJKPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269158AbTGJKPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:15:42 -0400
Received: from ns.suse.de ([213.95.15.193]:64273 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269156AbTGJKPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:15:36 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memset (was: Redundant memset in AIO read_events)
References: <20030710100417.83333.qmail@web11801.mail.yahoo.com.suse.lists.linux.kernel>
	<1057832361.5817.2.camel@laptop.fenrus.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Jul 2003 12:29:10 +0200
In-Reply-To: <1057832361.5817.2.camel@laptop.fenrus.com.suse.lists.linux.kernel>
Message-ID: <p73smpepte1.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Thu, 2003-07-10 at 12:04, Etienne Lorrain wrote:
> >  Note that using memset() is better reserved to initialise variable-size
> >  structures or buffers. Even if memset() is extremely optimised,
> >  it is still not as fast as not doing anything.
> 
> this is not always true....
> memset can be used as an optimized cache-warmup, which can avoid the
> write-allocate behavior of normal writes, which means that if you memset
> a structure first and then fill it, it can be halve the memory bandwidth
> and thus half as fast. This assumes an optimized memset which we
> *currently* don't have I think... but well, we can fix that ;)

You don't want to use such an memset unlike you're clearing areas
which are significantly bigger than all your cache (>several MB)
The problem is that the instruction that avoid write-allocate usually also force 
the result out of cache. And for small data sets that is typically a loss
if you want to use the data later, because the later use eats full cache misses.
In the kernel such big buffers occur only very rarely, most operations are on
4K and less. For those only in cache operation is interesting.

-Andi
