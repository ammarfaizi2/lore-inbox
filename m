Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319383AbSH3AfA>; Thu, 29 Aug 2002 20:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319461AbSH3AfA>; Thu, 29 Aug 2002 20:35:00 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:11535 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319383AbSH3Ae5>; Thu, 29 Aug 2002 20:34:57 -0400
Date: Thu, 29 Aug 2002 17:39:13 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020830003913.GC24307@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1030577178.7190.85.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208281633410.27728-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208281633410.27728-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 04:49:45PM -0700, Linus Torvalds wrote:
> 
> On 29 Aug 2002, Alan Cox wrote:
> > 
> > One of the policies I need from the kernel is "run at the frequency I
> > told you to run". Its a policy, its not the general case policy. The
> > /proc file is that policy.
> 
> That's ok, but the current code DOES NOT DO THAT.
> 
> The current code has no support at all for the notion of policies, and 
> gives absolutely _zero_ support for it. It blindly assumes that the CPU 
> can (and should) run at one frequency, and as long as it does that, I 
> don't want it in the kernel.
> 
> > cpufreq is cpu speed control not power management policy. I agree
> > entirely that most people should not be using echo "500" >/proc/... as a
> > power management policy. 
> > 
> > Likewise /dev/hda is not a file system and peopel should not be using dd
> > to store there files.
> 
> You've had that argument before, and it was bogus then - and it is bogus 
> now.
> 
> Exactly because some chips _need_ to have the policy passed down, the 
> lowest levels need to be able to pass it down.
> 
> It is _then_ ok to say that "if you do a 'echo 500 > /proc/cpu/freq', that
> will also imply a policy of a fixed frequency". But if the frequency
> setting code does not allow for any policy interface AT ALL, then it is
> fundamentally broken.
> 
> That's my beef with it. We should not have "generic" interfaces that are
> known to be fundamentally broken. As it is, the code - as designed - is
> useless for a growing class of devices.
> 
> Think of it as a layering issue:
>  - user level policy
>  - kernel interface (possibly many - for different policies)
>  - low-level driver
> 
> Ok?
> 
> Now, what the current patches do is (a) one kernel interface (the 
> fixed-frequency one) and (b) low-level drivers.
> 
> The kernel interface is fine - it doesn't do what I think many people 
> might want to do, but it's simple and I agree that other policies can be 
> implemented with other interfaces. Fine. 
> 
> But the fact that low-level drivers don't even support the notion of a 
> policy means that they are useless for any other interface. And I'm saying 
> that it's a clear design bug, and for no good reason. 

As a user (for the sake of argument) i don't want to see an
uneccesary proliferation of interfaces.  There is no reason
why the interface cannot be made policy aware from the
beginning even if it starts out only supporting the one
policy of fixed.

Something like 'echo "fixed 500M" >/proc/cpu/freak'
would allow the addition of new policies without having to
add new interfaces.  Notice that i give the policy as the
first parameter.  Each policy should register itself with
its callbacks (read, write, ?).

Probably should have a something like /proc/filesystems
that reports supported policies since supportable
policies would vary according to hardware + emulation.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
