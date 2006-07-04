Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWGDQSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWGDQSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWGDQSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:18:23 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:6561 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932244AbWGDQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:18:22 -0400
Message-ID: <44AA954D.3030009@sbcglobal.net>
Date: Tue, 04 Jul 2006 11:20:29 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (salvage)
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060701170729.GB8763@irc.pl>	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>	 <20060703205523.GA17122@irc.pl>	 <1151960503.3108.55.camel@laptopd505.fenrus.org>	 <44A9904F.7060207@wolfmountaingroup.com>	 <20060703232547.2d54ab9b.diegocg@gmail.com>	 <1152004929.3374.13.camel@elijah.suse.cz> <1152012907.23628.20.camel@lappy> <1152013961.3374.78.camel@elijah.suse.cz>
In-Reply-To: <1152013961.3374.78.camel@elijah.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Stupid mailer + user error = not sent to list)

Petr Tesarik wrote:
 > On Tue, 2006-07-04 at 13:35 +0200, Peter Zijlstra wrote:
 >> On Tue, 2006-07-04 at 11:22 +0200, Petr Tesarik wrote:
 >>> Yes and no. A simple mv is better done in userspace, but what I'd
 >>> _really_ appreciate would be a true kernel salvage (similar to the way
 >>> NetWare does things). That means marking the file as deleted in the
 >>> directory, marking its blocks as deleted but avoiding the use of those
 >>> blocks. The kernel would then prefer allocating new blocks from
 >>> elsewhere but once the filesystem runs out of space, it would start
 >>> allocating from the deleted files area and marking the blocks as 
well as
 >>> the corresponding files purged.
 >>>
 >>> Salvaging files would be done with a separate tool. Of course, if you
 >>> delete more files with the same name in the same directory, you'd need
 >>> to tell that tool which one of them you want to salvage. Yes, I really
 >>> mean you'd have more than one deleted file with the same name in the
 >>> directory.
 >> Wouldn't such a scheme interfere with the block allocator algorithms,
 >> and hence increase the risk of fragmentation? Schemes like this realy
 >> put my hairs on end,
 >
 > Yes, they would interfere. That's why I'm not proposing to add them to
 > ext4 in the first place.
 >
 >>   1) if you don't want to lose your data, make backups;
 >
 > Generally, I agree.
 >
 >>   2) if I mean to delete a file, I want it gone proper. Silently keeping
 >>      it about is not unix like;
 >
 > Yes, this is a problem. Although you would of course have a tool for
 > purging the files unconditionally, some programs may need the assumption
 > that an unlinked file is gone forever.
 >
 > Regarding the second clause, well, Linux is not Unix-like in many
 > respects and we want it like that. That's a weak argument.

We silently keep files around in many filesystems, at least until
whatever reclamation process runs.  The delete event doesn't itself
generally purge the data from disk.  However, this is a matter of simple
tools doing simple things.  Designing an intentional structure around
not actually deleting deleted files, but keeping them around just in
case may be lauded as "user-friendly", but it is counter-intuitive.  It
is cleverness over clarity, good design smothered under feature demand.

In the ways in which it counts, in the sensible, useful, elegantly
simple ways, the "Do one thing and do it well" ways, Linux tries to be
Unix-like.  We want stupid programs.  A filesystem that decides that it
knows better than the user is not desirable.  Filesystem programmers
that decide that they know better than the user are likewise sub-optimal.

Protect my data against accidental failure.  Do not protect it against me.

If you have to add a "really delete, I mean it" command, you're breaking
fundamental assumptions.

 >
 >>   3) don't aid third parties in recovering your removed data. If I want
 >>      them to have it I'll give it to them.
 >
 > See 2. Explicit purging is of course possible. (Novell Netware also had
 > a "purge" command.)
 >
 > Anyway, it seems that there is some functionality which many users want
 > but which can't be provided in user space:
 >
 >   - if files are moved to the recycle-bin-or-whatever-you-call-it, their
 > size is added to disk free space and

Why add non-free space to the free space count, when we're intentionally
keeping those files?  If you have to be counter-intuitive, why go the
second counter of hiding it from the user who "wants us to keep and
index his deleted files"?

 >   - automatically purging least recently deleted files.
 >
 > Regards,
 > Petr Tesarik

Matt



