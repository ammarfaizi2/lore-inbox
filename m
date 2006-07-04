Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWGDLfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWGDLfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWGDLfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:35:31 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32474 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S932179AbWGDLfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:35:30 -0400
Subject: Re: ext4 features
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1152004929.3374.13.camel@elijah.suse.cz>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <44A9904F.7060207@wolfmountaingroup.com>
	 <20060703232547.2d54ab9b.diegocg@gmail.com>
	 <1152004929.3374.13.camel@elijah.suse.cz>
Content-Type: text/plain; charset=utf-8
Date: Tue, 04 Jul 2006 13:35:06 +0200
Message-Id: <1152012907.23628.20.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 11:22 +0200, Petr Tesarik wrote:
> On Mon, 2006-07-03 at 23:25 +0200, Diego Calleja wrote:
> > El Mon, 03 Jul 2006 15:46:55 -0600,
> > "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:
> > 
> > > Add a salvagable file system to ext4, i.e. when a file is deleted, you 
> > > just rename it and move it to a directory called DELETED.SAV and recycle 
> > > the files as people allocate new ones.  Easy to do (internal "mv" of 
> > 
> > 
> > Easily doable in userspace, why bother with kernel programming
> 
> Yes and no. A simple mv is better done in userspace, but what I'd
> _really_ appreciate would be a true kernel salvage (similar to the way
> NetWare does things). That means marking the file as deleted in the
> directory, marking its blocks as deleted but avoiding the use of those
> blocks. The kernel would then prefer allocating new blocks from
> elsewhere but once the filesystem runs out of space, it would start
> allocating from the deleted files area and marking the blocks as well as
> the corresponding files purged.
> 
> Salvaging files would be done with a separate tool. Of course, if you
> delete more files with the same name in the same directory, you'd need
> to tell that tool which one of them you want to salvage. Yes, I really
> mean you'd have more than one deleted file with the same name in the
> directory.
> 
> Anyway, I doubt we want such feature for ext4, because to make things
> efficient, you'd need to provide some kind of pointer from the deleted
> (but not yet purged) blocks to the corresponding file. Hard links are
> also problematic and there is a whole lot of other troubles I haven't
> even thought of.

Wouldn't such a scheme interfere with the block allocator algorithms,
and hence increase the risk of fragmentation? Schemes like this realy
put my hairs on end,

  1) if you don't want to lose your data, make backups; 
  2) if I mean to delete a file, I want it gone proper. Silently keeping
     it about is not unix like;
  3) don't aid third parties in recovering your removed data. If I want
     them to have it I'll give it to them.

Peter

