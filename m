Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135538AbRDXKyj>; Tue, 24 Apr 2001 06:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135537AbRDXKy3>; Tue, 24 Apr 2001 06:54:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30879 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135535AbRDXKyS>;
	Tue, 24 Apr 2001 06:54:18 -0400
Date: Tue, 24 Apr 2001 06:54:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Rohland <cr@sap.com>
cc: David Woodhouse <dwmw2@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <m31yqiwpow.fsf@linux.local>
Message-ID: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Apr 2001, Christoph Rohland wrote:

> Hi Al,
> 
> On Tue, 24 Apr 2001, Alexander Viro wrote:
> >> Half an hour? If it takes more than about 5 minutes for JFFS2 I'd
> >> be very surprised.
> > 
> > <tone polite> What's stopping you? </tone>
> > You _are_ JFFS maintainer, aren't you?
> 
> So is this the start to change all filesystems in 2.4? I am not sure
> we should do that. 

Encapsulation part is definitely worth doing - it cleans the code up
and doesn't change the result of compile. Adding allocation/freeing/
cache initialization/cache removal and chaninging FOOFS_I() definition -
well, it's probably worth to keep such patches around, but whether
to switch any individual filesystem during 2.4 is a policy decision.
Up to maintainer, indeed. Notice that these patches (separate allocation
per se) are going to be within 3-4Kb per filesystem _and_ completely
straightforward.

What I would like to avoid is scenario like

Maintainers of filesystems with large private inodes: Why would we separate
them? We would only waste memory, since the other filesystems stay in ->u
and keep it large.

Maintainers of the rest of filesystems: Since there's no patches that would
take large stuff out of ->u, why would we bother?

So yes, IMO having such patches available _is_ a good thing. And in 2.5
we definitely want them in the tree. If encapsulation part gets there
during 2.4 and separate allocation is available for all of them it will
be easier to do without PITA in process.
								Al


