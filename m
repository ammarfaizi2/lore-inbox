Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282523AbRL0V3A>; Thu, 27 Dec 2001 16:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282276AbRL0V2u>; Thu, 27 Dec 2001 16:28:50 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49094 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282523AbRL0V2l>; Thu, 27 Dec 2001 16:28:41 -0500
Date: Thu, 27 Dec 2001 14:28:42 -0700
Message-Id: <200112272128.fBRLSgW01813@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33L.0112271802130.12225-100000@duckman.distro.conectiva>
In-Reply-To: <200112271957.fBRJvdv00960@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33L.0112271802130.12225-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Thu, 27 Dec 2001, Richard Gooch wrote:
> 
> > If you get this working nicely, it might even be a generally useful
> > thing. A set of perl scripts and easy interface commands could prove
> > popular. I would certainly find it convenient to have a patch
> > retransmission system that re-sent patches every time a new pre-patch
> > came out, and emailed me when the patch no longer applies.
> 
> ... or compiles, or applies with an offset

Yes, that was implied. If a patch doesn't apply 100% cleanly with no
fuzz, it should be de-queued and the patch log sent back to me. I'd
want to go in manually and see what's changed (harsh, but reduces the
potential for bit-rot).

> > If it could automatically de-queue when the patch is applied, or when
> > I manually remove it, that would be even better.
> 
> ... or when somebody replies to the patch and the reply
> gets caught by a program invoked from your .procmailrc

Yes. But be careful here. I don't want a DoS attack on my queue just
by having people reply to patch announcements.

> If Linus replies he has seen the patch, don't keep
> bombing him.

Yes, although it might be hard to classify properly. A message like
"not now, I'm busy, send it later" shouldn't de-queue.

> Of course when the patch gets dequeued, the program should
> send you a mail with the reason.

Always. I think I'd also want to be notified every time the patch is
sent upstream. I like to know things are still working.

> > And if I make an update to a queued patch, it obsoletes the old one,
> > that would be good too.
> 
> Good one, this needs to be added.
> 
> Any more requirements / ideas / volunteers / ... ?

I was thinking some more about this in the shower. I'd want some kind
of hierarchical tree processing, that supports multiple kernel
versions (and hence upstream maintainers) and multiple patches per
kernel.

$ROOT/
	MAINTAINER	(file with my email address)
	v2.4/
		UPSTREAM-MAINTAINER	(file with email address)
		official		(symlink to kernel/v2.4)
		build			(symlink to build tree)
		configs/		(directory of config files to try)
		proj1/
			patch.gz	(symlink elsewhere)
			.status
			comment		(file with "Hi, Marcelo, this does...")
			configs/	(directory of config files to try)
		proj1/
			patch.gz	(symlink elsewhere)
			.status

	v2.5/
		UPSTREAM-MAINTAINER	(file with email address)
		official		(symlink to kernel/v2.5)
		build			(symlink to build tree)

You get the idea. The config files are used to do test compilations,
and it would be nice if I could tag some config files so that the
resultant kernel and modules are moved into some other place. Perhaps
just by invoking a user-specified script. The per-project config files
supplement the per kernel-version config files.

The script which manages this should be lightweight enough to process
the tree every minute (so that newly queued patches are sent quickly)
and should be designed to also work with a .procmailrc recipe that is
called when your local kernel.org mirror is updated.

Probably files like MAINTAINER and UPSTREAM-MAINTAINER should be
scanned for in every directory, so that files further down override
ones above. Maybe I have a networking patch that I want to send to
Dave rather than to Linus.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
