Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278046AbRKFGfk>; Tue, 6 Nov 2001 01:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278133AbRKFGfa>; Tue, 6 Nov 2001 01:35:30 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33212 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278046AbRKFGfX>; Tue, 6 Nov 2001 01:35:23 -0500
Date: Mon, 5 Nov 2001 23:35:18 -0700
Message-Id: <200111060635.fA66ZIH20196@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0110271558430.21545-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0110271558430.21545-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> ... and one more - devfs_unregister() on a directory happening when
> mknod() in that directory sleeps in create_entry() (on kmalloc()).
> 
> Do you ever read your own code?  It's not like this stuff was hard
> to find - I'm just poking into random places and every damn one
> contains a hole.  Sigh...
> 
> Oh, BTW - here's another one:  think what happens if tree-walking in
> unregister() steps on the entry we are currently removing in
> devfs_unlink().

Yep, as I've long ago admitted, there are races in the old devfs
code, which couldn't be fixed without proper locking. And that's why
I've been wanting to add said locking for ages, and have been
frustrated at interruptions which delayed that work. And I'm very
happy to get the first cut of the new code released.

That said, try to understand (before getting emotional and launching
off a tirade such as the one last week) that different people have
different priorities, and mine was to provide functionality first, and
worry about hostile attacks/exploits later. This is not unreasonable
if you consider that the initial target machines for devfs were:
- my personal boxes (which are not public machines)
- big-iron machines sitting behind a firewall
- small university group sitting behind a firewall (and I know where
  all the users live:-)

I know your favourite horror scenario is the public machines available
to the undergrads, but not everyone works in such a hostile
environment.

Anyway, I hope Linus wasn't bored by all the messages you Cc:ed to
him for your^H^H^H^Hhis benefit :-O

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
