Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbTFRIDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbTFRIDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:03:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:18951 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265097AbTFRIDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:03:17 -0400
Message-ID: <3EF0214A.3000103@aitel.hist.no>
Date: Wed, 18 Jun 2003 10:22:34 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: rmoser <mlmoser@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
 Windows!
References: <200306172030230870.01C9900F@smtp.comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmoser wrote:
[...]
> Ten minutes later I get the brains to run top.  It seems I have about
> 50 MB in swap, and 54 MB free memory.  So I wait ten minutes more.
> 
> No change.
> 
> % swapoff -a; swapon -a
> 
> Fixes all my problems.
> 
> Now this long story shows something:  The kernel appears to be unable
> to intelligently pull swap back into RAM.  What gives?
> 
Because the problem _is_ unsolvable.  You want the kernel
to go "oh, lots of free memory showed up, lets pull
everything in from swap just in case someone might need it."


That would solve _your_ problem.  But lots of other people
would get another problem - much _more_ swapping:

Whenever they quit one big app to run another big one,
everything is pulled in from swap before the next
big app start.  Then it starts, and push everything out
again.  The current system lets you quit one app,
the stuff in swap remains there until someone actually use it,
and lots of free memory remain in case it is needed.


The "intelligent" thing is to leave stuff in swap until
some app needs it, and pull it in then.  Perhaps with
some read-ahead/clustering to minimize io load.

It is simply impossible to know "what" the
next thing we will need from swap will be, and what
stuff won't ever be needed from swap.  The memory
might be putr to better uses, such as:
1. New programs/allocations can start without
    having to push something out first
2. file cache for io-intensive apps.

Note that reading from swap is very much like reading
from executable files - it is done when needed.
We donæ't normally pre-read every executable
on the system when there is free memory just
in case someone might want to run a program,
the same applies to swap.

Helge Hafting

