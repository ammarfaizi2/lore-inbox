Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271658AbRHQUzv>; Fri, 17 Aug 2001 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271724AbRHQUzl>; Fri, 17 Aug 2001 16:55:41 -0400
Received: from ns.suse.de ([213.95.15.193]:17931 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271721AbRHQUzY>;
	Fri, 17 Aug 2001 16:55:24 -0400
Date: Fri, 17 Aug 2001 22:55:37 +0200
From: Andi Kleen <ak@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Terje Eggestad <terje.eggestad@scali.no>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] processes with shared vm
Message-ID: <20010817225537.B2429@gruyere.muc.suse.de>
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel> <oupelqbw0z4.fsf@pigdrop.muc.suse.de> <998038019.7627.21.camel@pc-16.office.scali.no> <36530000.998058370@baldur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <36530000.998058370@baldur>; from dmccr@us.ibm.com on Fri, Aug 17, 2001 at 09:26:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 09:26:10AM -0500, Dave McCracken wrote:
> There is a simpler way to do this.  All tasks belong to a thread group, and 
> while thread groups are connected via a different clone flag 
> (CLONE_THREAD), in practice CLONE_THREAD and CLONE_VM are generally used 
> together.  It would be trivial to add TGID to the information in /proc, 
> then assume all tasks with the same TGID have the same VM as well.  It 
> would be just one more line in the /proc output and not require any 
> additional overhead.

Even with a tgid you would need some way to avoid its counter wrapping
and getting reused. I think reusing the pid and pid hash for that is 
cheaper. Also gtop should display correct results even with the programs
that don't use CLONE_THREAD.

-Andi
