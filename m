Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266743AbSIRO20>; Wed, 18 Sep 2002 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266754AbSIRO20>; Wed, 18 Sep 2002 10:28:26 -0400
Received: from holomorphy.com ([66.224.33.161]:10218 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266743AbSIRO2Z>;
	Wed, 18 Sep 2002 10:28:25 -0400
Date: Wed, 18 Sep 2002 07:28:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918142823.GT3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020918002240.GB2179@holomorphy.com> <Pine.LNX.4.44.0209181136180.2750-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181136180.2750-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 12:11:30PM +0200, Ingo Molnar wrote:
> so i think the most we could get is to actually eliminate the pidhash and
> use the idtag hash for it. This would concentrate all the performance
> efforts on the idtag hash.

I eventually had special-case handling of IDTAG_PID so that it did not
use idtags, but chained tasks directly, and removing the pidhash as goals.


On Wed, Sep 18, 2002 at 12:11:30PM +0200, Ingo Molnar wrote:
> another, locking improvement is possible as well:
>  - the idtag spinlock should be eliminated, we can reuse the tasklist lock
>    for it - in the exit and fork path we hold it already. This also means
>    we can walk an ID list by read-locking the tasklist lock.
> the idtag spinlock is already superfluous i think, because the idtag task
> list is only safely walked if we read-lock the task list. So it's not like
> anyone could hash in a new idtag while we walk the list.
> What do you think?

ISTR the idtag_lock was for cases where the hashtable was modified
while the tasklist_lock was only held for reading. Basically, once
those are resolved, the idtag_lock goes away.


Cheers,
Bill
