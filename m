Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285265AbRLFW4p>; Thu, 6 Dec 2001 17:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285254AbRLFW4h>; Thu, 6 Dec 2001 17:56:37 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:28052 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S285277AbRLFW4T>; Thu, 6 Dec 2001 17:56:19 -0500
Date: Thu, 6 Dec 2001 16:00:58 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "cardente, john" <cardente_john@emc.com>
Cc: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206160058.A24542@vger.timpanogas.org>
In-Reply-To: <B595A948887ED41185130000D1899D880272C8E6@srstaubach.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B595A948887ED41185130000D1899D880272C8E6@srstaubach.lss.emc.com>; from cardente_john@emc.com on Thu, Dec 06, 2001 at 05:20:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 05:20:22PM -0500, cardente, john wrote:
> Hi Jeff,
> 
> I was one of the primary SCI guys at DG for all of
> their Intel based ccNUMA machines. I worked with
> Dolphin closely on a variety of things for those
> systems including micro-coding a modified/optimized
> version of their SCI implementation as well as 
> architecting and implementing changes to their SCI
> coherency ASIC for the third (last) DG ccNUMA system.
> Beyond that I was the primary coherency protocol 
> person for the project and was responsible for making
> sure we played nice with Intel's coherency protocol.

I know what the PCI cards do.  I was the person who pushed
marty Albert, the Chairman of the Dolphin Board at the time in 
1995 to pursue design work on them.  I also worked with Justin 
Rattner (I saw one of your early prototype boxes in 1996 in his labs).  

> 
> Getting to the point I saw your post below and I thought
> there might be some confusion between what the DG boxes
> did and what those PCI cards do. In the DG system we
> implemented ASIC's that sat on the processor bus which
> examined every memory reference to maintain system wide
> coherency. These evaluations were done for every bus
> transaction at a cache line granularity. These chips
> acted as bridges that enforced coherency between the SMP local
> snoopy bus protocol and the SCI protocol used system
> wide. The essential point here is that only by being
> apart of the coherency protocol on the processor bus 
> were those chips able to implement ccNUMA at a cacheline 
> level coherency.
> 

There was a Pentium Pro adapter that plugged into the memory 
bus Dolphin was working on.  Intel backed away from this 
design since they had little interest in opening up their 
memory bus architecture.  DG was the only exception, and if
you remember, you guys had to spin your own motherboards.  
Those stubs were aweful short for the lost slot in your 
system, and I am surprised you did not get signal skew.  Those
stubs had to be 1.5 inches long :-).

> 
> The Dolphin PCI cards, however, cannot perform the same
> function due to the fact that the PCI bus is outside of the
> Intel coherency domain. Therefore it lacks the visiblity
> and control to enforce coherency. Instead, those cards 
> only allowed for the explicit sending of messages across 
> SCI for use with clustering libraries like MPI. One could
> use this kind of messaging protocol to implement explicit
> coherency (as you noted) but the sharing granularity of
> such a system is at the page level, not cache line. There
> have been many efforts to implement this kind of system
> and (if I recall correctly) they usually go under the
> name of Shared Virtual Memory systems.

Wrong.  There is a small window where you can copy into a 
remote nodes memory.

> 
> 
> Anyway, there were two reasons for the post. First, if I've
> been following the thread correctly most of the discussion
> up to this point has involed issues at the cacheline level
> and dont apply to a system built from Dolphin PCi cards.
> Nor can one build such a system from those cards and
> I felt compelled to clear up any potential confusion. My
> second, prideful, reason was to justify the cost of those
> DG machines!!! (and NUMA-Q's as they were very similar in
> architecture).
> 
> take care, and please disregard if I misunderstood your
> post or the thread...

It's OK.  We love DG and your support of SCI.  Keep up the good 
work.

Jeff


