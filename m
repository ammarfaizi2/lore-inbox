Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289080AbSAGCSv>; Sun, 6 Jan 2002 21:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289081AbSAGCSn>; Sun, 6 Jan 2002 21:18:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28168 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289080AbSAGCS3>;
	Sun, 6 Jan 2002 21:18:29 -0500
Date: Mon, 7 Jan 2002 00:18:13 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20020107021813.GA2686@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020107000736.04eb1c90@pop.cus.cam.ac.uk> <20020107012739.GB1920@conectiva.com.br> <E16NPGi-0001N0-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16NPGi-0001N0-00@starship.berlin>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 07, 2002 at 03:12:06AM +0100, Daniel Phillips escreveu:
> On January 7, 2002 02:27 am, Arnaldo Carvalho de Melo wrote:
> > When I did similar work for the network protocols, cleaning up
> > include/net/fs.h DaveM asked for benchmarks to see if the new approach,
> > i.e., using per network family slabcaches would lead to a performance drop,
> > I did it and we realized that it lead to performance _gains_, that in turn
> > made DaveM ask for a per network protocol slabcache, which made furter
> > memory savings and lead to further performance gains.
> 
> Oh, so that's why you were too busy to do the fs.h patch ;-)

*grin* And I still have to break the ipv6_sk_cachep into tcp6_sk_cachep,
udp6_sk_cachep and raw6_sk_cachep and test if moving the IPv4 identity
members in struct sock (sport, dport, saddr, rcv_saddr, daddr, etc) to
struct inet_opt is ok performance wise, doing that would remove the last
remnants of protocol specific stuff from include/net/sock.h 8)

<SNIP>
 
> Even if we leave the generic_ip in the common inode, we will for sure remove 
> the union at some point, meaning that even filesystems that use the 
> generic_ip now will have to do a big edit to clean up the fallout.  Which 
> isn't such a bad thing I suppose.

yes, in the sock.h cleanup the protinfo big union turned into just a void
pointer.
 
> If we wanted to be lazy, we could just leave the union there, with one 
> element, the generic_ip.  How ugly would that be?

Well, it can be left for later, first step would be to abstract the access
to the private areas in all the filesystems, but hey, don't worry as as
from the quick look I had some of the filesystems already use abstractions
for such access, like MSDOS_I, ext3 already does, NTFS NG also, etc 8)

- Arnaldo
