Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTDAWAs>; Tue, 1 Apr 2003 17:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTDAWAs>; Tue, 1 Apr 2003 17:00:48 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:17900 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S262871AbTDAWAq>;
	Tue, 1 Apr 2003 17:00:46 -0500
Date: Wed, 2 Apr 2003 00:19:27 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030401221927.GA8904@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401164126.GA993@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 08:41:26AM -0800, William Lee Irwin III wrote:
> On Tue, Apr 01, 2003 at 02:51:59PM +0200, Antonio Vargas wrote:
> +
> +	if(fairsched){
> +		/* special processing for per-user fair scheduler */
> +	}
> 
> I suspect something more needs to happen there. =)

 :) I haven't even compiled with this patch, I'm just trying
to get around my ideas and thus I posted so that:

a. We had an off-site backup

b. People with experience could shout out loud if they saw
   some big-time silliness.

> I'd recommend a different approach, i.e. stratifying the queue into a
> user top level and a task bottom level. The state is relatively well
> encapsulated so it shouldn't be that far out.
> 
> 
> -- wli

I suspect you mean the scheduler runqueues?

My initial idea runs as follows:

a. On each array switch, we add some fixed value
   to user->ticks. (HZ perhaps?)

b. When adding, we cap at some maximum value.
   (2*HZ perhaps?)

c. On each timer tick, we decrement current->user->ticks.

d. When decrementing, if it's below zero we just
   end this thread. (user has expired)

e. When switching threads, we take the first one that belongs
   to a non-expired user. I think this can be done by sending
   the user-expired threads to the expired array, just like
   when they expire themselves.

I'll try to code this tonight, so I'll post later on
if I'm lucky.

I think this needs much less complexity for a first version,
but I would try what you propose if I get intimate enough
with the scheduler.

Greets, Antonio.
