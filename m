Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275866AbSIURAV>; Sat, 21 Sep 2002 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275880AbSIURAV>; Sat, 21 Sep 2002 13:00:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45067 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275866AbSIURAU>; Sat, 21 Sep 2002 13:00:20 -0400
Date: Sat, 21 Sep 2002 10:06:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: quadratic behaviour
In-Reply-To: <20020921125626.GA15603@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209210958080.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Sep 2002, Andries Brouwer wrote:
> > 
> > So, why do you think this problem has been fixed?
> 
> Let me repeat this, and call it an observation instead of a question,
> so that you do not think I am in doubt.

The reason Ingo thinks it is fixed is that it is fixed for the case of 
having millions of threads - because the threads (with the new thread 
library) won't show up on the "for_each_process()" loop. Which makes 
threaded apps look a lot better on ps and top (we'll have to expose them 
some day under /proc/<pid>/thread/<tid>/, but that's another matter)

But the quadratic behaviour wrt processes clearly isn't fixed. Suggestions
welcome (and we'll need to avoid the same quadratic behaviour wrt the
threads when we expose them).

The only "obvious" thing to do is to insert markers into the process list,
and have "for_each_process()" automatically skip the marker entries. There
probably wouldn't be all that many things that would ever notice if that
were done (excatly because most things that want to traverse the list use
"for_each_process()" already). And then instead of using "index", you 
carry the marker thing around...

		Linus

