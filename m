Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129164AbRC1EYi>; Tue, 27 Mar 2001 23:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129568AbRC1EY3>; Tue, 27 Mar 2001 23:24:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39665 "EHLO math.psu.edu") by vger.kernel.org with ESMTP id <S129164AbRC1EYV>; Tue, 27 Mar 2001 23:24:21 -0500
Date: Tue, 27 Mar 2001 23:23:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Johan Kullstam <kullstam@ne.mediaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <m2snjyk0il.fsf@euler.axel.nom>
Message-ID: <Pine.GSO.4.21.0103272306180.24341-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 Mar 2001, Johan Kullstam wrote:

> it might be a mostly userspace solvable problem.  a device daemon
> could create new devices on the fly, only they'd be ordinary
> filesystem devices.  for example it might be better to hack ls to not
> show dormant devices.  a cronjob could call a grim device reaper to
> cull nodes not used for a long time...

Why the hell do we have to reinvent every wheel out there? Especially
when we _already_ have that wheel... You don't need to hack ls in order
to deal with "dormant" entries. That's what autofs is for. Doing that
quite fine, thank you very much. Furrfu...
 
> what do other vaguely unix-like systems do?  does, say, plan9 have a
> better way of dealing with all this?

Plan9 doesn't have devfs. You can say
bind -a #f /dev
and that gives you /dev/fd[0-3]{disk,ctl}. I.e. /dev is a union of
device filesystems you've mounted (bound, actually) there. Combined
with autofs (and replacing bind #f with mount -t devfloppy) it's
pretty much what we could use.

Think of devpts - it's the same kind of beast. As for putting stuff into
/etc/fstab - not funny. /etc/auto_dev would do just fine, especially
if /etc/fstab would contain the minimal (==permanent) subset. Nothing stops
you from examining /lib/modules/ and updating /etc/auto_dev from rc scripts
upon boot.

