Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161332AbWHJPP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbWHJPP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbWHJPP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:15:56 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:6538 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751382AbWHJPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:15:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g394rnQVEk2CrE0dCWQYsIUaiCU646JrC+0i1ZwRpGHHgeuLksHUsYcGpVgH6rANlL2pKMGjRamxv5HpZQWe+q8brS/a1Q7unGFlkRNDrqhId+tMqaGSOtr5H5fNb3Temw02eVEBjWHgY1xYlH3zTZRUvlXJvRl3rIyduvQArkk=
Message-ID: <6bffcb0e0608100815q4b0b35b6mc2799181abd5786e@mail.gmail.com>
Date: Thu, 10 Aug 2006 17:15:55 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: cmm@us.ibm.com
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       "John McCutchan" <ttb@tentacle.dhs.org>, "Robert Love" <rml@novell.com>
In-Reply-To: <6bffcb0e0608100702m1ad3925bw3e5f0e4804210fc9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155172597.3161.72.camel@localhost.localdomain>
	 <6bffcb0e0608100702m1ad3925bw3e5f0e4804210fc9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 10/08/06, Mingming Cao <cmm@us.ibm.com> wrote:
> > This series of patch forkes a new filesystem, ext4, from the current
> > ext3 filesystem, as the code base to work on, for the big features such
> > as extents and larger fs(48 bit blk number) support, per our discussion
> > on lkml a few weeks ago.
>
> It appears after a few minutes of running
>
> #! /bin/bash
> while true
> do
> sudo mount -o loop -t ext3dev /home/fs-farm/ext4.img /mnt/fs-farm/ext4/
> sudo umount /mnt/fs-farm/ext4/
> done
>
> BUG: warning at /usr/src/linux-work2/fs/inotify.c:171/set_dentry_child_flags()
>  [<c0104006>] show_trace_log_lvl+0x58/0x152
>  [<c01046ad>] show_trace+0xd/0x10
>  [<c0104775>] dump_stack+0x19/0x1b
>  [<c018aa7f>] set_dentry_child_flags+0x5a/0x119
>  [<c018ab94>] remove_watch_no_event+0x56/0x64
>  [<c018ac62>] inotify_remove_watch_locked+0x12/0x34
>  [<c018af1b>] inotify_rm_wd+0x75/0x93
>  [<c018b468>] sys_inotify_rm_watch+0x40/0x58
>  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Leftover inexact backtrace:
>  [<c01046ad>] show_trace+0xd/0x10
>  [<c0104775>] dump_stack+0x19/0x1b
>  [<c018aa7f>] set_dentry_child_flags+0x5a/0x119
>  [<c018ab94>] remove_watch_no_event+0x56/0x64
>  [<c018ac62>] inotify_remove_watch_locked+0x12/0x34
>  [<c018af1b>] inotify_rm_wd+0x75/0x93
>  [<c018b468>] sys_inotify_rm_watch+0x40/0x58
>  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> kjournald2 starting.  Commit interval 5 seconds

Definitely it's an inotify bug. I have checked this with other file systems.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
