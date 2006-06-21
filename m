Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWFUIUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWFUIUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWFUIUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:20:25 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:46252 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932483AbWFUIUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:20:23 -0400
Date: Wed, 21 Jun 2006 04:20:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2006, Esben Nielsen wrote:

>
> > I have to check, whether the priority is propagated when the softirq is
> > blocked on a lock. If not its a bug and has to be fixed.
>
> I think the simplest solution would be to add
>
>          if (p->blocked_on)
>                  wake_up_process(p);
>
> in __setscheduler().
>

Except that wake_up_process calls try_to_wakeup which grabs the runqueue
lock, which unfortunately is already held when __setscheduler is called.

-- Steve

