Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUKFMxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUKFMxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbUKFMxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:53:37 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:35594 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261380AbUKFMxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:53:22 -0500
Date: Sat, 6 Nov 2004 13:53:17 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer ...
Message-ID: <20041106125317.GB9144@pclin040.win.tue.nl>
References: <20041105200118.GA20321@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105200118.GA20321@logos.cnet>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 06:01:18PM -0200, Marcelo Tosatti wrote:

> My wife is almost killing me, its Friday night and I've been telling her
> "just another minute" for hours. Have to run.

:-)

> As you know the OOM is very problematic in 2.6 right now - so I went
> to investigate it.

I have always been surprised that so few people investigated
doing things right, that is, entirely without OOM killer.
Apparently developers do not think about using Linux for serious work
where it can be a disaster, possibly even a life-threatening disaster,
when any process can be killed at any time.

Ten years ago it was a bad waste of resources to have swapspace
lying around that would be used essentially 0% of the time.
But with todays disk sizes it is entirely feasible to have
a few hundred MB of "unused" swap space. A small price to
pay for the guarantee that no process will be OOM killed.

A month ago I showed a patch that made overcommit mode 2
work for me. Google finds it in http://lwn.net/Articles/104959/

So far, nobody commented.

This is not in a state such that I would like to submit it,
but I think it would be good to focus some energy into
offering a Linux that is guaranteed free of OOM surprises.

So, let me repeat the RFC.
Apply the above patch, and do "echo 2 > /proc/sys/vm/overcommit_memory".
Now test. In case you have no, or only a small amount of swap space,
also do "echo 80 > /proc/sys/vm/overcommit_ratio" or so.

Andries
