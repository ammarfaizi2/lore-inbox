Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbSJCQUo>; Thu, 3 Oct 2002 12:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJCQUo>; Thu, 3 Oct 2002 12:20:44 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:41484 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261357AbSJCQUm>;
	Thu, 3 Oct 2002 12:20:42 -0400
Date: Thu, 3 Oct 2002 09:23:26 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Corry <corryk@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003162326.GB32588@kroah.com>
References: <02100216332002.18102@boiler> <20021002224343.GB16453@kroah.com> <02100307131100.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02100307131100.05904@boiler>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 07:13:11AM -0500, Kevin Corry wrote:
> On Wednesday 02 October 2002 17:43, Greg KH wrote:
> > Some comments on the code:
> > 	- you might want to post a patch with the whole evms portion of
> > 	  the code, for those people without BitKeeper to see.
> > 	- The #ifdef EVMS_DEBUG lines are still in AIXlvm_vge.c, I
> > 	  thought you said you were going to fix this file up?
> > 	- The OS2 and S390 files don't look like they have been fixed,
> > 	  like you said you would before submission.
> 
> I have been working on these, and should have them done very soon. At the 
> very least, I expect to get OS2 done today. I will let you know as soon as it 
> is ready.
> 
> > 	- evms_ecr.h and evms_linear.h have a lot of unneeded typedefs.
> 
> For the time being, I have removed these files from the tree. As I mentioned 
> the other day, they are a long way from providing any useful clustering 
> functionality.
> 
> > 	- the md code duplication has not been addressed, as you said it
> > 	  would be.
> 
> We will be addressing this. Unfortunately, I don't see this as being a 
> simple, overnight fix. Finding a way to consolidate the common code may take 
> some time.

My main point about these comments is that you stated in a message a few
days ago that you would fix these issues before trying to submit the
code for inclusion in the kernel.  As you can imagine, I was a bit
surprised to see them not fixed in this release you were proposing to be
included in the main tree :)

> > 	- the BK repository contains a _lot_ of past history and merges
> > 	  that are probably unnecessary to have.  A few, small
> > 	  changesets are nicer to look at :)
> 
> No offense meant, Greg, but that seems a bit contradictory. The way I see it, 
> I can maintain our Bitkeeper tree in one of two ways.
> 
> 1) Try to mirror the usage of our CVS tree. This means that each file or 
> small group of files that gets checked into CVS also gets checked into 
> Bitkeeper, and the comment logs can stay closely in sync. Doing this produces 
> a _lot_ of _small_ changesets, but each one is fairly easy to read and 
> understand. However, as you mentioned, it does produce a very long history.
> 
> 2) Just do a periodic sync with the current CVS tree, maybe every three days 
> or so. This will obviously produce far less history, but each changeset may 
> be quite large, and thus harder to read and understand, especially since the 
> comments will likely be something along the lines of "sync'ing with CVS".

Note, this is just my opinion of how to use BitKeeper, not the "rule":

You can use BitKeeper for kernel development in two ways:
	- as a tree to work out of, accepting changes and doing
	  incremental things all along the way, including merging with
	  the main releases.
	- or as a way to send changes to a maintainer.

I don't think you can really have it both ways, like you are trying to
do here.  Your repository contains 138 changesets that are not in the
main tree.  That's not a nice thing to try to make someone pull from (I
know in my USB work, I sure wouldn't do that.)

It's much nicer (this is just my opinion as a maintainer who uses
BitKeeper, I don't speak for Linus) to be presented with a tree to pull
from that _only_ contains a small number of changes.  Not 138 different
changes.

So I recommend you use two BitKeeper trees.  One to do your work out of
(much like the one you have today), and one that you use to send changes
to other people with.  I know the JFS group does it this way, if you
want to see another example besides the USB group.

> So, I will send in a few patches that introduce just the core code so 
> everyone can get a good look. There will be four files coming: evms.c, 
> evms.h, evms_ioctl.h, and evms_biosplit.h.

Thank you, that sounds like a much saner approach.

thanks,

greg k-h
