Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132870AbQLHVjp>; Fri, 8 Dec 2000 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132954AbQLHVjZ>; Fri, 8 Dec 2000 16:39:25 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:26117 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S132870AbQLHVjT>;
	Fri, 8 Dec 2000 16:39:19 -0500
Date: Fri, 8 Dec 2000 17:10:47 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: linux-kernel@vger.kernel.org, orbit-list@gnome.org
Cc: korbit-cvs@lists.sourceforge.net
Subject: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <Pine.LNX.4.21.0012081626140.7741-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This email is here to announce the availability of a port of ORBit (the
GNOME ORB) to the Linux kernel.  This ORB, named kORBit, is available from
our sourceforge web site (http://korbit.sourceforge.net/).  A kernel ORB
allows you to write kernel extensions in CORBA and have the kernel call
into them, or to call into the kernel through CORBA.  This opens the door
to a wide range of experiments/hacks:

* We can now write device drivers in perl, and let them run on the iMAC
  across the hall from you. :)
* Through the use of a LD_PRELOAD'd syscall wrapper library, you can
  forward system calls through CORBA to an arbitrary local/remote machine.
* CORBA servers are implemented as Linux kernel modules, so they may be
  dynamically loaded or unloaded from a running system at any time.  CORBA
  servers expose their IOR's through a /proc/corba filesystem.
* Filesystems may be implemented as remote CORBA objects and mounted on
  the local machine, by using 'mount -t corbafs -o IOR:... none /mnt/corba'

This are just some of the features available _RIGHT_NOW_ that are
supported by kORBit.  I'm sure that YOU can think of many more.

Implementation:
We implemented this port by providing a user->kernel mapping layer that
consists of providing standard system header files for the "user" code to
#include.  In these header files, we do the mapping required.  For
example, we implement a <stdio.h> that #defines printf to printk (as a
trivial example).  Only user level code sees or uses these wrappers... all
of our modifications to the Linux kernel are contained within the
linux/net/korbit subdirectory.  

This is currently implemented with a 2.4.0test10 kernel, although forward
porting should be very easy.  This project was implemented as a cs423
semester project by Chris Lattner, Fredrik Vraalsen, Andy Reitz, and Keith
Wessel at the University of Illinois @ Urbana Champaign.

Unresolved issues:
* Our poll model is not optimial.  Currently we actually do a real poll on
  a (struct socket *) set.  This causes relatively high latencies (on the
  order 1 second, worst case) for CORBA requests.  Our waitqueues are not
  working quite as well as they should.  :)
* Security is completely unimplemented.  Someone could use corba
  interfaces to read any file on your system, for example (if the
  CORBA-FileServer module is installed).  Thus, this is really more for
  prototyping and development than actual real world use. :)

If you have any questions or comments, please feel free to contact us at:

Chris Lattner, Fredrik Vraalsen, Andy Reitz, Keith Wessel
<korbit-cvs@lists.sourceforge.net>

btw, yes we are quite crazy, but what good is it to be normal and
conformist afterall?  :)




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
