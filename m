Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTCEVJV>; Wed, 5 Mar 2003 16:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTCEVJV>; Wed, 5 Mar 2003 16:09:21 -0500
Received: from ns.suse.de ([213.95.15.193]:32012 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264705AbTCEVJU>;
	Wed, 5 Mar 2003 16:09:20 -0500
Date: Wed, 5 Mar 2003 22:19:49 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030305211949.GA7961@wotan.suse.de>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E664F26.7000602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E664F26.7000602@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 11:25:26AM -0800, Ulrich Drepper wrote:
> > The problem is that the context switch is much more expensive with that
> > (wrmsr is quite expensive compared to the memcpy or index reload). The kernel 
> > optimizes it away when not needed, but with glibc using them 
> > for everything all processes will switch slower.
> 
> And the loadsegment() call with all the preparations if faster?  And

loadsegment and preparation has to be done anyways for compatibility
(we tried to do that lazy too, but failed) 

The 64bit base switch is additional cost.

> 
> >  but is it that big a problem to split the
> > index table for thread local data and the stack? 
> 
> Yes, it it.  It would basically double thread create-destroy costs.
> double the internal administrative overhead (and time and memory), would
> add more dcache pressure, and so on.  It is simply stupid.  We don't
> have to do it for any other architecture, so don't force such hacks on
> us for an architecture whose lifespan just starts.

I would definitely prefer double thread-create/delete costs over even
slightly higher context switch costs. Compared to a context switch a 
thread creation or deletion is a once-in-a-millenium event.

-Andi
