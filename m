Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVEaK7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVEaK7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVEaK7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:59:09 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:3240 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261801AbVEaK7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:59:02 -0400
Message-ID: <429C4112.2010808@andrew.cmu.edu>
Date: Tue, 31 May 2005 06:48:50 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com> <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au>
In-Reply-To: <429C2F72.7060300@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> I have never been in any doubt as to the specific claims I have
> made. I continually have been talking about hard realtime from
> start to finish, and it appears that everyone now agrees with me
> that for hard-RT, a nanokernel solution is better or at least
> not obviously worse at this stage.

It is only better in that if you need provable hard-RT *right now*, then 
you have to use a nanokernel.  The RT patch doesn't provide guaranteed 
hard-RT yet[1], but it may in the future.  Any RT application programmer 
would rather write for a single image system than a split kernel.  So if 
it does eventually provide hard-RT, just about every new RT application 
will target it (due to it being easier to program for).  In addition it 
radically improves soft-RT performance *now*, which a nanokernel doesn't 
help with at all.  "Best" would be getting preempt-RT to become 
guaranteed hard-RT, or if that proves impossible, to have a nanokernel 
in addition to preempt-RT's good statistical soft-RT guarantees.

I think where we violently disagree is that in your earlier posts you 
seemed to imply that a nanokernel hard-RT solution obviates the need for 
something like preempt-RT.  That is not the case at all, and at the 
moment they are quite orthogonal.  In the future they may not be 
orthogonal, because *if* preempt-RT patch becomes guaranteed hard-RT, it 
would pretty much relegate nanokernels to only those applications 
requiring formal verification.

  - Jim Bruce

P.S. Preempt-RT is a sight to behold while updatedb is running.  The 
difference between it and ordinary preempt is quite impressive.  Nothing 
currently running has so much as a hiccup, even though / is using the 
non-latency-friendly ReiserFS.  The only way I even notice updatedb is 
running at all is through my CPU monitor and the fact that disk IO is 
slower.

[1] By this I mean on a system loaded with low priority tasks doing the 
relatively arbitrary things one might do on a live system.
