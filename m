Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWHSSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWHSSnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWHSSnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 14:43:11 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:55165 "EHLO
	BAYC1-PASMTP06.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751129AbWHSSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 14:43:09 -0400
Message-ID: <BAYC1-PASMTP06A1449AFED44B54CF60F4B9430@CEZ.ICE>
X-Originating-IP: [69.156.47.89]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: cmm@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       John McCutchan <ttb@tentacle.dhs.org>, Robert Love <rml@novell.com>
In-Reply-To: <6bffcb0e0608100815q4b0b35b6mc2799181abd5786e@mail.gmail.com>
References: <1155172597.3161.72.camel@localhost.localdomain>
	 <6bffcb0e0608100702m1ad3925bw3e5f0e4804210fc9@mail.gmail.com>
	 <6bffcb0e0608100815q4b0b35b6mc2799181abd5786e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Aug 2006 14:42:50 -0400
Message-Id: <1156012970.9346.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-OriginalArrivalTime: 19 Aug 2006 18:45:45.0203 (UTC) FILETIME=[ADFFCC30:01C6C3BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-08 at 17:15 +0200, Michal Piotrowski wrote:
> On 10/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Hi,
> >
> > On 10/08/06, Mingming Cao <cmm@us.ibm.com> wrote:
> > > This series of patch forkes a new filesystem, ext4, from the current
> > > ext3 filesystem, as the code base to work on, for the big features such
> > > as extents and larger fs(48 bit blk number) support, per our discussion
> > > on lkml a few weeks ago.
> >
> > It appears after a few minutes of running
> >
> > #! /bin/bash
> > while true
> > do
> > sudo mount -o loop -t ext3dev /home/fs-farm/ext4.img /mnt/fs-farm/ext4/
> > sudo umount /mnt/fs-farm/ext4/
> > done
> >
> > BUG: warning at /usr/src/linux-work2/fs/inotify.c:171/set_dentry_child_flags()
> >  [<c0104006>] show_trace_log_lvl+0x58/0x152
> >  [<c01046ad>] show_trace+0xd/0x10
> >  [<c0104775>] dump_stack+0x19/0x1b
> >  [<c018aa7f>] set_dentry_child_flags+0x5a/0x119
> >  [<c018ab94>] remove_watch_no_event+0x56/0x64
> >  [<c018ac62>] inotify_remove_watch_locked+0x12/0x34
> >  [<c018af1b>] inotify_rm_wd+0x75/0x93
> >  [<c018b468>] sys_inotify_rm_watch+0x40/0x58
> >  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> > DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> > Leftover inexact backtrace:
> >  [<c01046ad>] show_trace+0xd/0x10
> >  [<c0104775>] dump_stack+0x19/0x1b
> >  [<c018aa7f>] set_dentry_child_flags+0x5a/0x119
> >  [<c018ab94>] remove_watch_no_event+0x56/0x64
> >  [<c018ac62>] inotify_remove_watch_locked+0x12/0x34
> >  [<c018af1b>] inotify_rm_wd+0x75/0x93
> >  [<c018b468>] sys_inotify_rm_watch+0x40/0x58
> >  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> > kjournald2 starting.  Commit interval 5 seconds
> 
> Definitely it's an inotify bug. I have checked this with other file systems.

I just ran your loop of mounting/unmounting a fs for over an hour and I
can't reproduce this.

-- 
John McCutchan <john@johnmccutchan.com>
