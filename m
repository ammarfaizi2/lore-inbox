Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUIPWz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUIPWz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUIPWzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:55:54 -0400
Received: from mail.tmr.com ([216.238.38.203]:40709 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268301AbUIPWzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:55:16 -0400
Date: Thu, 16 Sep 2004 18:48:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] inotify 0.9
In-Reply-To: <4149BEDA.9020307@nortelnetworks.com>
Message-ID: <Pine.LNX.3.96.1040916183454.20906C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Chris Friesen wrote:

> Bill Davidsen wrote:
> 
> > If I were doing this, and I admit I may not understand all of the 
> > features, I would have a bitmap per filesystem of inodes being watched, 
> > and anything which did an action which might require notify would check 
> > the bit. If the bit were set the filesystem and inode info would be 
> > passed to user space which could do anything it wanted.
> 
> How do you identify the filesystem?  Whose mount namespace do you use if you 
> have multiple processes in different namespaces watching what is really the same 
> file?

You're asking for implementation details on something I threw out off the
top of my head? My first thought is "not by name" since if this is an
unmount that's not going to work well. Since I'm making this up, let's say
a filesysem number and inode number. Then when the watch is set the system
just has to have a unique "filesystem number" identifier which is shared
by every watch request against the f/s.

I haven't looked at how the original proposal handles things like the same
f/s mounted multiple times, etc, so I wouldn't venture to improve on it.
If I were actually going to write something like this, I'd want to start
with a description of functional requirements and response time, and go
from there, trying to move as much as possible out of unpageable memory.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

