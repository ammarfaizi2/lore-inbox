Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTEOTGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEOTGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:06:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40859
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264173AbTEOTGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:06:35 -0400
Date: Thu, 15 May 2003 21:19:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030515191921.GJ1429@dualathlon.random>
References: <20030513181018.4cbff906.akpm@digeo.com> <18240000.1052924530@baldur.austin.ibm.com> <20030514103421.197f177a.akpm@digeo.com> <82240000.1052934152@baldur.austin.ibm.com> <20030515004915.GR1429@dualathlon.random> <20030515013245.58bcaf8f.akpm@digeo.com> <20030515085519.GV1429@dualathlon.random> <20030515022000.0eb9db29.akpm@digeo.com> <20030515094041.GA1429@dualathlon.random> <1053016706.2693.10.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053016706.2693.10.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 09:38:26AM -0700, Daniel McNeil wrote:
> On Thu, 2003-05-15 at 02:40, Andrea Arcangeli wrote:
> > On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > and it's still racy
> > > 
> > > damn, and it just booted ;)
> > > 
> > > I'm just a little bit concerned over the ever-expanding inode.  Do you
> > > think the dual sequence numbers can be replaced by a single generation
> > > counter?
> > 
> > yes, I wrote it as a single counter first, but was unreadable and it had
> > more branches, so I added the other sequence number to make it cleaner.
> > I don't mind another 4 bytes, that cacheline should be hot anyways.
> 
> You could use the seqlock.h sequence locking.  It only uses 1 sequence
> counter.  The 2.5 isize patch 1 has a sequence lock without the spinlock
> so it only uses 4 bytes and it is somewhat more readable.  I don't
> think it has more branches.
> 
> I've attached the isize seqlock.h patch.

what do you think of the rmb vs mb in the reader side? Can I use rmb
too? I used mb() to go safe. I mean gettimeofday is a no brainer since
it does only reads inside the critical section anyways. But here I feel
I need mb().


And yes, there are no more branches sorry, just an additional or.

Andrea
