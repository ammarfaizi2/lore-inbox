Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292398AbSB0Q3B>; Wed, 27 Feb 2002 11:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292629AbSB0Q2u>; Wed, 27 Feb 2002 11:28:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2804 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292656AbSB0Q2j>;
	Wed, 27 Feb 2002 11:28:39 -0500
Date: Wed, 27 Feb 2002 11:29:03 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020227112903.A1264@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au> <20020225100025.A1163@elinux01.watson.ibm.com> <20020227112417.3a302d31.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227112417.3a302d31.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Feb 27, 2002 at 11:24:17AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 11:24:17AM +1100, Rusty Russell wrote:
> On Mon, 25 Feb 2002 10:00:25 -0500
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> 
> > Rusty, since I supplied one of those packages available under lse.sourceforge.net
> > let me make some comments.
> > 
> > (a) why do you need to pin. I simply use the user level address (vaddr)  
> >     and hash with the <mm,vaddr> to obtain the internal object.
> >     This also gives me full protection through the general vmm mechanisms.
> 
> I pin while sleeping for convenience, so I can get a kernel address.  It's
> only one page (maybe 2).  I could look up the address every time, but then I
> need to swap the page back in anyway to look at it.

Lookup is cheap. I integrated a <hit meter> into my hashing mechanism
that reports the hits/misses and the average length of traversal down
a hash chain, it's insignificant for the cases I tried, but again
no big progam has be tried against any of these approaches.

I (think) I now also see the merit of your approach, in that you really don't
need to allocate a kernel object. You actually allocate the object
right into the shared user page and pin it down. Your argument is that
you only need to pin while somebody is sleeping on the lock.
Is that correct? Very tricky. 
Let me also point out some shortcomings of this. If indeed there is a 
shared page between user and kernel then how does the system react to 
buggy userlevel code, e.g wild write that corrupt the wait queue.

In my explicite kernel object approach, I won't have this problem.

I hope I am not missing something here.

-- Hubertus
