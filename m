Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSIETNQ>; Thu, 5 Sep 2002 15:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSIETNQ>; Thu, 5 Sep 2002 15:13:16 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:26375 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318131AbSIETNQ>; Thu, 5 Sep 2002 15:13:16 -0400
Date: Thu, 5 Sep 2002 20:17:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905201752.B12457@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194649.A11789@infradead.org> <20020905185917.GG1657@dualathlon.random> <20020905200240.A12253@infradead.org> <20020905191325.GI1657@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905191325.GI1657@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 09:13:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 09:13:25PM +0200, Andrea Arcangeli wrote:
> the latter would take care of O_DIRECT too I think. Of course it's
> mostly a theorical issue, I mentioned it just so you would check it,
> keep it in mind and eventually fix it, we had this kind of races in the
> 32bit architectures in on all the fs for ages, infact you know 2.4-aa is
> the only tree out there with these race fixed for most important fs, 2.4
> and 2.5 mainline are still racy too (2.4 because it was a recent
> discovery, 2.5 because it's my mistake that I didn't yet had time to
> submit fixes, btw, if anybody is interested to port to 2.5 that's
> welcome).  For the normal fs I didn't want to add locks around the read
> and truncate paths, and that's why I implemented the lockless accessors,
> also consiering the accessors are zerocost noops on all the 64bit archs
> (long [or should now say "short" :) ] term thinking).

For 2.5 I'd prefer to make i_sem a r/semaphore and take it in read mode
instead of the lockless games we play with 64bit sizes currently.

I think this should also give a nice speedup as e.g. readdir or lookup
could happen in parallel then.

