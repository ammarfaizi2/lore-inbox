Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSHHTUx>; Thu, 8 Aug 2002 15:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317879AbSHHTUx>; Thu, 8 Aug 2002 15:20:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30906 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317878AbSHHTUv>; Thu, 8 Aug 2002 15:20:51 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <OF107F9BDE.0B57DFBC-ON85256C0F.00669FD0-85256C0F.00681292@us.ibm.com>
References: <OF107F9BDE.0B57DFBC-ON85256C0F.00669FD0-85256C0F.00681292@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Aug 2002 14:18:55 -0500
Message-Id: <1028834336.19434.327.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 13:56, Hubertus Franke wrote:
> (a) Vanilla version which breaks down after 22K pids and 
> really sucks above 32.5K
> (b) Bill Irwin's, which keeps track of which PID is free and 
> which one is not ?
> (c) Andrea's patch which searches in the bitmap when we are 
> running out
> (d) Paul's patch, which I believe was based on one of my earlier 
> submission (03/02) that essentially switches between (a)+(c) at 
> the break even point.

> I feel (c) or (d) is a better solution over (a) and (b)...   Open for
> discussion.
> I have a test program that does the random pid deletion and pid allocation
> in user space. All what's required is to copy the get_pid() code from the
> kernel into there... Can make that available ...
> 
> I don't know what Paul has done to the patch since then ....

It's pretty much the same, with a couple of small changes.  After
forward porting your patch and the one from AA's patches (hch says that
one was actually done by Ihno Krumreich, thanks for the info), I added
the fix from (c) for the race, and moved the check for if(flags &
CLONE_IDLETASK) outside of get_pid into copy_process() since there's no
need to call get_pid and return just to find out that we need to use 0.

-Paul Larson

