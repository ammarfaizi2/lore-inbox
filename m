Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUHAR3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUHAR3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHAR3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:29:22 -0400
Received: from sphinx.mythic-beasts.com ([212.69.37.6]:28356 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S265977AbUHAR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:29:12 -0400
Date: Sun, 1 Aug 2004 18:29:05 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: Andrea Arcangeli <andrea@cpushare.com>
cc: chris@scary.beasts.org, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
In-Reply-To: <20040801150119.GE6295@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com>
 <20040801102231.GB6295@dualathlon.random> <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
 <20040801150119.GE6295@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Andrea Arcangeli wrote:

> On Sun, Aug 01, 2004 at 01:01:10PM +0100, chris@scary.beasts.org wrote:
> > Hi Andrea,
> >
> > Do you have plans to generalize seccomp into somelike like a "syscall
> > firewall"? This _would_ be useful to many apps, and provide good security

[...]

> Seems like a few people is interested in what you suggest above. it'd be
> very trivial to add a seccomp-mode = 2 that adds more syscalls like the
> socket syscalls like accept/sendfile/send/recv and also the open syscall
> (which means you want to use chroot still).  In the code you can see I
> wrote it so that more modes can be added freely. I mean it has some
> flexibility already.  vsftpd could enable the seccomp mode 2 on itself
> after it has initialized.

Using the above approach, we (the app writers) would never agree on the
syscall lists required for different seccomp modes ;-)

How hard would it be to have a per-task bitmap of syscalls allowed? This
way, a task could restrict to the exact subset of syscalls required for
maximum security.
The bitmap would
- Be allocated on demand (for no overhead in the common case)
- Deny all syscalls not covered by the supplied bitmap, to cater for
syscall table expansion
- Be inherited across fork and (probably) shared across clone

Cheers
Chris
