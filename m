Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265424AbUEZK26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbUEZK26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUEZK26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:28:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13952 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265424AbUEZK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:28:51 -0400
Date: Wed, 26 May 2004 11:35:53 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405261035.i4QAZrGo000803@81-2-122-30.bradfords.org.uk>
To: Roger Luethi <rl@hellgate.ch>
Cc: Anthony DiSante <orders@nodivisions.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040526093007.GA4324@k3.hellgate.ch>
References: <40B43B5F.8070208@nodivisions.com>
 <20040526082712.GA32326@k3.hellgate.ch>
 <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk>
 <20040526093007.GA4324@k3.hellgate.ch>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Roger Luethi <rl@hellgate.ch>:
> On Wed, 26 May 2004 10:23:32 +0100, John Bradford wrote:
> > A run-away process on a server with too much swap can cause it to grind to
> > almost a complete halt, and become almost compltely unresponsive to remote
> > connections.
> > 
> > If the total amount of storage is just enough for the tasks the server is
> > expected to deal with, then a run-away process will likely be terminated
> > quickly stopping it from causing the machine to grind to a halt.
> 
> I'm not sure your optimism about the correct (run-away) process being
> terminated is justified. Granted, there are definitely scenarios
> where swapless operation is preferable, but in most circumstances --
> especially workstations as the original poster described -- I'd rather
> minimize the risk of losing data.

Well, I am basing this on experience.  I know an ISP who had their main
customer webserver down for hours because of this kind of problem - the whole
thing created a lot of work and wasted a lot of time.

In this particular scenario, I think the run-away process was probably using
up almost two thirds of the total RAM, so I'm pretty confident the correct
process would have been terminated.

I know that trusting the kernel to terminate the correct run-away process
might seem like a bit of a risky approach to take with respect to
loosing data, especially where a little bit of swap space might come to the
rescue.

However, in my opinion, if a machine has insufficient storage for the intended
task then that's an error condition straight away.  So, I am not really
concerned with trying to make sure that a desktop system running an
application which the user has underestimated the memory usage of doesn't crash
no matter what.  The machine is operating in an error condition, so data loss
should be expected.

No, I am more concerned about preventing unexpected usage of a machine from
causing large scale slowdowns, and unavailability to other users.

For example, if a run-away process occurs, or one user on a multi-user system
uses up excessive resources.

Excessive swap space might create an illusion of protecting against data loss,
by allowing things to continue working no matter what, just a bit slower, but
for multi user systems, it's preventing normal usage of the system.  This can
indirectly lead to data loss if the machine is not accessible over the network
to perform a critical function.

Ultimately, once a machine is spending 99% of it's time swapping, it's likely
to be well past the point where it's practical to log in remotely and fix it.

However, I think that there are probably more machines using excessive swap
which would benefit from reducing it, than the other way round, though, simply
because users are not as aware of the potential problems.

My opinion was that the machine was already in an error condition the minute
I couldn't access it remotely - a significant number of customer's webpages
were inaccessible, which potentially means lost business for them.

I assume that the scenario you were thinking of when you mentioned data loss
above was a system running a critical process which is using, for example,
90% of the available storage - in that case if another process starts up, and
uses up the rest of the available storage, then the first process will probably
be terminated, whereas if you increase the amount of storage, (either by adding
swap or physical RAM), then the second process can continue for longer.

However, in this situation, I can see two possibilities - either the second
process is genuine, (I.E. not a run-away process), in which case the machine
has insufficient storage for it's intended purpose, which is an operator error
in my opinion, or the process is a run-away process, in which case a little
extra storage isn't going to do much other than buy time before the first
process is terminated.  This may give an operator chance to log in and fix
the problem, (probably by terminating the run-away process), but if this extra
storage is swap space, the machine may well become unresponsive very quickly,
making it virtually impossible to log in remotely, and making other network
services on that machine virtually inaccessible.  Eventually the run-away
process may use up the swap space, and then the first process will probably
be terminated as before, just not as quickly.  If instead of a little extra
storage, a lot was added such that the first process was no longer using more
storage than the run-away process was when storage was full, then the kernel
will hopefully terminate the run-away process, but probably only after the
machine has been unresponsive for a long time, possibly causing other problems.

Basically, I would be skeptical about using a desktop system where one
terminated process could cause data loss to the extent that I couldn't easily
restore the data.

John.
