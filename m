Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTKNJxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTKNJxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:53:22 -0500
Received: from mail.advantest.de ([213.61.178.178]:40460 "EHLO it.advantest.de")
	by vger.kernel.org with ESMTP id S262283AbTKNJxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:53:21 -0500
To: Andreas Schwab <schwab@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com>
	<3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random>
	<03Nov13.095622cet.122129@mojo.it.advantest.de>
	<20031113145301.GJ1649@x30.random> <jen0b047ir.fsf@sykes.suse.de>
From: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>
Organization: Jaluna
Date: 13 Nov 2003 23:09:56 +0100
In-Reply-To: <jen0b047ir.fsf@sykes.suse.de>
Message-Id: <03Nov14.105616cet.122140@mojo.it.advantest.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > On Wed, Nov 12, 2003 at 10:35:22PM +0100, Benoit Poulot-Cazajous wrote:
> >> Andrea Arcangeli <andrea@suse.de> writes:
> >> 
> >> > the usual problem, and the reason we need a sequence number (increased
> >> > before and after the repo update). A file lock not.
> >> 
> >> Or a file that contains md5sums of the other files in the tree. 
> >> After the rsync, you recompute the md5sums file, and if it does not match,
> >> rsync again. As a bonus feature, the md5sums file can be pgp-signed.
> >
> > agreed, this would work too and it has the advantage of working with the
> > mirrors too as far as the per-file updates are atomic (should always be
> > the case). This has the only disavanage of forcing the client and the
> > server to read all file contents (I normally don't rsync with -c).
> 
> This is not necessary, you only need to recompute the md5sums of changed
> files.

Well, if you really want to optimize (md5sum is fast, faster than a typical hd,
and much faster than gcc), check the most recent file. If its md5sum does not
match, rsync again. 
There are many ways to optimize the md5sum of the whole tree, when a previous
tree with a trusted md5sum file is available. "find -ls" can help there. But
make sure not to over-optimize, as servers with wrong md5sum files
will be DDOSed by their clients ;-)

  -- Benoit

