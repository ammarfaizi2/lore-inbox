Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbQLLVz0>; Tue, 12 Dec 2000 16:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbQLLVzQ>; Tue, 12 Dec 2000 16:55:16 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:31237 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129965AbQLLVzE>;
	Tue, 12 Dec 2000 16:55:04 -0500
Date: Tue, 12 Dec 2000 17:26:26 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org,
        orbit-list@gnome.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <3A31BC6D.1CFB5221@haque.net>
Message-ID: <Pine.LNX.4.21.0012121719180.20891-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Dec 2000, Mohammad A. Haque wrote:

> It was just an example. Basically, you'd be able to do in with just
> about any language that has ORBit bindings.
> 
> Ben Ford wrote:
> > Why would you *ever* want to write a device driver in perl???
> 

Precisely... but also, there could be a case where perl would make
sense.  Consider an FTP filesystem.  There performance is not dictated by
the speed of the language, it's limited by bandwidth.  It could make sense
to write your almighty FTPfs like this:

1. Prototype it in Perl, get all the bugs out.
2. Rewrite in C in userspace, get all the bugs out.
3. recompile/relink in kernel space with no source modifications
4. ship product.  :)

The great thing that kORBit buys you is insulation of kernel space from
the drivers that are running... kinda like a microkernel.  I'm not going
to start a flamewar here about Linux and microkernels, but when doing
initial development work for a driver, the test/crash/reboot/fsck cycle is
a real pain (okay, maybe journalling helps a little, but you get the
idea).  What we're offering goes more like this:

1. Boot kernel
2. Install corbafs module for example
3. Start test filesystem in user space
4. mount test user space filesystem
5. test it, oh crap, it segfaulted.
6. CorbaFS gets exceptions trying to communicate to server, which it
relays to the kernel as -errno conditions.
7. You safely unmount corbafs
8. fix your bug
9. goto step #2.

Which is arguably nicer.  :)

The whole idea is that a bastard driver shouldn't take your kernel down if
you know it to be unreliable... if you trust the driver, then by all
means, don't use kORBit.  Also, kORBit is useful when you don't WANT
something in the kernel... and I won't bring up the whole user level
filesystem debate again... :)

-Chris

http://www.nondot.org/~sabre/os/
http://korbit.sourceforge.net/

> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/ 
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
