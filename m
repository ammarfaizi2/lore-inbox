Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRCGAiY>; Tue, 6 Mar 2001 19:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRCGAiN>; Tue, 6 Mar 2001 19:38:13 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:56589 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129737AbRCGAiD>;
	Tue, 6 Mar 2001 19:38:03 -0500
Date: Wed, 7 Mar 2001 01:37:29 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Tigran Aivazian <tigran@veritas.com>, Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hashing and directories
Message-ID: <20010307013729.A7184@pcep-jamie.cern.ch>
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0103012103140.754-100000@penguin.homenet> <20010302095608.G15061@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010302095608.G15061@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Fri, Mar 02, 2001 at 09:56:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > the space allowed for arguments is not a userland issue, it is a kernel
> > limit defined by MAX_ARG_PAGES in binfmts.h, so one could tweak it if one
> > wanted to without breaking any userland.
> 
> Which is exactly what I done on my system. 2MB for command line is
> very nice.

Mine too (until recently).  A proper patch to remove the limit, and copy
the args into swappable memory as they go (to avoid DoS) would be nicer,
but a quick change to MAX_ARG_PAGES seemed so much easier :-)

In my case, it was a Makefile generating the huge command lines.  There
were about 20000 source files and 80000 target files, and the occasional
long line "update the archive with these changed files: ..." ;-)

Splitting the file name list seemed so much more difficult.  You can't
even do "echo $(FILES) | xargs", as the "echo" command line is too long!

-- Jamie
