Return-Path: <linux-kernel-owner+w=401wt.eu-S1758067AbWLILoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067AbWLILoy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759432AbWLILoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:44:54 -0500
Received: from hempcity.net ([81.171.100.190]:45989 "EHLO hempcity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758067AbWLILox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:44:53 -0500
Message-ID: <19683.62.194.65.8.1165664691.squirrel@webmail.coolzero.info>
In-Reply-To: <20061209113406.GC10261@atrey.karlin.mff.cuni.cz>
References: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info>
    <20061209105436.GB10261@atrey.karlin.mff.cuni.cz>
    <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info>
    <20061209113406.GC10261@atrey.karlin.mff.cuni.cz>
Date: Sat, 9 Dec 2006 12:44:51 +0100 (CET)
Subject: Re: Ext3 Errors...
From: "Jim van Wel" <jim@coolzero.info>
To: "Jan Kara" <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Reply-To: jim@coolzero.info
User-Agent: SquirrelMail/1.4.8-2.el4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Well, that's kind of difficult because it looks a little random when he
does it, and a interval of three days, but also is maybe random.

And the most difficult part is it's only for three seconds, and than it's
gone, so making a crontab script every minute might not even notice it?

Or am I just making a mistake here?

Thanks!

Jim.


>   Hi,
>
>> Here is the output of /proc/slabinfo
>>
>> slabinfo - version: 2.1
>> # name            <active_objs> <num_objs> <objsize> <objperslab>
>> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata
>> <active_slabs> <num_slabs> <sharedavail>
>> jbd_4k                 5     10   4096    1    1 : tunables   24   12
>> 8
>> : slabdata      5     10      0
>> ext3_inode_cache   22447  22696    968    4    1 : tunables   54   27
>> 8
>> : slabdata   5674   5674      0
>> journal_head         740   1280     96   40    1 : tunables  120   60
>> 8
>> : slabdata     27     32    480
>> buffer_head        56406  95386    104   37    1 : tunables  120   60
>> 8
>> : slabdata   2578   2578    480
>   <snip>
>
>   Thanks for the info. I should have said I'm interested about
> /proc/slabinfo close to the state when the machine starts complaining
> about OOM. Your current numbers look quite sensible so it's hard to see
> if we really leak something or not...
>
>> >> I have something really strange while running kernel 2.6.19.
>> >>
>> >> See the following lines:
>> >>
>> >> Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
>> >> Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction:
>> Out
>> >> of
>> >> memory in __ext3_journal_get_undo_access
>> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> >> ext3_free_blocks_sb:
>> >> Out of memory
>> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> >> ext3_reserve_inode_write: Readonly filesystem
>> >> Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in ext3_truncate:
>> Out
>> >> of memory
>> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> ext3_reserve_inode_write: Readonly filesystem
>> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> ext3_orphan_del:
>> >> Readonly filesystem
>> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> ext3_reserve_inode_write: Readonly filesystem
>> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> ext3_delete_inode:
>> >> Out of memory
>> >>
>> >> And three days later the same:
>> >>
>> >> Dec  8 08:24:29 kernel: do_get_write_access: OOM for frozen_buffer
>> >> Dec  8 08:24:29 kernel: ext3_reserve_inode_write: aborting
>> transaction:
>> >> Out of memory in __ext3_journal_get_write_access
>> >> Dec  8 08:24:29 kernel: EXT3-fs error (device md1) in
>> >> ext3_reserve_inode_write: Out of memory
>> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> ext3_dirty_inode:
>> >> Out of memory
>> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> ext3_new_blocks:
>> >> Readonly filesystem
>> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> >> ext3_reserve_inode_write: Readonly filesystem
>> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> ext3_dirty_inode:
>> >> Out of memory
>> >> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> >> ext3_prepare_write:
>> >> Out of memory
>> >>
>> >> Now the funny thing is, with kernel 2.6.18.3 I did not had these
>> errors.
>> >> Could it be my memory that is just going nuts, or something else? I
>> have
>> >> seen some other topics about the EXT3 corruption problems. Maybe this
>> is
>> >> also the same thing?
>> >   Probably some error on the kernel's side. Maybe somebody (e.g. my
>> new
>> > code in jbd commit) forgets to release some buffers? What does your
>> > /proc/slabinfo look like? Thanks for report.
>
> 								Honza
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

