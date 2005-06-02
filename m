Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVFBFph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVFBFph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 01:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFBFpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 01:45:36 -0400
Received: from mail.timesys.com ([65.117.135.102]:27069 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261559AbVFBFp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 01:45:29 -0400
Message-ID: <429E9C9A.1030507@timesys.com>
Date: Thu, 02 Jun 2005 01:43:54 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: dwalker@mvista.com, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
References: <F989B1573A3A644BAB3920FBECA4D25A036671E5@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A036671E5@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2005 05:38:40.0984 (UTC) FILETIME=[552C9580:01C56735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> It doesn't matter in which space the tasks are, a deadlock 
> condition can happen anywhere and that can easily lead to 
> infinite recursion/iteration (as bad). I seem to remember Ingo
> mentioning he had taken care of full transitivity (or maybe it
> was somebody else saying it).

That might have been me.  The last time I looked at this
specifically, full transitive promotion was being done in
the RT patch.  However unlike your attempt at scaling the
lock scope, the RT patch had one lock which coordinated
all mutex dependency traversals system wide.  This lock
must be speculatively acquired even before we ascertain
transitive promotion is required.

So it doesn't scale as well as it could in the case of
large count SMP systems.  The response was that of "get
it to work first and then we'll get it to scale" which
is reasonable.

When I looked at this sometime in the latter part of last
year I was concerned there was an inherent hierarchy violation
possible in the kernel for the case of fine grained (per-mutex)
locking when doing a transitive promotion traversal.   The
order of traversal is dependent upon the application's lock
acquisition sequence.  Ingo pointed out there shouldn't be a
kernel hierarchy inversion if it was first determined the
application itself wasn't violating it's own lock acquisition
hierarchy.  I recall this to be a valid and simplifying
assumption at the time though I haven't had cause to
follow up on the issue since then.

-john



-- 
john.cooper@timesys.com
