Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318039AbSGRMkL>; Thu, 18 Jul 2002 08:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318041AbSGRMkL>; Thu, 18 Jul 2002 08:40:11 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58040 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S318039AbSGRMkK>; Thu, 18 Jul 2002 08:40:10 -0400
From: Jean Wolter <jw5@os.inf.tu-dresden.de>
Organisation: Dresden University of Technology
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Mason <mason@f2s.com>, shreenivasa H V <shreenihv@usa.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Gang Scheduling in linux
References: <Pine.LNX.4.44.0207182229460.7854-100000@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
Date: 18 Jul 2002 14:43:04 +0200
In-Reply-To: <Pine.LNX.4.44.0207182229460.7854-100000@localhost.localdomain>
Message-ID: <86it3dtdev.fsf@os.inf.tu-dresden.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> On Wed, 17 Jul 2002, Sam Mason wrote:
> 
> > The important thing to remember is that this isn't a normal scheduling
> > method, it's used for VERY specialised software which is assumed to have
> > (almost) complete control of the machine. [...]
> 
> so how does this differ from a normal Linux system that is used
> exclusively? The specialized tasks will get evenly distributed between
> CPUs (as long as the number of tasks is not higher than the number of
> CPUs), and nothing should interrupt them.

I think as long as there is only one task set, it doesn't matter. But
if you are trying to run several parallel applications at the same
time on the same machine you are trying to schedule them as a gang (at
the same time on different processors) to provide the impression, that
each task set would run alone.

And afaik these applications typically use shared resources which are
protected by some kind of synchronization primitive like (user level)
spinlocks. If one of the processes holds the lock and the kernel
preempts it for some reason no other process needing access to the
shared resource is able to make progress. So the idea is to try to
schedule them all at the same time on different processors to ensure
that blocking time on the shared resource is really short.

regards,
Jean
