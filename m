Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUJIWES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUJIWES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUJIWES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:04:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33188 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267454AbUJIWEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:04:14 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ext-rt-dev@mvista.com
In-Reply-To: <yw1xis9ja82z.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
	 <1097356829.1363.7.camel@krustophenia.net>  <yw1xis9ja82z.fsf@mru.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1097358925.1363.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 17:55:25 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 17:35, Måns Rullgård wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > On Sat, 2004-10-09 at 09:15, Måns Rullgård wrote:
> >> I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
> >> Now it seems to be running quite well.  I am, however, getting
> >> occasional "bad: scheduling while atomic!" messages, all alike:
> >> 
> >
> > I am getting the same message.   Also, leaving all the default debug
> > options on, I got this debug output, but it did not coincide with the
> > "bad" messages.
> >
> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> 
> Well, those don't give me any clues.
> 
> I had the system running that kernel for a bit over an hour and got
> five of the "bad" messages, approximately evenly spaced in a
> two-minute interval about 20 minutes after boot.
> 

I am getting these too:

bad: scheduling while atomic!
 [<c0279c5a>] schedule+0x62a/0x630
 [<c013b137>] kmutex_unlock+0x37/0x50
 [<c013ab0d>] __p_mutex_down+0x1ed/0x360
 [<c013b1e0>] kmutex_is_locked+0x20/0x40
 [<c01cba47>] journal_dirty_data+0x77/0x230
 [<c01bf2e2>] ext3_journal_dirty_data+0x12/0x40
 [<c01bf150>] walk_page_buffers+0x60/0x70
 [<c01bf7c7>] ext3_ordered_writepage+0xf7/0x160
 [<c01bf6b0>] journal_dirty_data_fn+0x0/0x20
 [<c018067d>] mpage_writepages+0x29d/0x3e0
 [<c01bf6d0>] ext3_ordered_writepage+0x0/0x160
 [<c0141c09>] do_writepages+0x39/0x50
 [<c017ec5f>] __sync_single_inode+0x5f/0x220
 [<c017f0b7>] sync_sb_inodes+0x1c7/0x2e0
 [<c017f2c7>] writeback_inodes+0xf7/0x110
 [<c0141a03>] wb_kupdate+0x93/0x100
 [<c0142ccf>] __pdflush+0x2af/0x5a0
 [<c0142fc0>] pdflush+0x0/0x30
 [<c0142fde>] pdflush+0x1e/0x30
 [<c0141970>] wb_kupdate+0x0/0x100
 [<c0134af3>] kthread+0xa3/0xb0
 [<c0134a50>] kthread+0x0/0xb0
 [<c0103fe5>] kernel_thread_helper+0x5/0x10

Lee

