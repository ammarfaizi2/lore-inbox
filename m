Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVACAdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVACAdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVACAdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:33:08 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:27825 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261361AbVACAdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:33:01 -0500
Date: Mon, 3 Jan 2005 01:37:23 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Bodo Eggert <7eggert@gmx.de>, Andy Lutomirski <luto@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
In-Reply-To: <20050102202712.GC4183@stusta.de>
Message-ID: <Pine.LNX.4.58.0501030019420.3770@be1.lrz>
References: <fa.iji5lco.m6nrs@ifi.uio.no> <fa.fv0gsro.143iuho@ifi.uio.no>
 <E1Cl509-0000TI-00@be1.7eggert.dyndns.org> <20050102202712.GC4183@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Adrian Bunk wrote:
> On Sun, Jan 02, 2005 at 01:38:29PM +0100, Bodo Eggert wrote:

> > I have an additional feature request: The umount -l will currently not work
> > for unmounting the cwd of something like the midnight commander without
> > closing it. On the other hand, rmdiring the cwd of running application
> > works just fine.
> 
> A rm does not actually remove things that are still accessed.

ACK, but rmdir will leave the applications in a directory with no way in 
or out. This directory can as well be on the moon, so there is no need to 
keep the fs busy.

> > Maybe it's possible to extend the semantics of umount -l to change all
> > cwds under that mountpoint to be deleted directories which will no
> > longer cause the mountpoint to be busy (e.g. by redirecting them to a
> > special inode on initramfs). Most applications can cope with that (if
> > not, they're buggy), and it will do 90% of the usural cases while still
> > avoiding data loss.
> >...
> 
> If the appication of a user was writing some important output to a file 
> on the NFS mount you want to umount there will be data loss...

If the file is open, the modified version will wait for the file to be
closed. If the nfs daemon has closed the file handle, you can unmount with
or without the modification, and with always the same data loss.

> If you _really_ want to umount something still accessed by applications 
> simply kill all applications with "fuser -k".

*This* will give you guaranteed data loss on more than the mounted fs.
Murphy will make some long-running jobs depend on the screen session that 
was originally started from the mounted dir. Off cause screen doesn't 
chdir to "/" after starting the shell.
