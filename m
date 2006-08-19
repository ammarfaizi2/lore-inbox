Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWHSVRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWHSVRH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 17:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWHSVRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 17:17:07 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:33506 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422784AbWHSVRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 17:17:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/aaIlvVZCECCwRAPfr8HJt9/43m3phiNkpbaY8abLsCk/MEBDPaCatJzpcQOdnsLL9SDuV4dnIarvch3R/D3n210eVwM9bHWsF5Za4kjRkCzPnVsQhX7V/ZIxYKVUjObNS43MZx5f2E5hbwOUj1yEN41fIJGCNCKfyWYBcJMsU=
Message-ID: <6bffcb0e0608191417m6f60a3edl4a6094c916a58e66@mail.gmail.com>
Date: Sat, 19 Aug 2006 23:17:04 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: john@johnmccutchan.com
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
Cc: cmm@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       "John McCutchan" <ttb@tentacle.dhs.org>, "Robert Love" <rml@novell.com>
In-Reply-To: <BAYC1-PASMTP06A1449AFED44B54CF60F4B9430@CEZ.ICE>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155172597.3161.72.camel@localhost.localdomain>
	 <6bffcb0e0608100702m1ad3925bw3e5f0e4804210fc9@mail.gmail.com>
	 <6bffcb0e0608100815q4b0b35b6mc2799181abd5786e@mail.gmail.com>
	 <BAYC1-PASMTP06A1449AFED44B54CF60F4B9430@CEZ.ICE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/06, John McCutchan <john@johnmccutchan.com> wrote:
> On Thu, 2006-10-08 at 17:15 +0200, Michal Piotrowski wrote:
> > On 10/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > Hi,
> > >
> > > On 10/08/06, Mingming Cao <cmm@us.ibm.com> wrote:
> > > > This series of patch forkes a new filesystem, ext4, from the current
> > > > ext3 filesystem, as the code base to work on, for the big features such
> > > > as extents and larger fs(48 bit blk number) support, per our discussion
> > > > on lkml a few weeks ago.
> > >
> > > It appears after a few minutes of running
> > >
> > > #! /bin/bash
> > > while true
> > > do
> > > sudo mount -o loop -t ext3dev /home/fs-farm/ext4.img /mnt/fs-farm/ext4/
> > > sudo umount /mnt/fs-farm/ext4/
> > > done
> > >
> > > BUG: warning at /usr/src/linux-work2/fs/inotify.c:171/set_dentry_child_flags()
> > >  [<c0104006>] show_trace_log_lvl+0x58/0x152
> > >  [<c01046ad>] show_trace+0xd/0x10
> > >  [<c0104775>] dump_stack+0x19/0x1b
> > >  [<c018aa7f>] set_dentry_child_flags+0x5a/0x119
> > >  [<c018ab94>] remove_watch_no_event+0x56/0x64
> > >  [<c018ac62>] inotify_remove_watch_locked+0x12/0x34
> > >  [<c018af1b>] inotify_rm_wd+0x75/0x93
> > >  [<c018b468>] sys_inotify_rm_watch+0x40/0x58
> > >  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> > > DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> > > Leftover inexact backtrace:
> > >  [<c01046ad>] show_trace+0xd/0x10
> > >  [<c0104775>] dump_stack+0x19/0x1b
> > >  [<c018aa7f>] set_dentry_child_flags+0x5a/0x119
> > >  [<c018ab94>] remove_watch_no_event+0x56/0x64
> > >  [<c018ac62>] inotify_remove_watch_locked+0x12/0x34
> > >  [<c018af1b>] inotify_rm_wd+0x75/0x93
> > >  [<c018b468>] sys_inotify_rm_watch+0x40/0x58
> > >  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> > > kjournald2 starting.  Commit interval 5 seconds
> >
> > Definitely it's an inotify bug. I have checked this with other file systems.
>
> I just ran your loop of mounting/unmounting a fs for over an hour and I
> can't reproduce this.

I can reproduce this in a few minutes.

ls -sh /home/fs-farm/
razem 3,6G
513M ext2.img  513M ext4.img  513M reiser3.img  513M xfs.img
513M ext3.img  513M jfs.img   513M reiser4.img

#! /bin/bash

m_fs() {
    sudo mount -o loop -t ext2 /home/fs-farm/ext2.img /mnt/fs-farm/ext2/
    sudo mount -o loop -t ext3 /home/fs-farm/ext3.img /mnt/fs-farm/ext3/
    sudo mount -o loop -t ext3dev /home/fs-farm/ext4.img /mnt/fs-farm/ext4/
    sudo mount -o loop -t reiserfs /home/fs-farm/reiser3.img
/mnt/fs-farm/reiser3/
    sudo mount -o loop -t reiser4 /home/fs-farm/reiser4.img
/mnt/fs-farm/reiser4/
    sudo mount -o loop -t xfs /home/fs-farm/xfs.img /mnt/fs-farm/xfs/
    sudo mount -o loop -t jfs /home/fs-farm/jfs.img /mnt/fs-farm/jfs/
}

u_fs() {
    sudo umount /mnt/fs-farm/ext2/
    sudo umount /mnt/fs-farm/ext3/
    sudo umount /mnt/fs-farm/ext4/
    sudo umount /mnt/fs-farm/reiser3/
    sudo umount /mnt/fs-farm/reiser4/
    sudo umount /mnt/fs-farm/xfs/
    sudo umount /mnt/fs-farm/jfs/
}

while true
do
m_fs
u_fs
done

mount
[..]
/dev/sda3 on /home type ext3 (rw)

http://www.stardust.webpages.pl/files/o_bugs/mm-config

>
> --
> John McCutchan <john@johnmccutchan.com>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
