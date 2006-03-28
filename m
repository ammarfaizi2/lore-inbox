Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWC1KKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWC1KKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWC1KKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:10:41 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:24223 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751222AbWC1KKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:10:40 -0500
In-Reply-To: <200603281147.59382.ak@suse.de>
Subject: Re: RFC - Approaches to user-space probes
Sensitivity: 
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       davem@davemloft.net, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       prasanna@in.ibm.com, suparna@in.ibm.com,
       "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF4F66C49C.6AA583AA-ON8025713F.0037AAFD-8025713F.0037E585@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 28 Mar 2006 11:10:32 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/03/2006 11:11:04
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Andi Kleen <ak@suse.de> wrote on 28/03/2006 09:47:57:

> On Tuesday 28 March 2006 11:42, Richard J Moore wrote:
>
> > 1) ptrace is orientated to debugging a specific process tree and a
> > nominated debug process. Having it operate on arbitrary process would
> > require kernel extensions to achieve that but would also have a major
> > impact on performance if each event were to result in a context switch
to
> > the debugger process.
>
> You can attach it to any pid

Yes, of course. But you have to do some work to  determine the PIDs,
especially if you want to catch new processes that aren't in the current
set of debugee process trees.


>
> The problem is just finding new processes when they are created. And when
> you trace all it will be quite inefficient.
>
> >
> > 2) ptrace operates by privatizing memory via COW, but kprobes doesn't.
The
> > probes are fixed-up when a page is brought into memory by using an
alias
> > r/w virtual address. Using existing the ptrace mechanism across all, or
> > most, processes could have a significant affect on swapfile and paging
> > rate. And that has to be bad news when investigating performance and
race
> > conditions problems.
>
> The problem with ptrace is also that it is quite heavyweight - you have
> to take over all signals at least etc. Some lighter weight probing
> mechanism for user space would be probably a good idea.
>
> > If we want to make life easier for debugging the types of problems
> > indicated above, then it's seems very reasonable to ask whether ptrace
can
> > be extended to use the (user) kprobes mechanism.
>
> It's a mistery to me why people hate ioctl and like ptrace.

No doubt we'll find out soon ;-)


>
> ptrace already is far too complex and ugly. Clean new calls would be
probably
> preferable.
>
> -Andi

