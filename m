Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbSKCMg1>; Sun, 3 Nov 2002 07:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSKCMg1>; Sun, 3 Nov 2002 07:36:27 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36236 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261845AbSKCMg0>; Sun, 3 Nov 2002 07:36:26 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.GSO.4.21.0211022310240.25010-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211022310240.25010-100000@steklov.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 13:03:56 +0000
Message-Id: <1036328636.29646.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 04:28, Alexander Viro wrote:
> BTW, here's a fresh demonstration (found half an hour ago) that capabilities
> do *not* permit more lax attitude when writing stuff with elevated priveleges:
> 	* /usr/lib/games/nethack/recover is run at the boot time (as root)
> to recover crashed games.
> 	* Debian nethack 3.4.0-3.1 has it installed root.games and it
> is group-writable - cretinism in debian/rules, upstream is not guilty
> in that (BTW, so is /usr/lib/games/nethack/recover-helper).
> 	* ergo, any exploitable hole in sgid-games binary (rogue, for
> instance) is trivially elevated to root exploit.

This is why you also want something stronger than just capability
models. In a strong security system the following happens.

	User hacks nethack
	Users compromises recover  (and in doing so reduces its integrity)

Reboot
	Root tries to run recover
	Recover has insufficient integrity
	Error messages appear


You would also have a "game playing" role which would mean a compromised
game could only write to the game score and save files, and could only
read the nominated game configuration files.

The problem with this is its nontrivial to set up all the rules. Being
able to use namespaces to revoke rights is a big help. If we were to add
a capability for 'getting out of chroot' then we can also combine it
with chroot to drop users into an unpriviledged universe from which they
cannot escape because we took away the chroot stuff and we took away
rawio and so on

Alan

