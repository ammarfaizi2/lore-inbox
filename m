Return-Path: <linux-kernel-owner+w=401wt.eu-S1751999AbXARPhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXARPhc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXARPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:37:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36294 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751999AbXARPhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:37:31 -0500
Date: Thu, 18 Jan 2007 10:37:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
In-Reply-To: <20070118073159.GA27233@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0701181019300.3347-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Ingo Molnar wrote:

> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > I'll be happy to move this over to the utrace setting, once it is 
> > > merged.  Do you think it would be better to include the current 
> > > version of kwatch now or to wait for utrace?
> > > 
> > > Roland, is there a schedule for when you plan to get utrace into 
> > > -mm?
> > 
> > Even if it goes into mainline soon we'll need a lot of time for all 
> > architectures to catch up, so I think kwatch should definitely comes 
> > first.
> 
> i disagree. Utrace is a once-in-a-lifetime opportunity to clean up the 
> /huge/ ptrace mess. Ptrace has been a very large PITA, for many, many 
> years, precisely because it was done in the 'oh, lets get this feature 
> added first, think about it later' manner. Roland's work is a large 
> logistical undertaking and we should not make it more complex than it 
> is. Once it's in we can add debugging features ontop of that. To me work 
> that cleans up existing mess takes precedence before work that adds to 
> the mess.

Interestingly, the current version of utrace makes no special provision
for watchpoints, either in kernel or user space.  Instead it relies on the
legacy ptrace mechanism for setting debug registers in the target
process's user area.  Perhaps an explicit watchpoint implementation should
be added to utrace, but that's beyond the scope of this discussion.

Furthermore, utrace is explicitly intended for tracing user programs, not
for tracing the kernel.  Kwatch, however, is just the opposite: It is
intended for setting up watchpoints in kernel space.  In that sense it is
pretty much orthogonal to utrace.  Although it would affect the utrace
patches, the changes would be basically transparent (i.e., move the new
code from one ptrace handler to another instead of moving the old code).

If Kwatch is to be subsumed anywhere, I think it should be under the
Kprobes/Systemtap project.  Again, that's a separate question -- so far 
they have avoided data watchpoints.

Alan Stern

