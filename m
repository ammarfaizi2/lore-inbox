Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265335AbRF0RoM>; Wed, 27 Jun 2001 13:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRF0RoC>; Wed, 27 Jun 2001 13:44:02 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:20673 "HELO
	mail.lysator.liu.se") by vger.kernel.org with SMTP
	id <S265335AbRF0Rnt>; Wed, 27 Jun 2001 13:43:49 -0400
Date: Wed, 27 Jun 2001 19:55:31 +0200
From: Jorgen Cederlof <jc@lysator.liu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
Message-ID: <20010627195531.D8203@ondska>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9hb6rq$49j$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.18i
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com ("H. Peter Anvin") writes:

> Followup to:  <20010627014534.B2654@ondska>
> By author:    Jorgen Cederlof <jc@lysator.liu.se>
> In newsgroup: linux.dev.kernel
> > If we only allow user chroots for processes that have never been
> > chrooted before, and if the suid/sgid bits won't have any effect under
> > the new root, it should be perfectly safe to allow any user to chroot.
> 
> Safe, perhaps, but also completely useless: there is no way the user
> can set up a functional environment inside the chroot.

Why? Because he can't create device nodes?

First of all, if /dev is on the same file system as the new root, the
user can ln the device nodes he wants to wherever he wants them in the
new root. He can't change their permissions, but that should not be
necessary.

Since I use devfs, I can't do that. But I decided to try how much I
can do anyway. So I downloaded the big redhat 7.1 image from User-mode
Linux. I unpacked it and extracted it to a directory using User-mode
Linux. Since I was a normal user, I could not create any device nodes
so I left /dev empty.

I chrooted into the directory. Most things seemed to work. I couldn't
use ping, since it needs to be suid root, and ps didn't work for
obvious reasons, but besides that everything looked OK.

I started an Xnest and started a gnome-session in it. Now I ran into
trouble. Some programs complained that they could not open
/dev/null. I touched /dev/null and put a couple of zeroes in /dev/zero
just in case. Now everything worked just fine. Gnome started and I
could run every application included.

The only thing that didn't work was terminal emulators. If I had not
been using devfs, but had /dev on the same file system as /tmp or ~, I
could have linked the needed device nodes. If you want to, you can
have a daemon running outside the root to mirror selected parts of
/proc into new_root/proc.

There are more uses for chroot than running user desktops, as has been
pointed out by others. The same arguments as implementing chroot for
root still applies.

Securing network daemons without needing to be root can be useful. As
an extra bonus, cracked daemons are prevented from gaining root access
from buggy suid binaries.

I'm sure you can think of more uses. Don't assume it has no uses just
because you can't think of anything in two minutes. I tend to use it
quite often now when I am used to it, and I often find it frustrating
to work on computers without this patch.

        Jörgen
