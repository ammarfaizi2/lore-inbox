Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314397AbSDRQzc>; Thu, 18 Apr 2002 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314398AbSDRQzb>; Thu, 18 Apr 2002 12:55:31 -0400
Received: from borg.org ([208.218.135.231]:35979 "HELO borg.org")
	by vger.kernel.org with SMTP id <S314397AbSDRQza>;
	Thu, 18 Apr 2002 12:55:30 -0400
Date: Thu, 18 Apr 2002 12:55:30 -0400
From: Kent Borg <kentborg@borg.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
Message-ID: <20020418125530.C16135@borg.org>
In-Reply-To: <20020418110558.A16135@borg.org> <20020418082025.N2710@work.bitmover.com> <20020418172758.Q4498@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 05:27:58PM +0200, Lars Marowsky-Bree wrote:
> Either that, or heuristics - file not written to / opened for writing in x
> minutes -> commit.

Something like that.  

We already have a hierarchy of degrees of saving:

 1. live state - the state of a program's data, possibly extended by
    undo/redo features.

 2. file - saved file, possibly extended by features like emacs'
    "file.c~"

 3. revision - revision checked into some revision control system

 4. checkpoint or tag - revision branded with a symbolic name in a
    revision control system

I am envisioning a richer version of the file stage.  Just as users
currently decide when to check in a version and when to checkpoint
versions, I am imagining that sort of decision would still be made,
but there would be a lower level of granularity that could be looked
at if desired.  Big infrequent changes to a file would all be
recorded, and frequent little changes would be subject to some
heuristic.  It doesn't make sense to record a file's state so often
that it isn't even self-consistent.  For example, recording all the
changes over the course of the save of a big Star Office drawing would
be silly, most would be intermediate and dependent on the changing
epheneral internal state of Star Office.  I don't know the details of
a reasonable heuristic other than obvious things such as when a file
of flushed or closed or not touched for some significant time.

> That would actually be pretty interesting because it might also allow you to
> back out editor screwups ;-)

Writing an editor to take advantage of such underlying features would
be pretty interesting too, it could be integrated into undo/redo
features.  

Navigating such an historical fabric turns into a really interesting
user interface problem.

> However, deducing change sets is more difficult.

I think change sets for source code would still be based on versions
declared by a human to be of some specific interest.  But changes sets
for a computer's configuration might be implicit in the running of rpm
or chkconfig, or reboots of the system, or saved edits to
configuration files.  Etc.

Certainly what I am envisioning would have immediate use in looking at
changes to specific files, but would require more structure imposed to
be useful a system configuration management tool or source code
control system.


I do point out that recently Microsoft announced some sort of feature
to let users backout system changes.  It sounds useful to me and I run
Linux, but should that have some basic system support and not be
kludged in?  (For example, such a feature could be added to rpm, but
it would only be good at capturing things done by rpm.)  Would a
versioning filesystem be part of doing it the right way?


-kb
