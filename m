Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDDW6Z>; Wed, 4 Apr 2001 18:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDDW6Q>; Wed, 4 Apr 2001 18:58:16 -0400
Received: from cy57850-a.rdondo1.ca.home.com ([24.5.132.106]:19725 "HELO
	firewall.philstone.com") by vger.kernel.org with SMTP
	id <S132516AbRDDW6A>; Wed, 4 Apr 2001 18:58:00 -0400
Date: Wed, 04 Apr 2001 15:54:54 -0700
From: Christopher Smith <x@xman.org>
To: timw@splhi.com, Ingo Molnar <mingo@elte.hu>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
Message-ID: <18230000.986424894@hellman>
In-Reply-To: <20010404151632.A2144@kochanski>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, April 04, 2001 15:16:32 -0700 Tim Wright <timw@splhi.com> 
wrote:
> On Wed, Apr 04, 2001 at 03:23:34PM +0200, Ingo Molnar wrote:
>> nope. The goal is to satisfy runnable processes in the range of NR_CPUS.
>> You are playing word games by suggesting that the current behavior
>> prefers 'low end'. 'thousands of runnable processes' is not 'high end'
>> at all, it's 'broken end'. Thousands of runnable processes are the sign
>> of a broken application design, and 'fixing' the scheduler to perform
>> better in that case is just fixing the symptom. [changing the scheduler
>> to perform better in such situations is possible too, but all solutions
>> proposed so far had strings attached.]
>
> Ingo, you continue to assert this without giving much evidence to back it
> up. All the world is not a web server. If I'm running a large OLTP
> database with thousands of clients, it's not at all unreasonable to
> expect periods where several hundred (forget the thousands) want to be
> serviced by the database engine. That sounds like hundreds of schedulable
> entities be they processes or threads or whatever. This sort of load is
> regularly run on machine with 16-64 CPUs.

Actually, it's not just OLTP, anytime you are doing time sharing between 
hundreds of users (something POSIX systems are supposed to be good at) this 
will happen.

> Now I will admit that it is conceivable that you can design an
> application that finds out how many CPUs are available, creates threads
> to match that number and tries to divvy up the work between them using
> some combination of polling and asynchronous I/O etc. There are, however
> a number of problems with this approach:

Actually, one way to semi-support this approach is to implement 
many-to-many threads as per the Solaris approach. This also requires 
significant hacking of both the kernel and the runtime, and certainly is 
significantly more error prone than trying to write a flexible scheduler.

One problem you didn't highlight that even the above case does not happily 
identify is that for security reasons you may very well need each user's 
requests to take place in a different process. If you don't, then you have 
to implement a very well tested and secure user-level security mechanism to 
ensure things like privacy (above and beyond the time-sharing).

The world is filled with a wide variety of types of applications, and 
unless you know two programming approaches are functionaly equivalent (and 
event driven/polling I/O vs. tons of running processes are NOT), you 
shouldn't say one approach is "broken". You could say it's a "broken" 
approach to building web servers. Unfortunately, things like kernels and 
standard libraries should work well in the general case.

--Chris
