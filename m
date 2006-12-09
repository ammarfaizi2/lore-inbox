Return-Path: <linux-kernel-owner+w=401wt.eu-S936945AbWLILeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936945AbWLILeK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936942AbWLILeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:34:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48263 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936954AbWLILeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:34:08 -0500
Date: Sat, 9 Dec 2006 12:34:06 +0100
From: Jan Kara <jack@suse.cz>
To: Jim van Wel <jim@coolzero.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 Errors...
Message-ID: <20061209113406.GC10261@atrey.karlin.mff.cuni.cz>
References: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info> <20061209105436.GB10261@atrey.karlin.mff.cuni.cz> <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Here is the output of /proc/slabinfo
> 
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab>
> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata
> <active_slabs> <num_slabs> <sharedavail>
> jbd_4k                 5     10   4096    1    1 : tunables   24   12    8
> : slabdata      5     10      0
> ext3_inode_cache   22447  22696    968    4    1 : tunables   54   27    8
> : slabdata   5674   5674      0
> journal_head         740   1280     96   40    1 : tunables  120   60    8
> : slabdata     27     32    480
> buffer_head        56406  95386    104   37    1 : tunables  120   60    8
> : slabdata   2578   2578    480
  <snip>

  Thanks for the info. I should have said I'm interested about
/proc/slabinfo close to the state when the machine starts complaining
about OOM. Your current numbers look quite sensible so it's hard to see
if we really leak something or not...

> >> I have something really strange while running kernel 2.6.19.
> >>
> >> See the following lines:
> >>
> >> Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
> >> Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction: Out
> >> of
> >> memory in __ext3_journal_get_undo_access
> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
> >> ext3_free_blocks_sb:
> >> Out of memory
> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
> >> ext3_reserve_inode_write: Readonly filesystem
> >> Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in ext3_truncate: Out
> >> of memory
> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
> >> ext3_reserve_inode_write: Readonly filesystem
> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in ext3_orphan_del:
> >> Readonly filesystem
> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
> >> ext3_reserve_inode_write: Readonly filesystem
> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in ext3_delete_inode:
> >> Out of memory
> >>
> >> And three days later the same:
> >>
> >> Dec  8 08:24:29 kernel: do_get_write_access: OOM for frozen_buffer
> >> Dec  8 08:24:29 kernel: ext3_reserve_inode_write: aborting transaction:
> >> Out of memory in __ext3_journal_get_write_access
> >> Dec  8 08:24:29 kernel: EXT3-fs error (device md1) in
> >> ext3_reserve_inode_write: Out of memory
> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_dirty_inode:
> >> Out of memory
> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_new_blocks:
> >> Readonly filesystem
> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
> >> ext3_reserve_inode_write: Readonly filesystem
> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_dirty_inode:
> >> Out of memory
> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
> >> ext3_prepare_write:
> >> Out of memory
> >>
> >> Now the funny thing is, with kernel 2.6.18.3 I did not had these errors.
> >> Could it be my memory that is just going nuts, or something else? I have
> >> seen some other topics about the EXT3 corruption problems. Maybe this is
> >> also the same thing?
> >   Probably some error on the kernel's side. Maybe somebody (e.g. my new
> > code in jbd commit) forgets to release some buffers? What does your
> > /proc/slabinfo look like? Thanks for report.

								Honza
