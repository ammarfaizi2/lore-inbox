Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbSJIQ0S>; Wed, 9 Oct 2002 12:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSJIQ0S>; Wed, 9 Oct 2002 12:26:18 -0400
Received: from [212.18.235.100] ([212.18.235.100]:21432 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S261876AbSJIQ0R>; Wed, 9 Oct 2002 12:26:17 -0400
From: kernel@street-vision.com
Message-Id: <200210091630.g99GUXM11590@tench.street-vision.com>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
To: akpm@digeo.com (Andrew Morton)
Date: Wed, 9 Oct 2002 16:30:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DA33250.FB61BAAE@digeo.com> from "Andrew Morton" at Oct 08, 2002 12:30:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Robert Love wrote:
> > 
> > ...
> > 
> > Andrew, any experience on one vs. the other?
> 
> I'd say that if you were designing a new application which
> streams large amount of data then yes, you would design it
> to use O_DIRECT.  You would instantiate a separate IO worker
> thread and a message passing mechanism so that thread would
> pump your data for you, and would peform your readahead, etc.
> 
> If your filesystem supports O_DIRECT, of course.  Not all do.
> 
> The strength of O_STREAMING is that you can take an existing,
> working, megahuge application and make it play better with the
> VM by changing a single line of code.  No big redesign needed.

I think it will be a really big win on quite low speed machines streaming
at eg set top box speeds, without much memory (eg your Tivo).
O_DIRECT needs at least 4M reads to overcome lack of readahead,
so is only really useful if you are doing really big stuff (eg
uncompressed video). It is possible that O_STREAMING will be just as
good as this however, becasue there are latency issues with O_DIRECT
(you really need aio or multiple threads to sustain good readahead,
one test of mine needed 8 threads for optimal performance). I have
a bunch of things I could retest with O_STREAMING and large readahead.

O_DIRECT is always going to win for random access stuff though. It is
good to have a choice.

Justin
