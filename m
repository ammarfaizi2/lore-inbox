Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUGICO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUGICO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUGICO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:14:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:53676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263040AbUGICOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:14:21 -0400
Date: Thu, 8 Jul 2004 19:12:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: nickpiggin@yahoo.com.au, petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-Id: <20040708191254.2475c8d1.akpm@osdl.org>
In-Reply-To: <20040709020905.GT21066@holomorphy.com>
References: <m2brir9t6d.fsf@telia.com>
	<40ECADF8.7010207@yahoo.com.au>
	<20040708023001.GN21066@holomorphy.com>
	<m2briq7izk.fsf@telia.com>
	<20040708193956.GO21066@holomorphy.com>
	<40EDED5D.80605@yahoo.com.au>
	<20040709015317.GR21066@holomorphy.com>
	<40EDFDBE.5040805@yahoo.com.au>
	<20040709020905.GT21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> William Lee Irwin III wrote:
> >> They added a flag indicating wiredness or no to the gfp_mask, which was
> >> then propagated down the call chain and eventually passed as an argument
> >> to out_of_memory(). In turn, out_of_memory() used the flag to determine
> >> whether the nr_swap_pages > 0 check was relevant. i.e. they refined the
> >> OOM conditions based on the wiredness of the failing allocation. What
> >> probably got the stuff permavetoed was the stats reporting I did along
> >> with it that would have been trivial to drop while retaining the needed
> >> functional change. The patch was motivated by the nr_swap_pages > 0
> >> check deadlocking. The __GFP_WIRED business was done to discriminate
> >> the obvious deadlocking scenario from the false OOM mentioned here.
> 
> On Fri, Jul 09, 2004 at 12:06:54PM +1000, Nick Piggin wrote:
> > No, I did see those patches. I'm not saying they're not worth
> > persuing; on the contrary, they look quite interesting. However,
> > it might worthwhile looking at more basic things first, for this
> > problem anyway.
> 
> Enumerate those more basic things.
> 

1: work out why it's prematurely calling out_of_memory() when laptop_mode=1.

