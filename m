Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbUDQXan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbUDQXan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:30:43 -0400
Received: from florence.buici.com ([206.124.142.26]:28288 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264074AbUDQXaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:30:39 -0400
Date: Sat, 17 Apr 2004 16:30:37 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Singer <elf@buici.com>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040417233037.GA15576@flea>
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417162125.3296430a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 04:21:25PM -0700, Andrew Morton wrote:
> Marc Singer <elf@buici.com> wrote:
> >
> >  I'd say that there is no statistically significant difference between
> >  these sets of times.  However, after I've run the test program, I run
> >  the command "ls -l /proc"
> > 
> >  				 swappiness
> >  			60 (default)		0
> >  			------------		--------
> >  elapsed time(s)		18			1
> >  			30			1
> >  			33			1
> 
> How on earth can it take half a minute to list /proc?

I've watched the vmscan code at work.  The memory pressure is so high
that it reclaims mapped pages zealously.  The program's code pages are
being evicted frequently.

I would like to show a video of the ls -l /proc command.  It's
remarkable.  The program pauses after displaying each line.

> >  This is the problem.  Once RAM fills with IO buffers, the kernel's
> >  tendency to evict mapped pages ruins interactive performance.
> 
> Is everything here on NFS, or are local filesystemms involved?  (What does
> "mount" say?)

    # mount
    rootfs on / type rootfs (rw)
    /dev/root on / type nfs (rw,v2,rsize=4096,wsize=4096,hard,udp,nolock,addr=192.168.8.1)
    proc on /proc type proc (rw)
    devpts on /dev/pts type devpts (rw)

I've been wondering if the swappiness isn't a red herring.  Is it
reasonable that the distress value (in refill_inactive_zones ()) be
50?

