Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264682AbSJOUKm>; Tue, 15 Oct 2002 16:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264742AbSJOUKm>; Tue, 15 Oct 2002 16:10:42 -0400
Received: from thunk.org ([140.239.227.29]:49870 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264682AbSJOUKl>;
	Tue, 15 Oct 2002 16:10:41 -0400
Date: Tue, 15 Oct 2002 16:16:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Eaten filesystem and unhelpfull fsck
Message-ID: <20021015201625.GA29050@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20021015200511.GD19330@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015200511.GD19330@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:05:11PM +0200, Pavel Machek wrote:
> Hi!
> 
> I managed to kill filesystem on my omnibook... Now I'm pretty sure
> most of data should be undamaged [I did not do any long writes to it],
> but mount refuses to mount it and e2fsck refuses that, too.
> 
> fsck /dev/hda4
> fsck 1.24a (02-Sep-2001)
> ...
> try running...:
> 
> 	e2fsck -b 8193.
> 
> e2fsck -b 8193 /dev/hda4
> ....suggests me to run e2fsck -b 8193. Too bad. debugfs refuses to
> mount it, too. How do I get my data back?

1) Update to something more recent that e2fsprogs 1.24 --- there have
been a lot of bugfixes since then, especially in the arena of dealing
with various "special" cases of corruption.

2) Assuming that you are using filesystems with 4k blocksizes, the
backup superblock is at 32768.  More modern e2fsck's will correctly
fall back to the backup sb at 32768, but ancient versions (like the
one you're using) don't; that's one of the bugs that since been fixed.  :-)

You could *try* using e2fsck -b 32768 with your current version of
e2fsck, and it *probably* will be able to fix things without doing any
more damage, but without knowing more about how your filesystem got
screwed up, using a more recent version of e2fsck would be the safer
course of action.

							- Ted
