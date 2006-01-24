Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWAXVxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWAXVxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWAXVxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:53:04 -0500
Received: from thunk.org ([69.25.196.29]:62130 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750757AbWAXVxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:53:02 -0500
Date: Tue, 24 Jan 2006 16:28:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060124212843.GA15543@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <20060123203010.GB1820@merlin.emma.line.org> <1138092761.2977.32.camel@laptopd505.fenrus.org> <43D5EEA2.nailCE7111GPO@burner> <1138094141.2977.34.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138094141.2977.34.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 10:15:40AM +0100, Arjan van de Ven wrote:
> On Tue, 2006-01-24 at 10:08 +0100, Joerg Schilling wrote:
> > > the situation is messy; I can see some value in the hack Ted proposed to
> > > just bump the rlimit automatically at an mlockall-done-by-root.. but to
> > > be fair it's a hack :(
> > 
> > As all other rlimits are honored even if you are root, it looks not orthogonal 
> > to disregard an existing RLIMIT_MEMLOCK rlimit if you are root.
> 
> that's another solution; give root a higher rlimit by default for this.
> It's also a bit messy, but a not-unreasonable default behavior.

I thought in the case we were talking about, the problem is that we
have a setuid program which calls mlockall() but then later drops its
privileges.  So when it tries to allocate memories, RLIMIT_MEMLOCK
applies again, and so all future memory allocations would fail.  

What I proposed is a hack, but strictly speaking not necessary
according to the POSIX standards, but the problem is that a portable
program can't be expected to know that Linux has a RLIMIT_MEMLOCK
resource limit, such that a program which calls mlockall() and then
drops privileges will work under Solaris and fail under Linux.  Hence
I why proposed a hack where mlockall() would adjust RLIMIT_MEMLOCK.
Yes, no question it's a hack and a special case; the question is
whether cure or the disease is worse.

						- Ted
