Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTIGVSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTIGVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:18:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28258 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261533AbTIGVSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:18:44 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
References: <20030903180037.GP4306@holomorphy.com>
	<20030903180547.GD5769@work.bitmover.com>
	<20030903181550.GR4306@holomorphy.com>
	<1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
	<20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay>
	<20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay>
	<20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay>
	<20030904010653.GD5227@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Sep 2003 15:18:19 -0600
In-Reply-To: <20030904010653.GD5227@work.bitmover.com>
Message-ID: <m11xusnvqc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> Here's a thought.  Maybe the next kernel summit needs to have a CC cluster
> BOF or whatever.  I'd be happy to show up, describe what it is that I see
> and have you all try and poke holes in it.  If the net result was that you
> walked away with the same picture in your head that I have that would be
> cool.  Heck, I'll sponser it and buy beer and food if you like.

Larry CC clusters are an idiotic development target.
The development target should be non coherent clusters.

1) NUMA machines are smaller, more expensive, and less available than
   their non cache coherent counter parts. 

2) If you can solve the communications problems for a non cache
   coherent counter part the solution will also work on a NUMA
   machine.

3) People on a NUMA machine can always punt and over share.  On a non
   cache coherent cluster when people punt they don't share.  Not
   sharing increases scalability and usually performance.

4) Small start up companies can do non-coherent clusters, and can
   scale up.  You have to be a substantial company to build a NUMA
   machine. 

5) NUMA machines are slow.  There is not a single NUMA machine in the
   top 10 of the top500 supercomputers list.  Likely this has more to
   do with system sizes supported by the manufacture than inherent
   process inferiority, but it makes a difference.

SSI is good and it helps.  But that is not the primary management
problem on a large system.  The larger you get the imperfection of
your materials tends to be an increasingly dominate factor in
management problems.  

For example I routinely reproduce cases where the BIOS does not work
around hardware bugs in a single boot that the motherboard vendors
cannot even reproduce.

Another example is Google who have given up entirely on machines
always working, and has built the software to be robust about error
detection and recovery.

And the SSI solutions are evolving.  But the problems are hard.
How do you build a distributed filesystem that scales?  
How do you do process migration across machines?
How do you checkpoint a distributed job?
How do you properly build a cluster job scheduler?
How do you handle simultaneous similar actions by a group of nodes?
How do you usefully predict, detect, and isolate hardware failures so
    as not to cripple the cluster?
etc.

Eric
