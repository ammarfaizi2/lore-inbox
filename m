Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWBOU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWBOU0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBOU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:26:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:55502 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWBOU0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:26:05 -0500
From: Andi Kleen <ak@suse.de>
To: Antonio Vargas <windenntw@gmail.com>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Date: Wed, 15 Feb 2006 21:25:52 +0100
User-Agent: KMail/1.8.2
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060215151711.GA31569@elte.hu> <200602152102.12795.ak@suse.de> <69304d110602151213r1facd508idd859c8cff0326a7@mail.gmail.com>
In-Reply-To: <69304d110602151213r1facd508idd859c8cff0326a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602152125.53767.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 21:13, Antonio Vargas wrote:
> On 2/15/06, Andi Kleen <ak@suse.de> wrote:
> > On Wednesday 15 February 2006 20:49, Christopher Friesen wrote:
> >
> > > The goal is for the kernel to unlock the mutex, but the next task to
> > > aquire it gets some special notification that the status is unknown.  At
> > > that point the task can either validate/clean up the data and reset the
> > > mutex to clean (if it can) or it can give up the mutex and pass it on to
> > > some other task that does know how to validate/clean up.
> >
> > The "send signal when any mapper dies" proposal would do that. The other process
> > could catch the signal and do something with it.
> >
> 
> That would be a new signal such as SIG_FUTEXDIED, would it?

It could be probably made configurable, possibly even in fancy 
ways (RT signal with payload giving the process that got killed and
other information) 

However that would require a new field to the VMA which is a bit
memory critical. Hardcoding the signal is probably better, then only a 
new bit would be needed. Or maybe two  bits, one for SIGKILL and 
another for fixed real time signal with payload.

With that the list walking Ingo put into the kernel could be all
done in user space. 

Ok it might be tricky to ensure the VMA bit is set on all mappings
that need it.  I had some vague memories that SUS had a mmap flag
for that,  but I can't find it right now.

An alternative would be to make it not a VMA attribute, but a 
mm_struct attribute - then it would need to be enabled only once,
not on each mmap.

-Andi

