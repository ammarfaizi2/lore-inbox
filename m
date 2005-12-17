Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVLQRoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVLQRoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 12:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVLQRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 12:44:20 -0500
Received: from mx1.suse.de ([195.135.220.2]:17608 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932616AbVLQRoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 12:44:19 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
	<20051216141002.2b54e87d.diegocg@gmail.com>
	<20051216140425.GY23349@stusta.de>
	<20051216163503.289d491e.diegocg@gmail.com>
	<632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
From: Andi Kleen <ak@suse.de>
Date: 17 Dec 2005 18:44:07 +0100
In-Reply-To: <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
Message-ID: <p73slsrehzs.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Dec 16, 2005, at 10:35, Diego Calleja wrote:
> > I know, but there's too much resistance to the "pure" 4kb patch.
> 
> I have yet to see any resistance to the 4Kb patch this time around
> that was not "*whine* don't break my ndiswrapper plz".  

My comment from last time about the missing safety net still applies 100%.

Kernel code is getting more complex all the time and running with
very tight stack is just risky.

> The point is to force it in -mm so most people can't just disable it
> because it fixes their problem.  We want 8k stacks to go away, and

Who is we? And why? 

About the only half way credible arguments I've seen for it were:  

- "it might reduce stalls in the VM with order 1". Didn't quite
convince me because there were no numbers presented and at least on
x86-64 I've never noticed or got reported significant stalls because
of this.

- "it allows more threads for 32bit which might run out of lowmem" - i
think everybody agrees that the 10k threads case is not really
something to encourage. And even when you want to add it then only a factor
two increase (which this patch brings) is not really too helpful.

The main argument thrown around seems to be "but it will break
binary only modules" - while I'm not fully unsympathetic I don't
think technical issues in the kernel should be guided by 
such political considerations.

I suspect you will be reposting it so often till the voices
of reasons get tired? 

-Andi
