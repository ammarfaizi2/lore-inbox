Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281966AbRLFSXo>; Thu, 6 Dec 2001 13:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281915AbRLFSXf>; Thu, 6 Dec 2001 13:23:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:50834 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281916AbRLFSXO>; Thu, 6 Dec 2001 13:23:14 -0500
Date: Thu, 6 Dec 2001 11:27:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206112731.C22534@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com> <20011205.235617.23011309.davem@redhat.com> <20011206000216.B18034@work.bitmover.com> <20011206.000932.95504991.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206.000932.95504991.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 12:09:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Guys,

I am the maintaner of SCI, the ccNUMA technology standard.  I know
alot about this stuff, and have been involved with SCI since 
1994.  I work with it every day and the Dolphin guys on some huge 
supercomputer accounts, like Los Alamos and Sandia Labs in NM.  
I will tell you this from what I know.

A shared everything approach is a programmers dream come true,
but you can forget getting reasonable fault tolerance with it.  The 
shared memory zealots want everyone to believe ccNUMA is better 
than sex, but it does not scale when compared to Shared-Nothing
programming models.  There's also a lot of tough issues for dealing 
with failed nodes, and how you recover when peoples memory is 
all over the place across a nuch of machines.  

SCI scales better in ccNUMA and all NUMA technoogies scale very 
well when they are used with "Explicit Coherence" instead of 
"Implicit Coherence" which is what you get with SMP systems.  
Years of research by Dr. Justin Rattner at Intel's High 
performance labs demonstrated that shared nothing models scaled
into the thousands of nodes, while all these shared everything
"Super SMP" approaches hit the wall at 64 processors generally.

SCI is the fastest shared nothing interface out there, and it also
can do ccNUMA.  Sequent, Sun, DG and a host of other NUMA providers
use Dolphin's SCI technology and have for years.   ccNUMA is useful 
for applications that still assume a shared nothing approach but that
use the ccNUMA and NUMA capabilities for better optimization.

Forget trying to recreate the COMA architecture of Kendall-Square.  
The name was truly descriptive of what happened in this architecture
when a node fails -- goes into a "COMA".  This whole discussion I have
lived through before and you will find that ccNUMA is virtually 
unimplementable on most general purpose OSs.  And yes, there are 
a lot of products and software out there, but when you look under 
the cover (like ServerNet) you discover their coherence models 
for the most part relay on push/pull explicit coherence models.

My 2 cents.

Jeff 



On Thu, Dec 06, 2001 at 12:09:32AM -0800, David S. Miller wrote:
>    From: Larry McVoy <lm@bitmover.com>
>    Date: Thu, 6 Dec 2001 00:02:16 -0800
>    
>    Err, Dave, that's *exactly* the point of the ccCluster stuff.  You get
>    all that seperation for every data structure for free.  Think about
>    it a bit.  Aren't you going to feel a little bit stupid if you do all
>    this work, one object at a time, and someone can come along and do the
>    whole OS in one swoop?  Yeah, I'm spouting crap, it isn't that easy,
>    but it is much easier than the route you are taking.  
> 
> How does ccClusters avoid the file system namespace locking issues?
> How do all the OS nodes see a consistent FS tree?
> 
> All the talk is about the "magic filesystem, thread it as much as you
> want" and I'm telling you that is the fundamental problem, the
> filesystem name space locking.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
