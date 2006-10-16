Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWJPNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWJPNsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWJPNsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:48:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18144 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750763AbWJPNsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:48:11 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, johnstul@us.ibm.com
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
References: <1160596462.5973.12.camel@localhost.localdomain>
	<20061011142646.eb41fac3.akpm@osdl.org>
	<1160606911.5973.36.camel@localhost.localdomain>
	<20061011160328.f3e7043a.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 15:48:02 +0200
In-Reply-To: <20061011160328.f3e7043a.akpm@osdl.org>
Message-ID: <p73odsccqy5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> Is there any actual need to hold xtime_lock while doing the port IO?  I'd
> have thought it would suffice to do
> 
> 	temp = port_io
> 	write_seqlock(xtime_lock);
> 	xtime = muck_with(temp);
> 	write_sequnlock(xtime_lock);
> 
> ?

That would be a good idea in general. The trouble is just that whatever race
is there will be still there then, just harder to trigger (so instead of 
every third boot it will muck up every 6 weeks). Not sure that is
a real improvement.

-Andi
