Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317724AbSFLP0m>; Wed, 12 Jun 2002 11:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317725AbSFLP0l>; Wed, 12 Jun 2002 11:26:41 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:64428 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S317724AbSFLP0k>; Wed, 12 Jun 2002 11:26:40 -0400
Date: Wed, 12 Jun 2002 11:26:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs 2/4 mknod times
Message-ID: <20020612152642.GA2725@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0206120423200.1290-100000@localhost.localdomain> <200206112031.23257.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 08:31:20PM -0700, Ryan Cumming wrote:
> On June 11, 2002 20:25, Hugh Dickins wrote:
> > On Tue, 11 Jun 2002, Ryan Cumming wrote:
> > > On June 11, 2002 19:54, Hugh Dickins wrote:
> > > > +               dir->i_ctime = dir->i_mtime = CURRENT_TIME;
> > >
> > > I'm probably misreading this, but why does shmem_mknod modify the
> > > directory's ctime?
> >
> > Hmmm, good question.  Perhaps I'll have dreamt up an answer by morning.
> Well, lets see if the list has any ideas while you're sleeping.

My guess would be that 'mtime' should be always updated because the
directory contents is changed (a new name is added). And 'ctime' has to
change whenever this new name cause a change in the size of the
directory because the i_size attribute has changed.

As tmpfs doesn't really have on-disk blocks for it's directories, every
create will change the directory size. (as well as every unlink).

Jan

