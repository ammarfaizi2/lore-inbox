Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUE2UsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUE2UsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUE2UsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:48:13 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:63982 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264236AbUE2UsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:48:07 -0400
Date: Sat, 29 May 2004 16:42:54 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Steve Lord <lord@xfs.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       XFS List <linux-xfs@oss.sgi.com>
Subject: Re: xfs partition refuses to mount
In-Reply-To: <40B8EC02.3050506@xfs.org>
Message-ID: <Pine.GSO.4.33.0405291630110.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004, Steve Lord wrote:
>Yes, xfs_repair will not replay a log, and if it finds dirty metadata in
>the log it wants you to replay it via mount. Having xfs_repair able to
>replay the log would be handy, but if mount cannot replay it, then
>repair will not either.

Except xfs_repair can be a lot smarter in the process.  I would never
suggest putting 3MB worth of log recovery code in the kernel when it's
likely to very be used.  Such "fogiving" log recovery belongs in userland.

>The whole reason for -L was customers who automatically ran xfs_repair
>after a crash, and hence threw away anything which was in the log. So
>it is more of a stop and think what you are doing option.

"Don't do that." *grin*

>> There should be a way to instruct the kernel's rootfs mount to not look
>> at the log.  I don't know if one can pass any generic mount options at
>> boot. ("ro"/"rw" and rootfs type, but I don't know of any others.)  This
>> would be handy for more than just xfs, btw.
>
>You can mount norecovery,ro - but no guarantees that it will stay up
>long. See Documentation/filesystems/xfs.txt for a list of xfs mount
>options.

I know I can tell the userland mount (/sbin/mount) to not replay the log.
But I'm looking for a way to tell the kernel, at boot, to not replay the
log.  (digs through kernel) Ahh... 'rootflags=...' is what I'm looking for.

--Ricky


