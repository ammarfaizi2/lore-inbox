Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRDQJYh>; Tue, 17 Apr 2001 05:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDQJY2>; Tue, 17 Apr 2001 05:24:28 -0400
Received: from [32.97.182.101] ([32.97.182.101]:51163 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132574AbRDQJYW>;
	Tue, 17 Apr 2001 05:24:22 -0400
Date: Tue, 17 Apr 2001 14:58:09 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
Message-ID: <20010417145809.A21310@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <20010409201311.D9013@in.ibm.com> <Pine.LNX.4.10.10104161140190.7022-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10104161140190.7022-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Mon, Apr 16, 2001 at 12:16:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

[I am not sure if my earlier mail from lycos went out or not, if
it did, I apologize]

On Mon, Apr 16, 2001 at 12:16:25PM -0400, Mark Hahn wrote:
> > The improvement in performance while runnig "chat" benchmark 
> > (from http://lbs.sourceforge.net/) is about 30% in average throughput.
> 
> isn't this a solution in search of a problem?
> does it make sense to redesign parts of the kernel for the sole
> purpose of making a completely unrealistic benchmark run faster?

Irrespective of the usefulness of the "chat" benchmark, it seems
that there is a problem of scalability as long as CLONE_FILES is
supported. John Hawkes (SGI) posted some nasty numbers on a
32 CPU mips machine in the lse-tech list some time ago.


> 
> (the chat "benchmark" is a simple pingpong load-generator; it is
> not in the same category as, say, specweb, since it does not do *any*
> realistic (nonlocal) IO.  the numbers "chat" returns are interesting,
> but not indicative of any problem; perhaps even less than lmbench
> components.)

"chat" results for large numbers of CPUs is indicative of a problem -
if a large number of threads share the file_struct through
CLONE_FILES, the performance of the application will deteriorate
beyond 8 CPUs (going by John's numbers). It also indicates how
sensitive can performance be to write access of shared-memory
locations like spin-waiting locks.


Thanks
Dipankar
-- 
Dipankar Sarma  (dipankar@sequent.com)
IBM Linux Technology Center
IBM Software Lab, Bangalore, India.
Project Page: http://lse.sourceforge.net
