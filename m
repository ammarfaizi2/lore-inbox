Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275917AbSIURhH>; Sat, 21 Sep 2002 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275925AbSIURhG>; Sat, 21 Sep 2002 13:37:06 -0400
Received: from holomorphy.com ([66.224.33.161]:28813 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275917AbSIURhF>;
	Sat, 21 Sep 2002 13:37:05 -0400
Date: Sat, 21 Sep 2002 10:35:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: quadratic behaviour
Message-ID: <20020921173531.GQ3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20020921125626.GA15603@win.tue.nl> <Pine.LNX.4.44.0209210958080.2702-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209210958080.2702-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Andries Brouwer wrote:
>> Let me repeat this, and call it an observation instead of a question,
>> so that you do not think I am in doubt.

On Sat, Sep 21, 2002 at 10:06:02AM -0700, Linus Torvalds wrote:
> The reason Ingo thinks it is fixed is that it is fixed for the case of 
> having millions of threads - because the threads (with the new thread 
> library) won't show up on the "for_each_process()" loop. Which makes 
> threaded apps look a lot better on ps and top (we'll have to expose them 
> some day under /proc/<pid>/thread/<tid>/, but that's another matter)
> But the quadratic behaviour wrt processes clearly isn't fixed. Suggestions
> welcome (and we'll need to avoid the same quadratic behaviour wrt the
> threads when we expose them).

Okay, I'm in trouble. My end-users use processes. But /proc/ needs some
more tweaking before they can use it during larger runs anyway.


On Sat, Sep 21, 2002 at 10:06:02AM -0700, Linus Torvalds wrote:
> The only "obvious" thing to do is to insert markers into the process list,
> and have "for_each_process()" automatically skip the marker entries. There
> probably wouldn't be all that many things that would ever notice if that
> were done (excatly because most things that want to traverse the list use
> "for_each_process()" already). And then instead of using "index", you 
> carry the marker thing around...

This also sounds like an excellent idea. I may take a stab at this.


Thanks,
Bill
