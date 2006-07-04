Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWGDLz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWGDLz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWGDLz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:55:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:11224 "EHLO elijah.suse.cz")
	by vger.kernel.org with ESMTP id S932225AbWGDLz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:55:57 -0400
From: Petr Tesarik <ptesarik@suse.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1152012907.23628.20.camel@lappy>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <44A9904F.7060207@wolfmountaingroup.com>
	 <20060703232547.2d54ab9b.diegocg@gmail.com>
	 <1152004929.3374.13.camel@elijah.suse.cz> <1152012907.23628.20.camel@lappy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1152013961.3374.78.camel@elijah.suse.cz>
Mime-Version: 1.0
Subject: Re: ext4 features (salvage)
Organization: SuSE CR
Date: Tue, 04 Jul 2006 13:55:54 +0200
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 13:35 +0200, Peter Zijlstra wrote:
> On Tue, 2006-07-04 at 11:22 +0200, Petr Tesarik wrote:
> > Yes and no. A simple mv is better done in userspace, but what I'd
> > _really_ appreciate would be a true kernel salvage (similar to the way
> > NetWare does things). That means marking the file as deleted in the
> > directory, marking its blocks as deleted but avoiding the use of those
> > blocks. The kernel would then prefer allocating new blocks from
> > elsewhere but once the filesystem runs out of space, it would start
> > allocating from the deleted files area and marking the blocks as well as
> > the corresponding files purged.
> > 
> > Salvaging files would be done with a separate tool. Of course, if you
> > delete more files with the same name in the same directory, you'd need
> > to tell that tool which one of them you want to salvage. Yes, I really
> > mean you'd have more than one deleted file with the same name in the
> > directory.
> 
> Wouldn't such a scheme interfere with the block allocator algorithms,
> and hence increase the risk of fragmentation? Schemes like this realy
> put my hairs on end,

Yes, they would interfere. That's why I'm not proposing to add them to
ext4 in the first place.

>   1) if you don't want to lose your data, make backups; 

Generally, I agree.

>   2) if I mean to delete a file, I want it gone proper. Silently keeping
>      it about is not unix like;

Yes, this is a problem. Although you would of course have a tool for
purging the files unconditionally, some programs may need the assumption
that an unlinked file is gone forever.

Regarding the second clause, well, Linux is not Unix-like in many
respects and we want it like that. That's a weak argument.

>   3) don't aid third parties in recovering your removed data. If I want
>      them to have it I'll give it to them.

See 2. Explicit purging is of course possible. (Novell Netware also had
a "purge" command.)

Anyway, it seems that there is some functionality which many users want
but which can't be provided in user space: 

  - if files are moved to the recycle-bin-or-whatever-you-call-it, their
size is added to disk free space and
  - automatically purging least recently deleted files.

Regards,
Petr Tesarik
