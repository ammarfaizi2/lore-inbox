Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVABU15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVABU15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVABU1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:27:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19472 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261321AbVABU1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:27:17 -0500
Date: Sun, 2 Jan 2005 21:27:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102202712.GC4183@stusta.de>
References: <fa.iji5lco.m6nrs@ifi.uio.no> <fa.fv0gsro.143iuho@ifi.uio.no> <E1Cl509-0000TI-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cl509-0000TI-00@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 01:38:29PM +0100, Bodo Eggert wrote:
> Andy Lutomirski wrote:
> 
> > I have this complaint too, and MNT_DETACH doesn't really do it.
> > Sometimes I want to "unmount cleanly, damnit, and I don't care if
> > applications that are currently accessing it lose data."  Windows can do
> > this, and it's _useful_.
> 
> I have an additional feature request: The umount -l will currently not work
> for unmounting the cwd of something like the midnight commander without
> closing it. On the other hand, rmdiring the cwd of running application
> works just fine.

A rm does not actually remove things that are still accessed.

As an example, do the following (1 and 2 are shells, cdimage is a full
CD image):

1> less cdimage
2> df .
2> rm cdimage
2> df . 
1> q (quit less)
2> df .

> Maybe it's possible to extend the semantics of umount -l to change all
> cwds under that mountpoint to be deleted directories which will no
> longer cause the mountpoint to be busy (e.g. by redirecting them to a
> special inode on initramfs). Most applications can cope with that (if
> not, they're buggy), and it will do 90% of the usural cases while still
> avoiding data loss.
>...

If the appication of a user was writing some important output to a file 
on the NFS mount you want to umount there will be data loss...

If you _really_ want to umount something still accessed by applications 
simply kill all applications with "fuser -k".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

