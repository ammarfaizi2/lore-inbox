Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264680AbSKDOdo>; Mon, 4 Nov 2002 09:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSKDOdo>; Mon, 4 Nov 2002 09:33:44 -0500
Received: from thunk.org ([140.239.227.29]:415 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264680AbSKDOdn>;
	Mon, 4 Nov 2002 09:33:43 -0500
Date: Mon, 4 Nov 2002 09:39:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021104143927.GB9197@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	Dax Kelson <dax@gurulabs.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	davej@suse.de
References: <Pine.LNX.4.44.0211022128050.2633-100000@home.transmeta.com> <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 01:37:19AM -0500, Alexander Viro wrote:
> > In other words, it would actually make perfect sense to have 
> > 
> >   -r-sr-sr-x    1 nobody  mail  451280 Apr  8  2002 /usr/bin/sendmail
> > 
> >   mount --bind --capability=chown,bindlow /usr/bin/sendmail /usr/bin/sendmail
> 
> *blam*
> 
> Congratulations with potential crapload of security holes - now anyone
> who'd compromised a process running as nobody can chmod the damn thing
> and modify it.
> 
> And that is the reason why suid-nonroot is bad.  It creates a class of
> binaries that can easily give you a root compromise if one of them has
> an exploit - even if that one is never run by root.

This is solved by some implementations of POSIX capabilities by
zapping any capabilities if the executible is modified --- just as
some Unix systems zap the setuid bit if the executable is modified.
It addresses specifically the problem that you've raised.

						- Ted
