Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbUKXJeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbUKXJeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUKXJea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:34:30 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:22438 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262563AbUKXJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:34:11 -0500
Subject: Re: Delay in unmounting a USB pen drive
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Raj <inguva@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <b2fa632f041124012543876b61@mail.gmail.com>
References: <b2fa632f041124012543876b61@mail.gmail.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Wed, 24 Nov 2004 09:34:06 +0000
Message-Id: <1101288846.15596.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 14:55 +0530, Raj wrote:
> SuSE kernel 2.6.5:
> 
> My USB pen drive has a vfat FS. When i transfer some files & try to
> unmount the drive ( umount /mnt ) , the command appears hung. CTRL+C also
> does not work. Only later did i realise that it was actually taking a
> longer time ( 10 - 15 sec )
> to unmount.
> 
> My questions are:
> - Why is it taking a long time to unmount ?
> - Is it safe to remove the pen drive from it's slot when the umount is still in
>   progress ?? ( I tried this the first time & maybe lucky me, the
> files copied were fine )

You are mounting with async flag (or this is the default) which means
that all the unwritten data is synced when you do umount.  You can
verify this by typing "sync" waiting for that to complete and then the
umount should be immediate.

You can change this by using the "sync" option to mount which will cause
data to be written synchronously and the umount will be instantaneous.
Note that this will cause device write to be _much_ slower!

One thing is certain, do NOT unplug before the umount completes or you
will corrupt your fs on the stick for sure.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

