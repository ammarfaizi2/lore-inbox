Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTLOVAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTLOVAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:00:49 -0500
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:57771 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262198AbTLOVAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:00:47 -0500
From: Emilio Gargiulo <emiliogargiulo@supereva.it>
To: Eric Sandeen <sandeen@sgi.com>
Subject: Re: 2.4.24-pre1 hangs with XFS on LVM filesystem full
Date: Mon, 15 Dec 2003 22:00:08 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <Pine.LNX.4.44.0312132302520.766-100000@stout.americas.sgi.com>
In-Reply-To: <Pine.LNX.4.44.0312132302520.766-100000@stout.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312152200.08411.emiliogargiulo@supereva.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, a simple overfill of a XFS filesystem on LVM hangs the kernel.
It is easy to reproduce with dd if=/dev/zero of=file_on_dest_xfs_filesystem 
bs=1024k.
It was full reproducible with 2.4.24-pre1.
Is also reproduceable on 2.4.23 + XFS snapshot-2.4.23-2003-12-01_00:33_UTC 
patch.
It is reproduceable on LVM and on simple partition like /dev/hda10.
It is NOT reproduceable with other filesystems (reiserfs, ext3, jfs).
I compiled the kernel with gcc 3.2.3. (Slackware 9.1)

I am unable to reproduce the problem if I compile the kernel with gcc 3.3.1.
Also is not reproduceable on small XFS filesystem (if the filesystem is 
smaller than system RAM). It seems a VMM related problem....
When hang the num-lock key change the led status.
I will try to use KDB...

Thanks
Emilio Gargiulo


Alle 06:11, domenica 14 dicembre 2003, Eric Sandeen ha scritto:
> So you are seeing a hang when you (over)fill the filesystem, if
> I understand correctly?  If there is any chance that you could
> test it with XFS to a normal disk (no LVM) or with some other
> filesystem with LVM, that might help to narrow down the problem.
> Nightly XFS QA tests do check ENOSPC conditions, but perhaps
> there is bad interaction with LVM.
>
> You could also get a CVS kernel from oss.sgi.com, or apply
> the KDB patch you your kernel, and enter kdb when the system
> freezes.  Then you could look at backtraces of the relevant
> processes to get an idea of where things are stuck.
>
> -Eric
>
> On Sat, 13 Dec 2003, Emilio Gargiulo wrote:
> > Hi
> > There is a severe XFS problem with kernel 2.4.24-pre1. If you try to copy
> > a file in a XFS filesystem on LVM bigger than free spaces, the Linux Box
> > will hang. No messages, no warnings, it just freeze. It happens also if
> > the filesystem was not the root filesystem.
> > The problem is fully reproducible on 2 different computer, an old
> > K6/400MHz and a P4/2,4GHz.
> >
> > If i can do something for address the issue, please tell me.
> > Thanks
> > Emilio Gargiulo

