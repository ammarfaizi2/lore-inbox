Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWEBUJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWEBUJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEBUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:09:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:32436 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751316AbWEBUJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:09:42 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@google.com>
Subject: Re: 2.6.17-rc2-mm1
Date: Tue, 2 May 2006 22:09:36 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
       linux-kernel@vger.kernel.org, jbeulich@novell.com
References: <4450F5AD.9030200@google.com> <200605012034.26763.ak@suse.de> <4457BA59.8030901@google.com>
In-Reply-To: <4457BA59.8030901@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022209.37205.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 22:00, Martin Bligh wrote:

> > Index: linux/arch/x86_64/kernel/traps.c
> > ===================================================================
> > --- linux.orig/arch/x86_64/kernel/traps.c
> > +++ linux/arch/x86_64/kernel/traps.c
> > @@ -238,6 +238,7 @@ void show_trace(unsigned long *stack)
> >  			HANDLE_STACK (stack < estack_end);
> >  			i += printk(" <EOE>");
> >  			stack = (unsigned long *) estack_end[-2];
> > +			printk("new stack %lx (%lx %lx %lx %lx %lx)\n", stack, estack_end[0], estack_end[-1], estack_end[-2], estack_end[-3], estack_end[-4]);
> >  			continue;
> >  		}
> >  		if (irqstack_end) {
> 
> Thanks for running this Andy:
> 
> http://test.kernel.org/abat/30183/debug/console.log


<EOE>new stack 0 (0 0 0 10082 10)

Hmm weird. There isn't anything resembling an exception frame at the top of the
stack.  No idea how this could happen.

-Andi



