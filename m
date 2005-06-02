Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFBUaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFBUaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVFBUa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:30:26 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:53933 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261326AbVFBU2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:28:07 -0400
Date: Thu, 2 Jun 2005 22:27:28 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <1117733471.20350.2.camel@dhcp153.mvista.com>
Message-Id: <Pine.OSF.4.05.10506022017400.3853-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Jun 2005, Daniel Walker wrote:

> On Thu, 2005-06-02 at 17:18 +0200, Esben Nielsen wrote:
> 
> > Good :-)
> > I asked the question because I considered (and started but didn't
> > have time) doing what you have done. I wanted to generalise the rt_mutex
> > to have real rw_lock as well - which was dropped due to the
> > non-deterministc behavioir even with PI. To do that I needed to have the
> > recursion and the callback..
> 
> I'm not planning to do a real rw-lock, but I hope this generic PI will
> help with that. 

I came to the conclusion that an rw-lock would make all writers
non-deterministic. I had a small discussion on this list with Ingo about
it. He had also come to the same conclusion.

> I'm still not completely satisfied with this callback
> structure , but I don't see a better way to do it. Do you have an
> suggestions for replacing it?
>
No, I got stock there too.

But right now the following ideas spring to my mind:
If it is to solve the problem of having a callback wrap every use
in macroes and use the TYPE_EQUAL() to expclicit call the right function.
Only if the explicit type is unknown in the macro use the callback. That
should optimize stuff a little bit.. Just a wild idea.

If it is explicitly for PI you can do a thing like
 waiter->get_next_waiter();
to resolve the chain of waiters. Then you can have the PI algotithm work
iteratively without knowing the explicit kind of lock involved.


> Daniel
> 

Esben

