Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVBYUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVBYUXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVBYUXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:23:00 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:17671 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261297AbVBYUW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:22:58 -0500
Date: Fri, 25 Feb 2005 21:25:43 +0100
To: "Chad N. Tindel" <chad@tindel.net>
Cc: Paulo Marques <pmarques@grupopie.com>, Chris Friesen <cfriesen@nortel.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050225202543.GA1249@hh.idb.hist.no>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050224192237.GA31894@calma.pair.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 02:22:37PM -0500, Chad N. Tindel wrote:
> > If you keep a learning attitude, there is a chance for this discussion 
> > to go on. However, if you keep the "Come now, don't bullshit me, this is 
> > a broken architecture and you're just trying to cover up" attitude, 
> > you're just going to get discarded as a troll.
> 
> I'm not trying to troll here; I suppose I'm just coming from a different 
> background.  I'll try to adjust my tone.
> 
> > I personally like the linux way: "root has the ability to shoot himself 
> > in the foot if he wants to". This is my computer, damn it, I am the one 
> > who tells it what to do.
> 
> I'm all for allowing people to shoot themselves in the foot.  That doesn't
> mean that it is OK for a single userspace thread to mess up a 64-way box.
> 
What's so special about a 64-way box?

Note that the box wasn't messed up - the thread merely used too much cpu.  It 
is perfectly ok - even on a 64-way box - to have a thread that runs with 
higher priority than all the kernel threads - *�if* it occationally sleeps.  
That means the thread can get very low latency work done, and the kernel 
threads will simply wait a little.  Then the thread sleeps, and those 
cruical kernel  threads move on.  A high-priority thread that doesn't 
run all the time is no problem. and it may need the ability to preempt
kernel threads occationally due to timing constraints.  

In the case mentioned, the high-priority thread ran all the time.  That's bad, 
but there is no way the kernel can guess that is was a bad idea in that case.  
The kernel does what it is told.  An ordinary user can�'t use such priorities,
so there is no security problem here.  Only root can, and root has the
power to disrupt service anyway (shutdown, kill any process, delete any file.)

Someone who runs as root is _trusted_ to do the right thing, this trust
might be outside the scope of the os.  In other words, some people are
allowed to run special processes, by the machine owner.  Some gets
the root password - and they are supposed to be above the "crowds" and
not crash the machine just because they can.

Helge Hafting

