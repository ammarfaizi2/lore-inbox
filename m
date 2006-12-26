Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbWLZKZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWLZKZu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 05:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWLZKZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 05:25:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54802 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbWLZKZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 05:25:49 -0500
Date: Tue, 26 Dec 2006 02:25:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: florin@iucha.net (Florin Iucha)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Linux 2.6.20-rc2
Message-Id: <20061226022538.13ea8b3f.akpm@osdl.org>
In-Reply-To: <20061225225616.GA22307@iucha.net>
References: <20061225224047.GB6087@iucha.net>
	<20061225225616.GA22307@iucha.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2006 16:56:16 -0600
florin@iucha.net (Florin Iucha) wrote:

> > The dmesg from the client machine is attached.
> 
> Now, really.
> 
> BTW, I am using NFSv4 exported async from the server and mounted
> without any extra options on the client.
> 
> florin
> 
> -- 
> Bruce Schneier expects the Spanish Inquisition.
>       http://geekz.co.uk/schneierfacts/fact/163
> 
> 
> [the_oops  text/plain (9.9KB)]
> [ 2844.871895] BUG: scheduling while atomic: cp/0x20000000/2965
> [ 2844.871900] 
> [ 2844.871901] Call Trace:
> [ 2844.871910]  [<ffffffff8015b97d>] __sched_text_start+0x5d/0x7a6
> [ 2844.871914]  [<ffffffff8012f6b0>] submit_bio+0x84/0x8b
> [ 2844.871918]  [<ffffffff801f8ea6>] ext3_get_block+0x0/0xe4
> [ 2844.871922]  [<ffffffff80112933>] __pagevec_lru_add+0xb6/0xc6
> [ 2844.871927]  [<ffffffff801c02f0>] mpage_bio_submit+0x22/0x26
> [ 2844.871931]  [<ffffffff8012cb30>] unix_poll+0x0/0xa4
> [ 2844.871936]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
> [ 2844.871940]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
> [ 2844.871943]  [<ffffffff8015dd92>] __reacquire_kernel_lock+0x26/0x44
> [ 2844.871948]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
> [ 2844.871953]  [<ffffffff80116664>] unlock_page+0x9/0x26
> [ 2844.871957]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
> [ 2844.871961]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
> [ 2844.871965]  [<ffffffff8019e8b6>] generic_writepages+0x113/0x2d8
> [ 2844.871970]  [<ffffffff8022771c>] nfs_writepage+0x0/0x22
> [ 2844.871976]  [<ffffffff802280ff>] nfs_writepages+0x45/0x13c
> [ 2844.871980]  [<ffffffff801536e6>] do_writepages+0x20/0x2d
> [ 2844.871984]  [<ffffffff801487be>] __filemap_fdatawrite_range+0x51/0x5b
> [ 2844.871989]  [<ffffffff8019ca9b>] filemap_write_and_wait+0x17/0x31
> [ 2844.871993]  [<ffffffff80220948>] nfs_setattr+0x98/0x108
> [ 2844.871996]  [<ffffffff80129c6e>] mntput_no_expire+0x19/0x7b
> [ 2844.872000]  [<ffffffff8010dab9>] link_path_walk+0xc5/0xd7
> [ 2844.872005]  [<ffffffff8010d340>] current_fs_time+0x3b/0x40
> [ 2844.872009]  [<ffffffff80129b48>] notify_change+0x122/0x22f
> [ 2844.872014]  [<ffffffff801bb806>] do_utimes+0x106/0x129
> [ 2844.872019]  [<ffffffff8010ac5b>] vfs_read+0xaa/0x152
> [ 2844.872023]  [<ffffffff801bb865>] sys_futimesat+0x3c/0x4b
> [ 2844.872027]  [<ffffffff8015671e>] system_call+0x7e/0x83
> [ 2844.872030] 

This is the second report we've had where bit 29 of ->preempt_count is
getting set.  I don't think there's any legitimate way in which that bit
can get set.  (Ingo?)

I'd suggested that the first report (which was in i386 iirc) was due to
memory corruption (hardware or software).  And this might also be a
hardware error, but that's looking pretty unlikely now.

If this is real, it's going to be hard to find, unless someone finds a
way to make it happen with some repeatability.
