Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbTGMVLy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270403AbTGMVLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:11:54 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:32727 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268346AbTGMVLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:11:52 -0400
Date: Sun, 13 Jul 2003 22:26:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Niklaus <niklaus@gamebox.net>
cc: ntfs@flatcap.org, linux-ntfs-dev@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: Re: NTFS RW enabled
In-Reply-To: <20030714014702.4725a50c.niklaus@gamebox.net>
Message-ID: <Pine.SOL.4.56.0307132220050.14367@orange.csi.cam.ac.uk>
References: <20030714014702.4725a50c.niklaus@gamebox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for your own safety writing is disabled in the OLD ntfs driver.  I
guarantee you that if you bypass this and enable write support, your
entire partition will be destroyed or damaged.  I strongly suggest you do
NOT enable write support!

If you don't care and just want to try anyway you need to mount readonly
 AND then you need to remount rw again.  This will enable writing:

mount -o ro ...
mount -o remount,rw ...

But really do NOT do this!  It WILL eat your data, especially if you
change the directory structure as you seem to want to do.

If you want to modify existing files without changes in file size then
download the new ntfs driver (2.1.4a) patch from
http://linux-ntfs.sf.net/downloads.html and use this.  It ONLY allows
modifying of existing files without changes in file size but at least it
allows it SAFELY.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

On Mon, 14 Jul 2003, Niklaus wrote:

> Hi,
> 	I have enabled NTFS RW in kernel and compiled it as  a module.Everything went fine.
> 	I then loaded the module and mounted my win2k drive which is /dev/hda12.
> 	This is the output of mount
> 	/dev/ide/host0/bus0/target0/lun0/part12 on /mnt/12 type ntfs (rw)
> 	As you can see /dev/hda12 or part12 is mounted rw.
> 	Even i tried this
> 	/dev/ide/host0/bus0/target0/lun0/part12 on /mnt/12 type ntfs (rw,uid=0,umask=022)
>
> 	When i cd to /mnt/12 and do
>
> 	Foo:/mnt/12# ls
> 	RECYCLER
> 	System Volume Information
> 	Foo:/mnt/12# mkdir check
> 	mkdir: cannot create directory `check': Operation not permitted
> 	Foo:/mnt/12# touch try
> 	touch: cannot touch `try': Permission denied
> 	Foo:/mnt/12# echo hi > foo
> 	bash: foo: Permission denied
> 	Foo:/mnt/12#
> 	Why aren't the commands working. I am sure i have enabled RW in kernel.I
>         did it twice.
> 	kernel version is 2.4.21.
>
> 	What should i do to create a directory or file in NTFS drive (/mnt/12).
> 	Do i need special tools or how do i do it ?
>
> Thank you
> Nik
>

