Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbSJ1XaM>; Mon, 28 Oct 2002 18:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJ1XaL>; Mon, 28 Oct 2002 18:30:11 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:16142 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S261934AbSJ1X3z>; Mon, 28 Oct 2002 18:29:55 -0500
Date: Mon, 28 Oct 2002 23:36:13 +0000 (GMT)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
In-Reply-To: <87smyqnpf3.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Oct 2002, Olaf Dietsche wrote:

> Solving the last issue (checking access to the capabilities database)
> involves filesystem support, I guess. So, this will be the next step
> to address.
>
> If you're careful with giving away capabilities however, this patch
> can make your system more secure as it is. But this isn't fully
> explored, so you might achieve the opposite and open new security
> holes.

Have you checked how glibc handles an executable with filesystem
capabilities? e.g. can an LD_PRELOAD hack subvert the privileged
executable?
I'm not sure what the current glibc security check is, but it used to be
simple *uid() vs. *euid() checks. This would not catch an executable with
filesystem capabilities.
Have a look at
http://security-archive.merton.ox.ac.uk/security-audit-199907/0192.html

I think the eventual plan was that we pass the kernel's current->dumpable
as an ELF note. Not sure if it got done. Alternatively glibc could use
prctl(PR_GET_DUMPABLE).

Cheers
Chris

