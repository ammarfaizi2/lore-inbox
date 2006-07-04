Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWGDJWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWGDJWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGDJWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:22:13 -0400
Received: from styx.suse.cz ([82.119.242.94]:10451 "EHLO elijah.suse.cz")
	by vger.kernel.org with ESMTP id S1751242AbWGDJWM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:22:12 -0400
Subject: Re: ext4 features
From: Petr Tesarik <ptesarik@suse.cz>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060703232547.2d54ab9b.diegocg@gmail.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <44A9904F.7060207@wolfmountaingroup.com>
	 <20060703232547.2d54ab9b.diegocg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: SuSE CR
Date: Tue, 04 Jul 2006 11:22:08 +0200
Message-Id: <1152004929.3374.13.camel@elijah.suse.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 23:25 +0200, Diego Calleja wrote:
> El Mon, 03 Jul 2006 15:46:55 -0600,
> "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:
> 
> > Add a salvagable file system to ext4, i.e. when a file is deleted, you 
> > just rename it and move it to a directory called DELETED.SAV and recycle 
> > the files as people allocate new ones.  Easy to do (internal "mv" of 
> 
> 
> Easily doable in userspace, why bother with kernel programming

Yes and no. A simple mv is better done in userspace, but what I'd
_really_ appreciate would be a true kernel salvage (similar to the way
NetWare does things). That means marking the file as deleted in the
directory, marking its blocks as deleted but avoiding the use of those
blocks. The kernel would then prefer allocating new blocks from
elsewhere but once the filesystem runs out of space, it would start
allocating from the deleted files area and marking the blocks as well as
the corresponding files purged.

Salvaging files would be done with a separate tool. Of course, if you
delete more files with the same name in the same directory, you'd need
to tell that tool which one of them you want to salvage. Yes, I really
mean you'd have more than one deleted file with the same name in the
directory.

Anyway, I doubt we want such feature for ext4, because to make things
efficient, you'd need to provide some kind of pointer from the deleted
(but not yet purged) blocks to the corresponding file. Hard links are
also problematic and there is a whole lot of other troubles I haven't
even thought of.

Just my two cents.

--
Petr Tesarik
