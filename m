Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSICDnb>; Mon, 2 Sep 2002 23:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSICDnb>; Mon, 2 Sep 2002 23:43:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318641AbSICDn3>; Mon, 2 Sep 2002 23:43:29 -0400
Date: Mon, 2 Sep 2002 20:55:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: aebr@win.tue.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <UTC200209030053.g830r9b16219.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0209022051540.1332-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002 Andries.Brouwer@cwi.nl wrote:
> 
> Why?
> Because in some cases it is undesirable.

Again, Why?

You can always use the flat device as-is. 

> Because in some cases it crashes the kernel.

But moving it to user space would cause the kernel to crash anyway. Bugs 
are bugs.

> Because it involves guessing and heuristics.

The same guesses and heuristics would have to be in user space. 

> Because policy belongs in user space.

It's not policy. It's a fact of life that disks need to be split up into 
parts, and the partitioning schemes are well-defined and shared across 
multiple operating systems.

> Yes - that is my main point: doing it on demand. On demand only.

But I actually _agree_ with this. 

However, that has nothing to do with whether it is in user space or kernel 
space. In many ways it is _easier_ to do on demand in kernel space: when 
somebody opens /dev/sda1 and it isn't partitioned yet, you know it needs 
to be. 

The fact that partitioning right now is to some degree handled by device
drivers is a problem, but that's not a user space vs kernel space issue.
It's slowly getting moved to higher levels.

		Linus

