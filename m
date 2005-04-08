Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVDHC3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVDHC3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 22:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVDHC3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 22:29:04 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:19370 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262661AbVDHC26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 22:28:58 -0400
Subject: Re: 2.6.12-rc2-mm1
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050407180810.A10873@unix-os.sc.intel.com>
References: <20050405000524.592fc125.akpm@osdl.org>
	 <42523F5D.7020201@yahoo.com.au>
	 <20050405115113.A17809@unix-os.sc.intel.com>
	 <42541830.1010201@yahoo.com.au>
	 <20050407180810.A10873@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 12:28:49 +1000
Message-Id: <1112927329.11550.4.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 18:08 -0700, Siddha, Suresh B wrote:
> On Thu, Apr 07, 2005 at 03:11:12AM +1000, Nick Piggin wrote:
> > Using the attached patch, a puny dual PIII-650 with ~400MB RAM swapped
> > itself to death after 20000 infinite loop tasks had been pinned to one
> > of the CPUs. See how you go.
> 
> Its goes well beyond the initial 7000 number I mentioned. Thanks.
> 

OK, good thanks for testing that. I'll send it to Andrew.

> One side-effect of this patch is: for example we have only two processes 
> running on a cpu and both are pinned to that cpu. If someone comes and 
> changes the affinity of one of these processes to all cpu's in the system, 
> then it might take MAX_PINNED_INTERVAL before this process moves to an idle cpu.
> 

Yeah, that is true. OTOH it is a bit of a special case, and our
multiprocessor scheduling in general practically shuts down when
we have a situation with a single queue with a lot of pinned tasks.

What did I have for MAX_PINNED_INTERVAL? ~1second. I guess that could
come down a bit - maybe 1/4 or 1/2 a second? I think it is a "good
enough for now" kind of situation.


-- 
SUSE Labs, Novell Inc.


