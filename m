Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTFQQIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbTFQQIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:08:24 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:61312 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264651AbTFQQIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:08:22 -0400
Date: Tue, 17 Jun 2003 17:29:56 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306171629.h5HGTuaL000643@81-2-122-30.bradfords.org.uk>
To: herbert@13thfloor.at
Subject: Re: 2.4.21 Floppy Fallback with NFS root ...
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I'm curious, is it intentional that, if you select
> > > NFS support and NFS Root support, that the fact, that
> > > no nfs is available, or selected via boot options,
> > > automatically leads to a floppy boot?
> > > 
> > > I would suggest the following trivial patch, to give
> > > the kernel compiler a chance to disable this 'feature'.
> > > 
> > > please correct me if I'm talking nonsense ...
> > 
> > This might be okay for 2.5.X, but its definitely bad idea for
> > 2.4.X. (User visible change without good reason).

If it defaults to off, it shouldn't be a problem.

> okay, first the good reason :)

>  currently it is not possible to compile a kernel with 
>  root NFS support, which in case of NFS failure, (or
>  missing NFS/network options) boots from HD, instead
>  it asks you to insert a Floppy ...

For 2.5, it might be more useful if the default NFS-on-root
configuration is to wait for 60 seconds, and retry, if there is an
error.  If a machine is re-booted remotely, and it can't contact the
server for any reason, it's not really very desirable to have it wait
for you to insert a floppy :-)

> and now ad 'user visible change' ...

> what if I make it CONFIG_NOFLOPPY_FALLBACK and
> change the #ifdef to #ifndef ? This would give
> the same (strange?) behaviour as now, but an option
> to disable the fallback (to floppy) ...

I'm not really sure how useful the root filesystem on floppy option
is.  I'd imagine that it is probably a relic from the times when a lot
of people booted the kernel image directly, instead of using a
bootloader.  It would be quite useful in those circumstances, as you
wouldn't have a bootloader prompt to override the default for the root
filesystem.

Since 2.6 will no longer have the in-kernel bootloader, I suggest we
remove this functionality as well, and replace it with the wait 60
seconds and retry functionalily I described above.

It would be worth putting this in to 2.4, though.

Oh, and it would be even better if it tried the second floppy drive in
the case that the first one didn't contain a disk, (in case somebody
wants to mount a 5.25" floppy as the root filesystem, and their 5.25"
drive is the secondary one).

John.
