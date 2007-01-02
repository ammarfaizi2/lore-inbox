Return-Path: <linux-kernel-owner+w=401wt.eu-S1754968AbXABVZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbXABVZh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbXABVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:25:36 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:36241 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963AbXABVZf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:25:35 -0500
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 16:25:35 EST
From: Paul Moore <paul.moore@hp.com>
Organization: Hewlett-Packard
To: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: selinux networking: sleeping functin called from invalid context in 2.6.20-rc[12]
Date: Tue, 2 Jan 2007 16:25:24 -0500
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20061225052124.A10323@freya> <20061224162511.eaac4a89.akpm@osdl.org> <20070102155826.A14811@freya>
In-Reply-To: <20070102155826.A14811@freya>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200701021625.24694.paul.moore@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 2 2007 2:58 am, Adam J. Richter wrote:
> 	I have not yet performed the 21 steps of
> linux-2.6.20-rc3/Documentation/SubmitChecklist, which I think is a
> great objectives list for future automation or some kind of community
> web site.  I hope to find time to make progress through that
> checklist, but, in the meantime, I think the world may nevertheless be
> infinitesmally better off if I post the patch that I'm currently
> using that seems to fix the problem, seeing as how rc3 has passed
> with no fix incorporated.
>
> 	I think the intent of the offending code was to avoid doing
> a lock_sock() in a presumably common case where there was no need to
> take the lock.  So, I have kept the presumably fast test to exit
> early.
>
> 	When it turns out to be necessary to take lock_sock(), RCU is
> unlocked, then lock_sock is taken, the RCU is locked again, and
> the test is repeated.

Hi Adam,

I'm sorry I just saw this mail (mail not sent directly to me get shuffled off 
to a folder).  I agree with your patch, I think dropping and then re-taking 
the RCU lock is the best way to go, although I'm curious to see what others 
have to say.

The only real comment I have with the patch is that there is some extra 
whitespace which could probably be removed, but that is more of a style nit 
than anything substantial.

> 	By the way, in a change not included in this patch,
> I also tried consolidating the RCU locking in this file into a macro
> IF_NLBL_REQUIRE(sksec, action), where "action" is the code
> fragment to be executed with rcu_read_lock() held, although this
> required splitting a couple of functions in half.

>From your description above I'm not sure I like that approach so much, 
however, I could be misunderstanding something.  Do you have a small example 
you could send?

-- 
paul moore
linux security @ hp
