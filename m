Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSFXV2V>; Mon, 24 Jun 2002 17:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSFXV2U>; Mon, 24 Jun 2002 17:28:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62207 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315285AbSFXV2Q>;
	Mon, 24 Jun 2002 17:28:16 -0400
Subject: Re: latest linus-2.5 BK broken
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE468962D.E4F46C96-ON88256BE2.00755AF2@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Mon, 24 Jun 2002 14:28:01 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 06/24/2002 03:28:05 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, Larry,

Our SMP cluster discussion was quite a bit of fun, very challenging!
I still stand by my assessment:

> The Score.
>
>      Paul agreed that SMP Clusters could be implemented.  He was not
>      sure that it could achieve good performance, but could not prove
>      otherwise.  Although he suspected that the complexity might be
>      less than the proprietary highly parallel Unixes, he was not
>      convinced that it would be less than Linux would be, given the
>      Linux community's emphasis on simplicity in addition to performance.

See you at Ottawa!

                                    Thanx, Paul


> Larry McVoy <lm@bitmover.com>
> Sent by: linux-kernel-owner@vger.kernel.org
> 06/19/2002 10:24 PM
>
> > I totally agree, mostly I was playing devils advocate.  The model
> > actually in my head is when you have multiple kernels but they talk
> > well enough that the applications have to care in areas where it
> > doesn't make a performance difference (There's got to be one of those).
>
> ....
>
> > The compute cluster problem is an interesting one.  The big items
> > I see on the todo list are:
> >
> > - Scalable fast distributed file system (Lustre looks like a
> >    possibility)
> > - Sub application level checkpointing.
> >
> > Services like a schedulers, already exist.
> >
> > Basically the job of a cluster scheduler gets much easier, and the
> > scheduler more powerful once it gets the ability to suspend jobs.
> > Checkpointing buys three things.  The ability to preempt jobs, the
> > ability to migrate processes, and the ability to recover from failed
> > nodes, (assuming the failed hardware didn't corrupt your jobs
> > checkpoint).
> >
> > Once solutions to the cluster problems become well understood I
> > wouldn't be surprised if some of the supporting services started to
> > live in the kernel like nfsd.  Parts of the distributed filesystem
> > certainly will.
>
> http://www.bitmover.com/cc-pitch
>
> I've been trying to get Linus to listen to this for years and he keeps
> on flogging the tired SMP horse instead.  DEC did it and Sun has been
> passing around these slides for a few weeks, so maybe they'll do it too.
> Then Linux can join the party after it has become a fine grained,
> locked to hell and back, soft "realtime", numa enabled, bloated piece
> of crap like all the other kernels and we'll get to go through the
> "let's reinvent Unix for the 3rd time in 40 years" all over again.
> What fun.  Not.
>
> Sorry to be grumpy, go read the slides, I'll be at OLS, I'd be happy
> to talk it over with anyone who wants to think about it.  Paul McKenney
> from IBM came down the San Francisco to talk to me about it, put me
> through an 8 or 9 hour session which felt like a PhD exam, and
> after trying to poke holes in it grudgingly let on that maybe it was
> a good idea.  He was kind of enough to write up what he took away
> from it, here it is.
>
> --lm
>
> From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
> To: lm@bitmover.com, tytso@mit.edu
> Subject: Greatly enjoyed our discussion yesterday!
> Date: Fri, 9 Nov 2001 18:48:56 -0800
>
> Hello!
>
> I greatly enjoyed our discussion yesterday!  Here are the pieces of it
that
> I recall, I know that you will not be shy about correcting any errors and
> omissions.
>
>                          Thanx, Paul
>
> Larry McVoy's SMP Clusters
>
> Discussion on November 8, 2001
>
> Larry McVoy, Ted T'so, and Paul McKenney
>
>
> What is SMP Clusters?
>
>      SMP Clusters is a method of partioning an SMP (symmetric
>      multiprocessing) machine's CPUs, memory, and I/O devices
>      so that multiple "OSlets" run on this machine.  Each OSlet
>      owns and controls its partition.  A given partition is
>      expected to contain from 4-8 CPUs, its share of memory,
>      and its share of I/O devices.  A machine large enough to
>      have SMP Clusters profitably applied is expected to have
>      enough of the standard I/O adapters (e.g., ethernet,
>      SCSI, FC, etc.) so that each OSlet would have at least
>      one of each.
>
>      Each OSlet has the same data structures that an isolated
>      OS would have for the same amount of resources.  Unless
>      interactions with the OSlets are required, an OSlet runs
>      very nearly the same code over very nearly the same data
>      as would a standalone OS.
>
>      Although each OSlet is in most ways its own machine, the
>      full set of OSlets appears as one OS to any user programs
>      running on any of the OSlets.  In particular, processes on
>      on OSlet can share memory with processes on other OSlets,
>      can send signals to processes on other OSlets, communicate
>      via pipes and Unix-domain sockets with processes on other
>      OSlets, and so on.  Performance of operations spanning
>      multiple OSlets may be somewhat slower than operations local
>      to a single OSlet, but the difference will not be noticeable
>      except to users who are engaged in careful performance
>      analysis.
>
>      The goals of the SMP Cluster approach are:
>
>      1.   Allow the core kernel code to use simple locking designs.
>      2.   Present applications with a single-system view.
>      3.   Maintain good (linear!) scalability.
>      4.   Not degrade the performance of a single CPU beyond that
>           of a standalone OS running on the same resources.
>      5.   Minimize modification of core kernel code.  Modified or
>           rewritten device drivers, filesystems, and
>           architecture-specific code is permitted, perhaps even
>           encouraged.  ;-)
>
>
> OS Boot
>
>      Early-boot code/firmware must partition the machine, and prepare
>      tables for each OSlet that describe the resources that each
>      OSlet owns.  Each OSlet must be made aware of the existence of
>      all the other OSlets, and will need some facility to allow
>      efficient determination of which OSlet a given resource belongs
>      to (for example, to determine which OSlet a given page is owned
>      by).
>
>      At some point in the boot sequence, each OSlet creates a "proxy
>      task" for each of the other OSlets that provides shared services
>      to them.
>
>      Issues:
>
>      1.   Some systems may require device probing to be done
>           by a central program, possibly before the OSlets are
>           spawned.  Systems that react in an unfriendly manner
>           to failed probes might be in this class.
>
>      2.   Interrupts must be set up very carefully.  On some
>           systems, the interrupt system may constrain the ways
>           in which the system is partitioned.
>
>
> Shared Operations
>
>      This section describes some possible implementations and issues
>      with a number of the shared operations.
>
>      Shared operations include:
>
>      1.   Page fault on memory owned by some other OSlet.
>      2.   Manipulation of processes running on some other OSlet.
>      3.   Access to devices owned by some other OSlet.
>      4.   Reception of network packets intended for some other OSlet.
>      5.   SysV msgq and sema operations on msgq and sema objects
>           accessed by processes running on multiple of the OSlets.
>      6.   Access to filesystems owned by some other OSlet.  The
>           /tmp directory gets special mention.
>      7.   Pipes connecting processes in different OSlets.
>      8.   Creation of processes that are to run on a different
>           OSlet than their parent.
>      9.   Processing of exit()/wait() pairs involving processes
>           running on different OSlets.
>
>      Page Fault
>
>           As noted earlier, each OSlet maintains a proxy process
>           for each other OSlet (so that for an SMP Cluster made
>           up of N OSlets, there are N*(N-1) proxy processes).
>
>           When a process in OSlet A wishes to map a file
>           belonging to OSlet B, it makes a request to B's proxy
>           process corresponding to OSlet A.  The proxy process
>           maps the desired file and takes a page fault at the
>           desired address (translated as needed, since the file
>           will usually not be mapped to the same location in the
>           proxy and client processes), forcing the page into
>           OSlet B's memory.  The proxy process then passes the
>           corresponding physical address back to the client
>           process, which maps it.
>
>           Issues:
>
>           o    How to coordinate pageout?  Two approaches:
>
>                1.   Use mlock in the proxy process so that
>                     only the client process can do the pageout.
>
>                2.   Make the two OSlets coordinate their
>                     pageouts.  This is more complex, but will
>                     be required in some form or another to
>                     prevent OSlets from "ganging up" on one
>                     of their number, exhausting its memory.
>
>           o    When OSlet A ejects the memory from its working
>                set, where does it put it?
>
>                1.   Throw it away, and go to the proxy process
>                     as needed to get it back.
>
>                2.   Augment core VM as needed to track the
>                     "guest" memory.  This may be needed for
>                     performance, but...
>
>           o    Some code is required in the pagein() path to
>                figure out that the proxy must be used.
>
>                1.   Larry stated that he is willing to be
>                     punched in the nose to get this code in.  ;-)
>                     The amount of this code is minimized by
>                     creating SMP-clusters-specific filesystems,
>                     which have their own functions for mapping
>                     and releasing pages.  (Does this really
>                     cover OSlet A's paging out of this memory?)
>
>           o    How are pagein()s going to be even halfway fast
>                if IPC to the proxy is involved?
>
>                1.   Just do it.  Page faults should not be
>                     all that frequent with today's memory
>                     sizes.  (But then why do we care so
>                     much about page-fault performance???)
>
>                2.   Use "doors" (from Sun), which are very
>                     similar to protected procedure call
>                     (from K42/Tornado/Hurricane).  The idea
>                     is that the CPU in OSlet A that is handling
>                     the page fault temporarily -becomes- a
>                     member of OSlet B by using OSlet B's page
>                     tables for the duration.  This results in
>                     some interesting issues:
>
>                     a.   What happens if a process wants to
>                          block while "doored"?  Does it
>                          switch back to being an OSlet A
>                          process?
>
>                     b.   What happens if a process takes an
>                          interrupt (which corresponds to
>                          OSlet A) while doored (thus using
>                          OSlet B's page tables)?
>
>                          i.   Prevent this by disabling
>                               interrupts while doored.
>                               This could pose problems
>                               with relatively long VM
>                               code paths.
>
>                          ii.  Switch back to OSlet A's
>                               page tables upon interrupt,
>                               and switch back to OSlet B's
>                               page tables upon return
>                               from interrupt.  On machines
>                               not supporting ASID, take a
>                               TLB-flush hit in both
>                               directions.  Also likely
>                               requires common text (at
>                               least for low-level interrupts)
>                               for all OSlets, making it more
>                               difficult to support OSlets
>                               running different versions of
>                               the OS.
>
>                               Furthermore, the last time
>                               that Paul suggested adding
>                               instructions to the interrupt
>                               path, several people politely
>                               informed him that this would
>                               require a nose punching.  ;-)
>
>                     c.   If a bunch of OSlets simultaneously
>                          decide to invoke their proxies on
>                          a particular OSlet, that OSlet gets
>                          lock contention corresponding to
>                          the number of CPUs on the system
>                          rather than to the number in a
>                          single OSlet.  Some approaches to
>                          handle this:
>
>                          i.   Stripe -everything-, rely
>                               on entropy to save you.
>                               May still have problems with
>                               hotspots (e.g., which of the
>                               OSlets has the root of the
>                               root filesystem?).
>
>                          ii.  Use some sort of queued lock
>                               to limit the number CPUs that
>                               can be running proxy processes
>                               in a given OSlet.  This does
>                               not really help scaling, but
>                               would make the contention
>                               less destructive to the
>                               victim OSlet.
>
>           o    How to balance memory usage across the OSlets?
>
>                1.   Don't bother, let paging deal with it.
>                     Paul's previous experience with this
>                     philosophy was not encouraging.  (You
>                     can end up with one OSlet thrashing
>                     due to the memory load placed on it by
>                     other OSlets, which don't see any
>                     memory pressure.)
>
>                2.   Use some global memory-pressure scheme
>                     to even things out.  Seems possible,
>                     Paul is concerned about the complexity
>                     of this approach.  If this approach is
>                     taken, make sure someone with some
>                     control-theory experience is involved.
>
>
>      Manipulation of Processes Running on Some Other OSlet.
>
>           The general idea here is to implement something similar
>           to a vproc layer.  This is common code, and thus requires
>           someone to sacrifice their nose.  There was some discussion
>           of other things that this would be useful for, but I have
>           lost them.
>
>           Manipulations discussed included signals and job control.
>
>           Issues:
>
>           o    Should process information be replicated across
>                the OSlets for performance reasons?  If so, how
>                much, and how to synchronize.
>
>                1.   No, just use doors.  See above discussion.
>
>                2.   Yes.  No discussion of synchronization
>                     methods.  (Hey, we had to leave -something-
>                     for later!)
>
>      Access to Devices Owned by Some Other OSlet
>
>           Larry mentioned a /rdev, but if we discussed any details
>           of this, I have lost them.  Presumably, one would use some
>           sort of IPC or doors to make this work.
>
>      Reception of Network Packets Intended for Some Other OSlet.
>
>           An OSlet receives a packet, and realizes that it is
>           destined for a process running in some other OSlet.
>           How is this handled without rewriting most of the
>           networking stack?
>
>           The general approach was to add a NAT-like layer that
>           inspected the packet and determined which OSlet it was
>           destined for.  The packet was then forwarded to the
>           correct OSlet, and subjected to full IP-stack processing.
>
>           Issues:
>
>           o    If the address map in the kernel is not to be
>                manipulated on each packet reception, there
>                needs to be a circular buffer in each OSlet for
>                each of the other OSlets (again, N*(N-1) buffers).
>                In order to prevent the buffer from needing to
>                be exceedingly large, packets must be bcopy()ed
>                into this buffer by the OSlet that received
>                the packet, and then bcopy()ed out by the OSlet
>                containing the target process.  This could add
>                a fair amount of overhead.
>
>                1.   Just accept the overhead.  Rely on this
>                     being an uncommon case (see the next issue).
>
>                2.   Come up with some other approach, possibly
>                     involving the user address space of the
>                     proxy process.  We could not articulate
>                     such an approach, but it was late and we
>                     were tired.
>
>           o    If there are two processes that share the FD
>                on which the packet could be received, and these
>                two processes are in two different OSlets, and
>                neither is in the OSlet that received the packet,
>                what the heck do you do???
>
>                1.   Prevent this from happening by refusing
>                     to allow processes holding a TCP connection
>                     open to move to another OSlet.  This could
>                     result in load-balance problems in some
>                     workloads, though neither Paul nor Ted were
>                     able to come up with a good example on the
>                     spot (seeing as BAAN has not been doing really
>                     well of late).
>
>                     To indulge in l'esprit d'escalier...  How
>                     about a timesharing system that users
>                     access from the network?  A single user
>                     would have to log on twice to run a job
>                     that consumed more than one OSlet if each
>                     process in the job might legitimately need
>                     access to stdin.
>
>                2.   Do all protocol processing on the OSlet
>                     on which the packet was received, and
>                     straighten things out when delivering
>                     the packet data to the receiving process.
>                     This likely requires changes to common
>                     code, hence someone to volunteer their nose.
>
>
>      SysV msgq and sema Operations
>
>           We didn't discuss these.  None of us seem to be SysV fans,
>           but these must be made to work regardless.
>
>           Larry says that shm should be implemented in terms of mmap(),
>           so that this case reduces to page-mapping discussed above.
>           Of course, one would need a filesystem large enough to handle
>           the largest possible shmget.  Paul supposes that one could
>           dynamically create a memory filesystem to avoid problems here,
>           but is in no way volunteering his nose to this cause.
>
>
>      Access to Filesystems Owned by Some Other OSlet.
>
>           For the most part, this reduces to the mmap case.  However,
>           partitioning popular filesystems over the OSlets could be
>           very helpful.  Larry mentioned that this had been prototyped.
>           Paul cannot remember if Larry promised to send papers or
>           other documentation, but duly requests them after the fact.
>
>           Larry suggests having a local /tmp, so that /tmp is in effect
>           private to each OSlet.  There would be a /gtmp that would
>           be a globally visible /tmp equivalent.  We went round and
>           round on software compatibility, Paul suggesting a hashed
>           filesystem as an alternative.  Larry eventually pointed out
>           that one could just issue different mount commands to get
>           a global filesystem in /tmp, and create a per-OSlet /ltmp.
>           This would allow people to determine their own level of
>           risk/performance.
>
>
>      Pipes Connecting Processes in Different OSlets.
>
>           This was mentioned, but I have forgotten the details.
>           My vague recollections lead me to believe that some
>           nose-punching was required, but I must defer to Larry
>           and Ted.
>
>           Ditto for Unix-domain sockets.
>
>
>      Creation of Processes on a Different OSlet Than Their Parent.
>
>           There would be a inherited attribute that would prevent
>           fork() or exec() from creating its child on a different
>           OSlet.  This attribute would be set by default to prevent
>           too many surprises.  Things like make(1) would clear
>           this attribute to allow amazingly fast kernel builds.
>
>           There would also be a system call that would cause the
>           child to be placed on a specified OSlet (Paul suggested
>           use of HP's "launch policy" concept to avoid adding yet
>           another dimension to the exec() combinatorial explosion).
>
>           The discussion of packet reception lead Larry to suggest
>           that cross-OSlet process creation would be prohibited if
>           the parent and child shared a socket.  See above for the
>           load-balancing concern and corresponding l'esprit d'escalier.
>
>
>      Processing of exit()/wait() Pairs Crossing OSlet Boundaries
>
>           We didn't discuss this.  My guess is that vproc deals
>           with it.  Some care is required when optimizing for this.
>           If one hands off to a remote parent that dies before
>           doing a wait(), one would not want one of the init
>           processes getting a nasty surprise.
>
>           (Yes, there are separate init processes for each OSlet.
>           We did not talk about implications of this, which might
>           occur if one were to need to send a signal intended to
>           be received by all the replicated processes.)
>
>
> Other Desiderata:
>
> 1.   Ability of surviving OSlets to continue running after one of their
>      number fails.
>
>      Paul was quite skeptical of this.  Larry suggested that the
>      "door" mechanism could use a dynamic-linking strategy.  Paul
>      remained skeptical.  ;-)
>
> 2.   Ability to run different versions of the OS on different OSlets.
>
>      Some discussion of this above.
>
>
> The Score.
>
>      Paul agreed that SMP Clusters could be implemented.  He was not
>      sure that it could achieve good performance, but could not prove
>      otherwise.  Although he suspected that the complexity might be
>      less than the proprietary highly parallel Unixes, he was not
>      convinced that it would be less than Linux would be, given the
>      Linux community's emphasis on simplicity in addition to performance.
>
> --
> ---
> Larry McVoy                lm at bitmover.com
http://www.bitmover.com/lm


