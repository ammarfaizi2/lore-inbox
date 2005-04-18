Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVDRHiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVDRHiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVDRHiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:38:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37626 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261877AbVDRHh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:37:56 -0400
Subject: Re: FUSYN and RT
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20050418053042.GA11399@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	 <1113352069.6388.39.camel@dhcp153.mvista.com>
	 <1113407200.4294.25.camel@localhost.localdomain>
	 <20050415225137.GA23222@nietzsche.lynx.com>
	 <16992.20513.551920.826472@sodium.jf.intel.com>
	 <20050418053042.GA11399@nietzsche.lynx.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 00:37:54 -0700
Message-Id: <1113809874.6379.8.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-17 at 22:30 -0700, Bill Huey wrote:
> On Fri, Apr 15, 2005 at 04:37:05PM -0700, Inaky Perez-Gonzalez wrote:
> > By following your method, the pi engine becomes unnecesarily complex;
> > you have actually two engines following two different propagation
> > chains (one kernel, one user). If your mutexes/locks/whatever are the
> > same with a different cover, then you can simplify the whole
> > implementation by leaps.
> 
> The main comment that I'm making here (so it doesn't get lost) is that,
> IMO, you're going to find that there is a mismatch with the requirements
> of Posix threading verse kernel uses. To drop the kernel mutex in 1:1 to
> back a futex-ish entity is going to be problematic mainly because of how
> kernel specific the RT mutex is (or any future kernel mutex) for debugging,
> etc... and I think this is going to be clear as it gets progressively
> implemented.
> 

PI behavior is pretty well spec'd out at this point, but its possible
to assume that no userspace locks are taken after the first kernel
lock is locked, and that the task exits the kernel without holding any
kernel locks. That makes it easier to think about, and from that
perspective, I see no complications with the transitive PI across
the user / kernel boundary.

If a userspace task has RT priority, it should be able to bump along
lower priority kernel tasks, whether they (or it) are holding any user
mutexes, or not. 

> I think folks really need to think about this clearly before moving into
> any direction prematurely. That's what I'm saying. PI is one of those
> issues, but ultimately it's the fundamental differences between userspace
> and kernel work.
> 

Bill, we are really trying to do this right, open, on the table.

This is an open invitation to anyone interested to get on the line
with us on Wednesday. Get the info for the FREE call here:

http://developer.osdl.org/dev/mutexes/


> LynxOS (similar threading system) keep priority calculations of this kind
> seperate between user and kernel space. I'll have the ask one of our
> engineers here why again that's the case, but I suspect it's for the
> reasons I've discussed previously.

Let us know, if its possible to disclose that info.

Sven


