Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTJLL7O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTJLL7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:59:14 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34190 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263463AbTJLL7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:59:02 -0400
Date: Sun, 12 Oct 2003 12:59:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: asdfd esadd <retu834@yahoo.com>
Cc: Kenn Humborg <kenn@linux.ie>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
Message-ID: <20031012115900.GC13427@mail.shareable.org>
References: <20031011175744.GA15610@excalibur.research.wombat.ie> <20031011183405.38980.qmail@web13007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011183405.38980.qmail@web13007.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asdfd esadd wrote:
> There is a connex, fork() might be a bad example,
> 
> it's simple - yes but 20 years have passed as Solaris
> is finding:
> 
> pid_t fork(void); vs. 
> 
> the next step in the evolution CreateProcess
>
> [extraordinarily long-winded way of saying the same thing as
>  if ((pid = fork()) == 0) { set_things(); go(); } ]

Dear asdfd,

How can you possibly think the CreateProcess monstrosity superior to
fork in any way?  You seem to have picked the canonical example of
just what is awful about the Win32 AI and why it's so much work to use.

I cannot think of a single example where CreateProcess is simpler to
use - and it's worse than that: it comes with a bunch of assumptions
and limitations, exactly the kind of thing that presumably you expect
"a component model" to _not_ have.

What do you do when you want to create a process with a property that
_isn't_ listed in the arguments to CreateProcess?  Yes: you have to
set those in the child process, just like with fork().

So what's the point in having some of the properties listed in
CreateProcess?  Answer: none.  Not from an API cleanliness point of
view anyway.

> System.Object
>    System.MarshalByRefObject
>       System.ComponentModel.Component
>          System.Diagnostics.Process
> [C#]
> public class Process : Component
> [C++]
> public __gc class Process : public Component

This begins to make more sense.  You do understand that unix has this
class too, but it's called pid_t, not Process?

> * unified well architected core component model
> which is extensible from OS services to application
> objects

Yeah, but CreateProcess _isn't_ well architected.  It's among the
worst of excreta in Win32.

> * the object model should be defined from the kernel
> layer for process/events/devices etc. up and not
> started at the application layer

Unfortunately you just state this, without giving any reasons for it.

If this were implemented in userspace (i.e. the Mono project),
can you give a single reason why it needs to be extended into the kernel?

-- Jamie
