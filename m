Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSIER5p>; Thu, 5 Sep 2002 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSIER5p>; Thu, 5 Sep 2002 13:57:45 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:3346 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318007AbSIER5o>; Thu, 5 Sep 2002 13:57:44 -0400
Message-ID: <3D779BAA.BAA5A742@zip.com.au>
Date: Thu, 05 Sep 2002 11:00:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <3D7785B4.A35C9BC8@zip.com.au> <Pine.LNX.4.33.0209051003210.1383-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> A fast disk driver will _never ever_ do a partial request completion. A
> high-performance subsystem will put in the scatter-gather list and say
> "go" to the controller, and the controller will send exactly one interrupt
> back when it is all done.

OK.  But still, I don't see why we need partial BIO completions.  If
we say that the basic unit of completion is a whole BIO, then readahead
can then manage latency via the outgoing bio size.
 
> So for such a system, you'd never see partial completions anyway.
> 
> Partial completions are a feature of slow hardware. And slow hardware is
> exactly when we want to know about it.

Well I'd be interested in knowing specifically what is wrong with the
behaviour of 2.5.33 against a floppy disk.

In the testing I did a few weeks back, everything checked out.  An
application which was reading the raw device at 95% of media bandwidth
never blocked.  An application which was capable of processing data at
120% of media bandwidth achieved 100%.

It could be that the initial 64k read at the start-of-file is
too big, and the many-small-file behaviour is poor?

A specific "this sucks" testcase would be helpful...
