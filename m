Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129613AbRBYTNc>; Sun, 25 Feb 2001 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129629AbRBYTNM>; Sun, 25 Feb 2001 14:13:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12429 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129621AbRBYTNG>;
	Sun, 25 Feb 2001 14:13:06 -0500
Date: Sun, 25 Feb 2001 14:13:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Sandy Harris <sandy@storm.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <3A99569F.98C64B29@storm.ca>
Message-ID: <Pine.GSO.4.21.0102251406200.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Sandy Harris wrote:

> One is just mount a ramdisk and extract a tarball into its root. Yes, this has
> some problems -- how do you load tar when you haven't set up your root? -- but
> I suspect they can be solved. At worst, this would involve some strictly limited
> kluge to do that.

No kludges actually needed. "Simplified boot sequence" _is_ simplified -
we overmount the "final" root over ramfs. Initially empty. So you have
the normal environment when you load ramdisk, etc.

IOW, with the namespaces patch you can have root (empty, writable)
as soon as you've registered ramfs driver. I.e. _very_ early - before
device initialization, for one thing. Actual mounting of the "final"
root happen very late, along with all initrd games, etc. That stuff
(in do_mounts.c) could be executed as userland process, actually -
see the comments in init/do_mounts.c and actual code there.
							Cheers,
								Al

