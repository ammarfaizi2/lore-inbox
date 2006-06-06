Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWFFVsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWFFVsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWFFVsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:48:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751169AbWFFVsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:48:52 -0400
Date: Tue, 6 Jun 2006 14:48:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] misroute-irq: Don't call desc->chip->end because of
 edge interrupts
Message-Id: <20060606144823.1de58b9c.akpm@osdl.org>
In-Reply-To: <1149591019.16247.35.camel@localhost.localdomain>
References: <20060603215323.GA13077@devserv.devel.redhat.com>
	<1149374090.14408.4.camel@localhost.localdomain>
	<1149413649.3109.92.camel@laptopd505.fenrus.org>
	<1149426961.27696.7.camel@localhost.localdomain>
	<1149437412.23209.3.camel@localhost.localdomain>
	<1149438131.29652.5.camel@localhost.localdomain>
	<1149456375.23209.13.camel@localhost.localdomain>
	<1149456532.29652.29.camel@localhost.localdomain>
	<20060604214448.GA6602@elte.hu>
	<1149564830.16247.11.camel@localhost.localdomain>
	<20060606080156.GA427@elte.hu>
	<1149591019.16247.35.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 06:50:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2006-06-06 at 10:01 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Hit the following BUG with irqpoll.  The below patch fixes it.
> > 
> > > -		if (work)
> > > +		if (work && disc->chip && desc->chip->end)
> > >  			desc->chip->end(i);
> > 

Why is this change necessary?  2.6.17-rc6 doesn't have it, and it doesn't
oops.  So somebody changed something.  What?  Why?  Was it intentional?  Was
it correct?

> 
> As for eio, could be.  This was part of my whole misroute thing which I
> didn't have time to get to deep in.  I'm leaving today, where I won't
> have any computers or Internet til next Wednesday or Thursday, so I'm
> not going to be able to work on this further till then.

If "could be" == "yes" then what would be the consequences of this
bug-which-were-not-sure-is-there-yet?
