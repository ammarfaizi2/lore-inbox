Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285439AbRLGI4U>; Fri, 7 Dec 2001 03:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285438AbRLGI4G>; Fri, 7 Dec 2001 03:56:06 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:16398 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S285435AbRLGIzv>; Fri, 7 Dec 2001 03:55:51 -0500
Subject: Re: SMP/cc Cluster description
From: Henning Schmiedehausen <hps@intermeta.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E16C665-0000r5-00@starship.berlin>
In-Reply-To: <20011206115338.E27589@work.bitmover.com>
	<20011206.121554.106436207.davem@redhat.com>
	<20011206122116.H27589@work.bitmover.com> 
	<E16C665-0000r5-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 07 Dec 2001 09:54:58 +0100
Message-Id: <1007715304.13220.0.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-06 at 22:30, Daniel Phillips wrote:
> On December 6, 2001 09:21 pm, Larry McVoy wrote:
> > On Thu, Dec 06, 2001 at 12:15:54PM -0800, David S. Miller wrote:
> > > If you aren't getting rid of this locking, what is the point?
> > > That is what we are trying to talk about.
> > 
> > The points are:
> > 
> > a) you have to thread the entire kernel, every data structure which is a
> >    problem.  Scheduler, networking, device drivers, everything.  That's
> >    thousands of locks and uncountable bugs, not to mention the impact on
> >    uniprocessor performance.
> > 
> > b) I have to thread a file system.
> 
> OK, this is your central point.  It's a little more than just a mmap, no?
> We're pressing you on your specific ideas on how to handle the 'peripheral' 
> details.

How about creating one node as "master" and write a "cluster network
filesystem" which uses shared memory as its "network layer". 

Then boot all other nodes diskless from these cluster network
filesystems.

You can still have shared mmap (which I believe is Larry's toy point)
between the nodes but you avoid all of the filesystem locking issues,
because you're going over (a hopefully superfast) memory network
filesystem.

Or go iSCSI and attach a network device to each of the cluster node. Or
go 802.1q, attach a virtual network device to each cluster node, pull
all of them out over GigE and let some Cisco outside sort these out
again. :-)

What I don't like about the approach is the fact that all nodes should
share the same file system. One (at least IMHO) does not want this for
at least /etc. The "all nodes the same FS" works fine for your number
cruncher clusters where every node runs more or less the same software. 

It does not work for cluster boxes like the Starfire or 390. There you
want to boot totally different OS images on the nodes. No sense in
implementing a "threaded file system" that is not used.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

