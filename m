Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWFPLCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWFPLCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFPLCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:02:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41884 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751156AbWFPLCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:02:30 -0400
Message-ID: <44928FB1.5070107@sgi.com>
Date: Fri, 16 Jun 2006 13:02:09 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <200606160822.23898.ak@suse.de> <yq0ejxp2zzg.fsf@jaguar.mkp.net> <200606161209.25266.ak@suse.de>
In-Reply-To: <200606161209.25266.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> In the scientific application space, there are two very common
>> groupings of jobs.
> 
> The scientific users just use pinned CPUs and seem to be happy with that.
> They also have cheap slav^wgrade students to spend lots of time on
> manual tuning.  I'm not concerned about them. 

Do they? There's a lot of scientific sites out there which are not
universities or research organizations. They do not have free slave
labour at hand. A lot of users fall into this category, especially the
users with larger systems or large clusters (be it ia64, x86_64 or PPC).

> If you already use CPU affinity you should already know where you are and don't 
> need this call at all.

Except that whats currently available isn't sufficient to do what is
needed.

> So this clearly isn't targetted for them. 
>
> Interesting is getting the best performance from general purpose applications 
> without any special tuning. For them I'm trying to improve things.

Well I am interested in getting the best performance for some of the
same applications, without having to modify them. The current affinity
support simply isn't sufficient for that. Placement has to be targetted
at launch time since thread implementations can change the layout etc.

> Number one applications currently are databases and JVMs. I hope with 
> Wolfam's malloc work it will be useful for more applications too. 

If you want this to work for general purpose applications, then how is
this new syscall going to help? If you expect application vendors to
code for it, that means few users will benefit.

>> I really don't think this approach is going to solve the problem. As
>> Tony also points out, tasks will eventually migrate.
> 
> Currently we don't solve this problem with the standard heuristics.
> It can be solved with manual tuning (mempolicy, explicit CPU affinity)
> but if you're doing that you're already out side the primary use 
> case of vgetcpu().

This is another area where the kernel could do better by possibly using
the cpumask to determine where it will allocate memory.

> vgetcpu() is only trying to be a incremental improvement of the current
> simple default local policy.

As Tony rightfully pointed out, tasks do migrate. By making this guess
initially and then expecting the application to run for a long time,
you will end up with it having zero or possibly a negative effect.

>> The user needs to 
> 
> Scientific users do that, but other users normally not. I doubt that
> is going to change.

I just use scientific users since thats where I have the most recent
detailed data from. Databases could well benefit from what I mentioned,
though the serious ones would want to look into using affinity support
explicitly in their code.

Cheers,
Jes
