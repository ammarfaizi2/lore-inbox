Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292428AbSBZRiL>; Tue, 26 Feb 2002 12:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292422AbSBZRiB>; Tue, 26 Feb 2002 12:38:01 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52733
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292421AbSBZRhq>; Tue, 26 Feb 2002 12:37:46 -0500
Date: Tue, 26 Feb 2002 09:38:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226173822.GN4393@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.4.44L.0202261419240.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0202261419240.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 02:22:31PM -0300, Rik van Riel wrote:
> On Tue, 26 Feb 2002, Mike Fedyk wrote:
> > On Tue, Feb 26, 2002 at 06:07:49PM +0100, Martin Dalecki wrote:
> > > >>For the educated user it was always a pain
> > > >>in the you know where, to constantly run out of quota space due to
> > > >>file versioning.
> > > >>
> > > >
> > > >Ahh, so we'd need to chown the files to root (or a configurable user and
> > > >group) to get around the quota issue.
> > >
> > > Welcome to my kill-file. This just shows that you don't even have basic
> > > background.
> >
> > Thank you.
> >
> > Now, if I'm talking out of my ass, can someone sane say so?
> 
> Your idea should work on deletion, when the inode were
> about to be destroyed, but ...
> 
> > It would only call chown/chgrp on the files *inside* the undelete dir,
> > and user,group,etc would have to be accounted for in another way.  Am I
> > going in the wrong direction?
> 
> ... of course, there still is the problem of hard links.
> 

I had considered hard links.  Take a look at my another message from me in
this thread and see Daniel's response to it.

Basically, it would only move the files to the undelete area if the link
count == 1.  If you just decremented the link, then unlink() in glibc would
work as it does now.

Mike