> 
> john
> 
> 
> -----Original Message-----
> From: Jeff V. Merkey [mailto:jmerkey@vger.timpanogas.org]
> Sent: Thursday, December 06, 2001 1:38 PM
> To: David S. Miller
> Cc: lm@bitmover.com; davidel@xmailserver.org; rusty@rustcorp.com.au;
> Martin.Bligh@us.ibm.com; riel@conectiva.com.br; lars.spam@nocrew.org;
> alan@lxorguk.ukuu.org.uk; hps@intermeta.de;
> linux-kernel@vger.kernel.org; jmerkey@timpanogas.org
> Subject: Re: SMP/cc Cluster description
> 
> 
> On Thu, Dec 06, 2001 at 11:27:31AM -0700, Jeff V. Merkey wrote:
> 
> And also, if you download the SCI drivers in my area, and order
> some SCI adapters from Dolphin in Albquerque, NM, you can set up 
> a ccNUMA system with standard PCs.  Dolphin has 66Mhz versions (and
> a 133Mhz coming in the future) that run at almost a gigabyte per 
> second node-2-node over a parallel fabric.  The cross-sectional
> SCI fabric bandwidth scales at (O)(2N) as you add nodes.  
> 
> If you want to play around with ccNUMA with Standard PCs, these 
> cards are relatively inepxensive, and allow you to setup some 
> powerful cc/SMP systems with explicit coherence.  The full 
> ccNUMA boxes from DG are expensive, however.  That way, instead
> of everyone talking about it, you guys could get some cool 
> hardware and experiment with some of your rather forward 
> looking and interesting ideas.
> 
> :-)
> 
> Jeff
> 
> 
> 
> > 
> > 
> > Guys,
> > 
> > I am the maintaner of SCI, the ccNUMA technology standard.  I know
> > alot about this stuff, and have been involved with SCI since 
> > 1994.  I work with it every day and the Dolphin guys on some huge 
> > supercomputer accounts, like Los Alamos and Sandia Labs in NM.  
> > I will tell you this from what I know.
> > 
> > A shared everything approach is a programmers dream come true,
> > but you can forget getting reasonable fault tolerance with it.  The 
> > shared memory zealots want everyone to believe ccNUMA is better 
> > than sex, but it does not scale when compared to Shared-Nothing
> > programming models.  There's also a lot of tough issues for dealing 
> > with failed nodes, and how you recover when peoples memory is 
> > all over the place across a nuch of machines.  
> > 
> > SCI scales better in ccNUMA and all NUMA technoogies scale very 
> > well when they are used with "Explicit Coherence" instead of 
> > "Implicit Coherence" which is what you get with SMP systems.  
> > Years of research by Dr. Justin Rattner at Intel's High 
> > performance labs demonstrated that shared nothing models scaled
> > into the thousands of nodes, while all these shared everything
> > "Super SMP" approaches hit the wall at 64 processors generally.
> > 
> > SCI is the fastest shared nothing interface out there, and it also
> > can do ccNUMA.  Sequent, Sun, DG and a host of other NUMA providers
> > use Dolphin's SCI technology and have for years.   ccNUMA is useful 
> > for applications that still assume a shared nothing approach but that
> > use the ccNUMA and NUMA capabilities for better optimization.
> > 
> > Forget trying to recreate the COMA architecture of Kendall-Square.  
> > The name was truly descriptive of what happened in this architecture
> > when a node fails -- goes into a "COMA".  This whole discussion I have
> > lived through before and you will find that ccNUMA is virtually 
> > unimplementable on most general purpose OSs.  And yes, there are 
> > a lot of products and software out there, but when you look under 
> > the cover (like ServerNet) you discover their coherence models 
> > for the most part relay on push/pull explicit coherence models.
> > 
> > My 2 cents.
> > 
> > Jeff 
> > 
> > 
> > 
> > On Thu, Dec 06, 2001 at 12:09:32AM -0800, David S. Miller wrote:
> > >    From: Larry McVoy <lm@bitmover.com>
> > >    Date: Thu, 6 Dec 2001 00:02:16 -0800
> > >    
> > >    Err, Dave, that's *exactly* the point of the ccCluster stuff.  You
> get
> > >    all that seperation for every data structure for free.  Think about
> > >    it a bit.  Aren't you going to feel a little bit stupid if you do all
> > >    this work, one object at a time, and someone can come along and do
> the
> > >    whole OS in one swoop?  Yeah, I'm spouting crap, it isn't that easy,
> > >    but it is much easier than the route you are taking.  
> > > 
> > > How does ccClusters avoid the file system namespace locking issues?
> > > How do all the OS nodes see a consistent FS tree?
> > > 
> > > All the talk is about the "magic filesystem, thread it as much as you
> > > want" and I'm telling you that is the fundamental problem, the
> > > filesystem name space locking.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
