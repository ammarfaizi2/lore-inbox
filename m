Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268564AbTBWVaA>; Sun, 23 Feb 2003 16:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbTBWVaA>; Sun, 23 Feb 2003 16:30:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47880 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268564AbTBWV37>; Sun, 23 Feb 2003 16:29:59 -0500
Date: Sun, 23 Feb 2003 13:37:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: object-based rmap and pte-highmem
In-Reply-To: <9540000.1046031384@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302231335090.1534-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, Martin J. Bligh wrote:
> > 
> > The thing is, you _cannot_ have a per-thread area, since all threads
> > share the same TLB.  And if it isn't per-thread, you still need all the
> > locking and all the scalability stuff that the _current_ pte_highmem
> > code needs, since there are people with thousands of threads in the same
> > process. 
> 
> I don't see why that's an issue - the pagetables are per-process, not
> per-thread.

Exactly. Which means that UKVA has all the same problems as the current 
global map.

There are _NO_ differences. Any problems you have with the current global 
map you would have with UKVA in threads. So I don't see what you expect to 
win from UKVA.

> Yes, that was a stalling point for sticking kmap in there, which was
> amongst my original plotting for it, but the stuff that's per-process
> still works. 

Exactly what _is_ "per-process"? The only thing that is per-process is 
stuff that is totally local to the VM, by the linux definition.

And the rmap stuff certainly isn't "local to the VM". Yes, it is torn down 
and built up by the VM, but it needs to be traversed by global code.

		Linus

