Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbQKNPaJ>; Tue, 14 Nov 2000 10:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbQKNP37>; Tue, 14 Nov 2000 10:29:59 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:65125 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129212AbQKNP3u>; Tue, 14 Nov 2000 10:29:50 -0500
Date: Tue, 14 Nov 2000 08:59:49 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil>
To: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josue Emmanuel Amaro <Josue.Amaro@oracle.com>:
> This subject came up in the Generalized Kernel Hooks Interface thread, since it
> is an area of interest to me I wanted to continue that conversation.
> 
> While I do not think it would be productive to enter a discussion whether there
> is a need to fork the kernel to add features that would be beneficial to
> mission/business critical applications, I am curious as to what are the features
> that people consider important to have.  By mission critical I mean systems that
> if not functional bring a business to a halt, while by business critical I mean
> systems that affect a division of a business.
>
> Another problem is how people define Enterprise Systems.  Many base it on the
> definitions that go back to S390 systems, others in the context of the 24/7
> nature of the internet.  That would also be a healthy discussion to have.
> 
> At Oracle we are primarily interested on I/O subsystem features and memory
> management.  (For anyone that knows anything about Oracle this should not come
> as a surprise, although I am pretty sure that any database vendor/developer
> would be interested on those features as well.)

I reformatted/phrased your questions above to allow for separate answers:

Q1. How do you define Enterprise Systems? Many base it on the definitions that
    go back to S390 systems, others in the context of the 24/7 nature of the
    internet.

1. The system should be available 24 hours a day, 7 days a week, 52 weeks a
   year :-), with time off for scheduled down time for maintenance and
   upgrades.

2. It should be possible to take down a node of a cluster without affecting
   the effectiveness of the other nodes. There is an expeced higher load on
   the remaining nodes during the time the node is missing.
3. It should be possible to add nodes to a cluster without affecting the
   effectiveness of the other nodes.

4. Unauthorized access to, modification to, or damage to the effectiveness of
   the system should be possible (the ideal...). All security related events
   should be audited and logged.

Q2. I am curious as to what are the features that people consider important to
    have.  By mission critical I mean systems that if not functional bring a
    business to a halt, while by business critical I mean systems that affect
    a division of a business.

1. Secure - Multi-level security (with compartmentalization) is needed to
   be able to detect unauthorized attempts to modify the system. There should
   be no all powerfull user. System updates should require three different
   authorizations (security, administrator, and auditor) to take effect when
   the system is on-line. All bets are off, of course, if the system is taken
   offline for such modifications - at that point, the administrator would
   be able to make any changes. The security administrator should validate
   the system in some manner. The system should not be able to be brought
   online without being validated.

   IPSec to provide controled encryption between hosts. Inclusion of CIPSO
   style extensions to allow for labeled network support. Virtical integration
   to include user identification tags as well. I would like to be able to
   identify the remote user, with confidence in that identity established
   by the confidence in the host, which is in turn established by IPSec.

   I (meaning me) would like the ability to audit every system call. (yes,
   this is horrendous, if everything is logged, but I want to be able to
   choose how much is logged at the source of the data, rather than at
   the destination. That would reduce the total data flood to what is
   manageable or desired.

   I realize that this is extreme - but in some environments this degree of
   control is necessary. It should be possible to downgrade this level of
   control to the point that is required for other environments.

2. Allow for full accounting of user resources - memory, cpu, disk, IO.

3. It should not be possible for a user to exceed the resource quotas
   established for the user. This control should be flexible enough to allow
   for exceeding some quotas if additional resources are available, but
   unused. (I'm considering memory resources and CPU time here. The user
   should be able to exceed memory quota, but with the understanding that
   the users processes will be trimmed down to the users quota limit if
   needed for other users.

4. Batch jobs, using a more common definition of batch than that used by
   the "batch" utility - job queues, with batch controled limits, job
   checkpointing/restart, resource allocation controls... Batch jobs
   should be able to migrate to other nodes/systems (as long as all other
   required resources are available ... This is HARD to do :-).

5. Allow for multiple scheduling types, preferably concurrently, but changable
   at runtime. Some real time, mostly batch and interactive.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
