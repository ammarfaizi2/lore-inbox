Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSFJN6R>; Mon, 10 Jun 2002 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSFJN5d>; Mon, 10 Jun 2002 09:57:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16477 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315358AbSFJN4K>; Mon, 10 Jun 2002 09:56:10 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, ralf@gnu.org, rhw@memalpha.cx,
        mingo@redhat.com, paulus@samba.org, anton@samba.org,
        schwidefsky@de.ibm.com, bh@sgi.com, davem@redhat.com, ak@suse.de,
        torvalds@transmeta.com
Subject: Re: Hotplug CPU Boot Changes: BEWARE
In-Reply-To: <E17HJEs-00061l-00@wagner.rustcorp.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jun 2002 07:43:00 -0600
Message-ID: <m14rgbw8pn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> In message <m1elfjw39n.fsf@frodo.biederman.org> you write:
> > But for the latter something just a little more than minimal hacks
> > must be implemented.  But dynamic cpu enable/disable is definitely
> > worth it.
> 
> Perhaps I didn't make myself clear: hotplugging does not neccessarily
> mean physically removing or adding the CPU.  And as to whether they
> offer full support, or stub support, architectures can decide that for
> themselves, as they need.  It's not my call.

I guess as long as the interface to user space is consistent I don't
mind.
 
> I don't know how much of a win it is to disable HT on cpus, but I can
> tell you that adding & subtracting CPUs is a fairly heavy-weight
> operation in this design (I don't think we really want to lock around
> every cpu iteration).

Agreed.  However it should be lighter than a full system reboot,
which is what is needed now.  And if you can disable the extra
cpu you can benchmark on the same machine without rebooting
and see what kind of a win it is.

My basic point was that with a name like hotplug it was not immediately
clear this code could be useful for anything.  And that there are a lot
of debugging uses of being able stop or start a cpu.  Things like is
testing if HT/SMT worth it.

For the kernel I fully expect this to be a heavy weight operation.
But it is almost certainly lighter than swapoff /dev/hda1.  Which
makes it a lightweight operation for a system administrator.  

So it is my belief there is general usefulness of this code, on any
SMP target.  And with general applicability should come a common user
space interface.  

On x86  the code to do dynamic start/stop should already exist,
because we need it at kernel startup and shutdown.  The code paths just
need to be made safe to run at relatively arbitrary times.  The
generic part of which you are handling.

Eric
