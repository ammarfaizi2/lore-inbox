Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTFRKnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTFRKnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:43:01 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:33034 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265136AbTFRKm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:42:59 -0400
Date: Wed, 18 Jun 2003 13:02:18 +0200
To: Yaroslav Rastrigin <yarick@relex.ru>
Cc: linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like  Windows!
Message-ID: <20030618110218.GA2037@hh.idb.hist.no>
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no> <200306181330.48072.yarick@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306181330.48072.yarick@relex.ru>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 01:30:48PM +0400, Yaroslav Rastrigin wrote:
[...]
> Well, the problem is probably unsolvable on kernel level (kernel is unaware of 
> user's habits in app/mem usage), but I think it's pretty solvable on user 
> level - give us a knob to tune VM's behavior. We mere mortals often know 
> better how we will use our system's memory, and which apps we will be 
> running. 

There are some knobs.  There's the mlock call that disables
paging for whatever memory you want.  

xmms could easily stop skipping if it mlocks its own code
and data.  Running it at elevated priority might also
be a good idea, so cpu hogs don't starve it.

Both of these needs root pribileges, or at least a suid
binary.  (The priority stuff _can_ be done without extra
privileges by nicing every _other_ process instead.)

> I, for myself, like laptop-mode patch (basically, it groups disk 
> writes to do them once in 5-10 minutes, thus allowing hdd to sleep a lot) 
> very much - when I'm on AC, most probably I'm in office , and turning it off 
> is reasonable. When I'm on battery, though, chances are I won't be compiling 
> the kernel and/or do other heavy disk IO, instead, I most likely will be 
> coding, so echo 1 >/proc/sys/vm/laptop_mode seems appropriate, reasonable and 
> useful. 
> Could something like this be done with VM/swap policy ? 
> 
Sure.  Take a look at /proc/sys/vm/swappiness for example.
More stuff like this can be made - by those interested.

The original poster also fixed the problems by doing
swapoff -a ; swapon -a 
after quitting a memory hog.  That can be automated
with a little cron script that parses the output
of free or vmstat and do this trick whenever
free memory exceed the amount in swap.

Helge Hafting


