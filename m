Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUCSJLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCSJLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:11:54 -0500
Received: from mail.shareable.org ([81.29.64.88]:33166 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262035AbUCSJLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:11:52 -0500
Date: Fri, 19 Mar 2004 09:11:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040319091148.GC2650@mail.shareable.org>
References: <20040315235243.GA21416@wohnheim.fh-wedel.de> <200403161618.i2GGITKK004831@eeyore.valparaiso.cl> <20040316171038.GA27046@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040316171038.GA27046@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> And version control is something I actually want to be done inside the
> kernel, at least to some degree.  People already use kernel support,
> although it sucks (cp -lr anyone?).  Looks like the alternatives suck
> even more, so your point is void.

Fwiw, I much prefer your COW hard links to something where I have to
mount a new filesystem every time I "copy" a tree, and have to redo
those mounts each time I reboot, have a big ugly mess in "df" output,
what "du" get confused, and "rsync" has no hope of dealing with them
sensibly.

I also don't mind if copying isn't implemented in the kernel.  I'm ok
with programs reporting an error that they couldn't write to a file
because it was linked readonly.  At least that removes the danger of
accidental overwriting, and I can either fix it by hand or use an
LD_PRELOAD library which detects that error code from open() and
copies the file.

Even if vi and Emacs, which make it temptingly easy to ignore normal
read-only protection, were changed to be aware of and bypass the
read-only link attribute, they'd do the right thing: the attribute
expresses the _intent_ that removing it should always be done by
copying the file, whereas with hard links that intent isn't clear.
(Emacs has backup-by-copying-when-linked, but that isn't too helpful
because sometimes you want writing to a linked file to change both places).

So my vote is for the very simple COW hard link attribute, and leave
the rest to userspace.

Thanks!
-- Jamie
