Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTKLQUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTKLQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:20:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:52126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263544AbTKLQUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:20:34 -0500
Date: Wed, 12 Nov 2003 08:19:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Maciej Zenczykowski <maze@cela.pl>
cc: Solar Designer <solar@openwall.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311121204140.26451-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.44.0311120814360.3288-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Nov 2003, Maciej Zenczykowski wrote:
> 
> I've managed to cut the problem down to the openwall patch
> (linux-2.4.22-ow1).

It really looks like this patch just triggers the real issue. I can't even
begin to speculate _how_ it would trigger it, though. At a guess, it might
just trigger a bug in the X server that might depend on how the mmap's are
laid out - and the strace might be needed just to get a lot of scheduling
activity and a large stream of X events (without it, the pty connection to
the xterm would mostly end up "chunking" the output of the "ls -lR" and
xterm would end up doing a lot more fastscrolls).

Just a theory. 

Do you have another machine on the network? In particular, some crashes
under X are literally just the X server crashing. Sometimes that takes the
whole machine down with it (if it causes X to do stuff to the video card
that the video card really doesn't like), but quite often you can still
ping the machine and maybe log in remotely even when it appears otherwise
dead.

			Linus

