Return-Path: <linux-kernel-owner+w=401wt.eu-S1750714AbXAIAEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbXAIAEn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbXAIAEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:04:43 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53453 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXAIAEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:04:42 -0500
Date: Mon, 8 Jan 2007 19:03:35 -0500
Message-Id: <200701090003.l0903Z2O017720@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Mon, 08 Jan 2007 14:02:24 PST."
             <20070108140224.3a814b7d.akpm@osdl.org> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20070108140224.3a814b7d.akpm@osdl.org>, Andrew Morton writes:
> On Mon, 08 Jan 2007 16:30:48 -0500
> Shaya Potter <spotter@cs.columbia.edu> wrote:
> 

> Well yes.  So the top-level question is "is this the correct way of doing
> unionisation?".

> I suspect not, in which case unionfs is at best a stopgap until someone
> comes along and implements unionisation at the VFS level, at which time
> unionfs goes away.
> 
> That could take a long time.  The questions we're left to ponder over are
> things like
> 
> a) is unionfs a sufficiently useful stopgap to justify a merge and
> 
> b) would an interim merge of unionfs increase or decrease the motivation
>    for someone to do a VFS implementation?
> 
> I suspect the answer to b) is "increase": if unionfs proves to be useful
> then people will be motivated to produce more robust implementations of the
> same functionality.  If it proves to not be very useful then nobody will
> bother doing anything, which in a way would be a useful service.
> 
> 
> Is there vendor interest in unionfs?

Andrew, you bring up a very good point (others have asked this legitimate
question before).  As someone who (together with a "few" students :-)
probably wrote the most stackable file systems ever (see
www.filesystems.org), I can say the following:

Unionfs is definitely useful.  Just see www.unionfs.org for the list of
current official projects which use unionfs.  Many of those projects are
used by many many thousands of users world wide.  Plus we know from personal
contacts that there are various companies and researchers who are using
Unionfs in all kinds of interesting ways.  The amount of feedback we got,
and the help from users (in the form of patches, testing, etc.) has been
phenomenal and even surprised me to a point where I realized I had to
allocate permanent resources (people, equipment, and $$$) to this project.

A stackable file system has a split personality.  Its bottom half behaves
like a mini VFS and treats lower file systems just as the VFS would.  Its
top half exports a file system interface and responds to the real VFS just
as a file system would.  It's where the two halves meet that the most
complex coding exists.

Many of the stackable file systems we've written offer functionality that is
naturally useful for all file systems, and hence may very well belong at the
VFS level.  For example, encryption may not really to need a full-fledged
file system, if the VFS allowed me to cleanly intercept and "overload"
certain operations relating to file reads/writes, as well as file-name ops,
on a per file/dir basis.  I've always envisioned that one day a VFS may
exist (in Linux or anywhere) which was designed with this kind of
extensibility in mind (if you read some one the stacking papers from the
early 90s, that's what they talked about).

However, I must caution that a file system like ecryptfs is very different
from Unionfs, the latter being a fan-out file system---and both have very
different goals.  The common code between the two file systems, at this
stage, is not much (and we've already extracted some of it into the "stackfs
layer").  I think more experience is needed before anyone tries to merge
them or move their functionality up to the VFS layer.

Stacking's main benefit is incremental file system extensibility.  I do
believe that ultimately, that's where a lot of stacking-like functionality
belongs: as VFS-level loadable extensions.  But that'd require an overhaul
of the VFS (which may have to be split into a re-entrant sub-layer and a
generic layer) and probably serious work on the VM/MM layers as well.  If
that will happen, I'd like to see it happening the right way, such that it
can help support a lot more than just unioning-like functionality.

Having seen the growing interest in stacking over the past 10+ years, and
esp. Unionfs/ecryptfs, I believe you'll see more stackable file systems
being developed and offered for inclusion.  I'm certain that numerous people
will use an official Unionfs in the kernel if/when it gets there.  I believe
some functionality can and would be generalized each time a new stackable
f/s is developed for Linux.  I'd be happy to help generalize the stacking
infrastructure in Linux over time, and, once there's enough experience, to
work on extensible VFS support.

Sincerely,
Erez.
