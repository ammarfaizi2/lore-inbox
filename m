Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVBZLzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVBZLzj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 06:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVBZLzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 06:55:38 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:42505 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261176AbVBZLza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 06:55:30 -0500
Date: Sat, 26 Feb 2005 12:58:17 +0100
To: "Chad N. Tindel" <chad@tindel.net>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Paulo Marques <pmarques@grupopie.com>,
       Chris Friesen <cfriesen@nortel.com>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050226115817.GA17730@hh.idb.hist.no>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com> <20050225202543.GA1249@hh.idb.hist.no> <20050225210225.GA89109@calma.pair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225210225.GA89109@calma.pair.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 04:02:26PM -0500, Chad N. Tindel wrote:
> > What's so special about a 64-way box?
> 
> They're expensive and customers don't expect a single userspace thread to
> tie up the other 63 CPUs no matter how buggy it is.  It is intuitively obvious
> that a buggy kernel can bring a system to its knees, but it is not intuitively
> obvious that a buggy userspace app can do the same thing.  It is more of a 
> supportability issue than anything, because you expect the other processors
> to function properly so you can get in and live-debug the application when it
> hits a bug that makes it CPU-bound.  This is especially important if the box 
> is, say, in a remote jungle of China or something where you don't have access 
> to the console.
> 
These are very good points.  And the solution exists - if you want these
options then simply run the program at a lower priority than the
kernel threads.  Doing this is not a problem. 

You _can_ run a process at highest priority, but you don't have to!

> The horse is dead, so lets not beat it anymore for the time being.  It is 
> quite clear that people don't want Linux to (by default) not have the gun
> cocked and pointed at the application developer's feet.

Linux is safe, and you bring up a non-issue.  So what if the app couldn't
get higher priority than kernel threads?  You could then implement
it as a kernel thread and get the same problem anyway. No difference.

>  People who want a 
> kernel that doesn't hang in the face of bad-acting userspace apps can change
> the priority of important kernel threads, which seems like a reasonable 
> workaround for now.
> 
Yes, or they can simply run the app at a slightly lower priority until
it is fully tested so they know it can be trusted.  

People sometimes need to not be delayed by kernel threads, and that
is not a problem as long as the application gives up the cpu after
it finishes doing the time-critical work.  We want linux to be
able to do these kinds of work too.

saying that the os doesn't have control does not make sense.  The
os will give away a cpu - but only if _you_ let it.

Helge Hafting
