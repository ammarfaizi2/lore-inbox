Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTA1Gzo>; Tue, 28 Jan 2003 01:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTA1Gzo>; Tue, 28 Jan 2003 01:55:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26190 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264910AbTA1Gzn>; Tue, 28 Jan 2003 01:55:43 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org>
	<3E35AAE4.10204@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2003 00:04:19 -0700
In-Reply-To: <3E35AAE4.10204@us.ibm.com>
Message-ID: <m1r8ax69ho.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Eric W. Biederman wrote:
> > Dave Hansen <haveblue@us.ibm.com> writes:
> >>On my system, it appears to lock up in:
> >>kimage_alloc_reboot_code_pages()
> >>after the kexec -l.
> > 
> > 
> > O.k. It should come out of it eventually from what I have
> > seen described, the current algorithm is definitely inefficient on
> > your machine.
> 
> It does appear to completely hang in the free loop.  Something funny is
> happening there.  I'll try to provide more details later.  BTW, do you
> mind updating your patches for 2.5.59?  

I will give it a shot shortly I have been intensely busy just
lately so find the free second is a bit difficult.  At the same

> I'm having some other problems
> and I want to make sure it isn't my bad merging that's at fault :)

I don't recall any merging issues at all with the stock kernel, just
a some slight line changes.
> 
> > And being able to allocate from 3GB instead of just 1GB is
> > much more polite.  The question then is how do I specify the zones
> > properly.
> 
> Actually, I think that using lowmem is OK.  The machine is going away
> soon anyway, and the necessary memory is a very small portion,
> especially on a machine with this much RAM.

I agree that lowmem for the common case is fine.  For kexec on panic,
and a some weird cases using high mem is beneficial.  I don't have
a problem with changing it back to just lowmem for the time being.
 
Eric
