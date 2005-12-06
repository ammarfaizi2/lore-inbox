Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVLFRxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVLFRxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVLFRxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:53:04 -0500
Received: from web32110.mail.mud.yahoo.com ([68.142.207.124]:35740 "HELO
	web32110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932605AbVLFRxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:53:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Kz+AiCpVg2ovZQhYRP54p45zQ3In2J2jZDZo76d1zAu+Yqn6nzOvwOxHdBnrLY6VoaGNBhdW5tMpB+7PB3aDFVEvWAN3pI2eWO0AdYTBVn3X/z03yOZW4mXqukmRhzJab4adH6kxSaYx7EWtf80AOeOsuf0KcY2DH2EQXvOBR1s=  ;
Message-ID: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 09:53:01 -0800 (PST)
From: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: Re: copy_from_user/copy_to_user question
To: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1133634378.6724.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to Steve and everybody who sent such detailed
and timely responses to my question. 

The motivation for the copy to user question is due to
the handling of ioctl calls in the driver for a chip
that is widely used. I just could not beleive that
they would/could commit such a mistake. 

It looks like the old driver code still seems to work
even without performing copy_to_user and
copy_from_user.

But this brings about another scenario. What if the
case statement in the ioctl call only needs to have
access to the members of the structure passed in
through the arg pointer but does not need to modify
these values and return values. 

Is this still a problem if copy_to_user and
copy_from_user is not used?

Thanks,
Vinay


--- Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2005-12-03 at 15:35 -0700, Andi Kleen wrote:
> > Steven Rostedt <rostedt@goodmis.org> writes:
> > > 
> > > Nope, the kernel is always locked into memory. 
> If you take a page fault
> > > from the kernel world, you will crash and burn.
> The kernel is never
> > > "swapped out".  So if you are in kernel mode,
> going into do_page_fault
> > > in arch/i386/mm/fault.c there is no path to swap
> a page in.
> > 
> > Actually there is - when the page fault was caused
> by *_user. 
> 
> Sorry I wasn't clearer.  I know the copy_user case
> (and explained it in
> detail earlier in this thread). I was talking about
> what happens in the
> memcpy case.  So that should have said "outside of
> copy_user and
> friends, there is no path to swap a page in".
> 
> -- Steve
> 
> 
> 



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

