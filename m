Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUBQMAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 07:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUBQMAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 07:00:46 -0500
Received: from gprs155-60.eurotel.cz ([160.218.155.60]:47233 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266124AbUBQMAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 07:00:45 -0500
Date: Tue, 17 Feb 2004 13:00:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Robert White <rwhite@casabyte.com>
Cc: "'Theodore Ts'o'" <tytso@mit.edu>, "'the grugq'" <grugq@hcunix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040217120021.GB392@elf.ucw.cz>
References: <20040204062936.GA2663@thunk.org> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At which point, in the presence of the theoretical mount option, it becomes
> easy to reduce the work load to "a long list of block operations" by making
> the shredding unconditional.
> 
> That is, instead of thinking of it as shredding a file, the (arbitrarily
> named) "zerofree" mount option is passed and every block that is released
> from active file system use is zeroed.  E.g. file blocks, directory blocks,
> attribute blocks, everything.  That just takes (at the worst) a list/queue
> and a block-write of a block-sized page containing all zeros (or, better
> yet, an optionally-user-supplied squeegee pattern.)  So take/make the
> free_block() routine and make it submit a "dirty block" to the I/O buffering
> system.  If the block is immediately re-used then even the write expense
> amortizes to near zero for clearing that block (or unwritten
> fragment).

I see a small problem with that: some "interesting" data, such as file
names, are smaller than a block. With this kind of implementation,
you'd never wipe those.
								Pavel
[un-erase no longer works even on ext3, that's nothing new]

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
