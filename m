Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263171AbTDBVte>; Wed, 2 Apr 2003 16:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263168AbTDBVte>; Wed, 2 Apr 2003 16:49:34 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:36334 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263171AbTDBVsd>;
	Wed, 2 Apr 2003 16:48:33 -0500
Date: Thu, 3 Apr 2003 00:07:34 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Robert Love <rml@tech9.net>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030402220734.GC13168@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <20030402124643.GA13168@wind.cocodriloo.com> <20030402163512.GC993@holomorphy.com> <20030402213629.GB13168@wind.cocodriloo.com> <1049319300.2872.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049319300.2872.21.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 04:35:00PM -0500, Robert Love wrote:
> On Wed, 2003-04-02 at 16:36, Antonio Vargas wrote:
> 
> > I've been thinking about this thing a while ago, and I think I could do this:
> > 
> > a. Have a kernel thread which wakes up on each tick.
> 
> Why not use the timer tick itself?  It already calls scheduler_tick()...
> 
> Oh, because you need to grab uidhash_lock?  Ew.  Needing a kernel thread
> for this is not pretty.

Hmmm, we had some way for executing code just after an interrupt,
but outside interrupt scope... was it a bottom half? Can you
point me to some place where it's done?
 
> > Also, this locking rule means I can't even read current->user->time_slice?
> > What if I changed the type to an atomic_int?
> 
> You can always read a single word-sized type atomically.  No need for
> atomic_t's.

Ok, I did know m68k can do it, but wasn't sure about all other arches :)

Btw, I'm testing the patch using UML and besides I don't have any SMP
machine, hope any of you can test it when it looks good :)

Greets, Antonio
