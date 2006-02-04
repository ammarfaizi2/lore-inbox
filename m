Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946238AbWBDBIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946238AbWBDBIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946243AbWBDBIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:08:41 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:5124 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1946238AbWBDBIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:08:41 -0500
Date: Sat, 4 Feb 2006 02:08:33 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204010833.GD4845@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
	linux-kernel@vger.kernel.org
References: <20060202132708.62881af6.akpm@osdl.org> <200602030918.07006.nigel@suspend2.net> <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com> <20060202171812.49b86721.akpm@osdl.org> <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com> <20060203114948.GC2972@elf.ucw.cz> <1139010204.2191.14.camel@coyote.rexursive.com> <20060203235546.GB3291@elf.ucw.cz> <20060204003659.GC4845@dspnet.fr.eu.org> <20060204004944.GE3291@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204004944.GE3291@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 01:49:44AM +0100, Pavel Machek wrote:
> > Why don't you try to design the system so that the progress bar can't
> > fuck up the suspend unless they really, really want to?  Instead of
> > one where a forgotten open(O_CREAT) in a corner of graphics code can
> > randomly trash the filesystem through metadata corruption?
> 
> Even if I only put chrome code to userspace, open() would still be
> deadly. I could do something fancy with disallowing syscalls,

Nah, simply chroot to an empty virtual filesystem (a tmpfs with max
size=0 will do) and they can't do any fs-related fuckup anymore.  Just
give them a fd through which request some specific resources
(framebuffer mmap essentially I would say) and exchange messages with
the suspend system (status, cancel, etc) and maybe log stderr for
debugging purposes and that's it.  They can't do damage by mistake
anymore.  They can always send signals to random pids, but that's not
called a mistake at that point.

Even better, you can run _multiple_ processes that way, some for
compression/encryption, some for chrome, etc.


> but it
> is probably easier to just read the chrome code to be used... It
> should be as simple as memcpy(framebuffer, prepared image).

I guess I just can't trust chrome code.  I've have seen too much of it
to be able to.  Especially since once you open the gates a simple
animated-gif equivalent won't be considered enough, and userland code
does not go through the same kind of filters kernel code does.

Anybody and his dog will be able to take your userland suspend code,
add their neogeo emulator to play while it's suspending, and then
point at you when their fs got eaten after the tenth reboot.  And
distribs will pick it up because it's cool.

  OG.

