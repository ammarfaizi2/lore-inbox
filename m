Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUE2UCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUE2UCD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUE2UCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:02:03 -0400
Received: from relay03.roc.ny.frontiernet.net ([66.133.131.36]:34722 "EHLO
	relay03.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S264401AbUE2UB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:01:28 -0400
Message-ID: <40B8EC02.3050506@xfs.org>
Date: Sat, 29 May 2004 15:01:06 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       XFS List <linux-xfs@oss.sgi.com>
Subject: Re: xfs partition refuses to mount
References: <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> On Sat, 29 May 2004, Steve Lord wrote:
> 
>>You have turned on XFS debug, which is really a developer option. It
>>looks like you have a corrupt journal though. A non debug kernel may
>>still refuse to mount it and you would need to run xfs_repair from
>>a rescue disk in that case.
> 
> 
> Unless xfs_repair has been changed recently, all it will be able to do it
> delete (zero) the journal.  If it detects metadata in the journal, it'll
> stop and tell you mount the filesystem to replay the journal.  Personally,
> I think that's sorta stupid... if I could mount the fs, I wouldn't be
> running xfs_repair. (I've had the journal become spooge on a sparc64
> box a few times.)

Yes, xfs_repair will not replay a log, and if it finds dirty metadata in
the log it wants you to replay it via mount. Having xfs_repair able to
replay the log would be handy, but if mount cannot replay it, then
repair will not either. xfs_repair -L bypasses this check and resets
the log. Following that it does a complete consistancy check and
fixup of metadata - it does a good job in most cases. Note that it
deletes lost+found, and if you had files in there, they would be
disconnected and get put back in lost+found again.

The whole reason for -L was customers who automatically ran xfs_repair
after a crash, and hence threw away anything which was in the log. So
it is more of a stop and think what you are doing option.

> 
> There should be a way to instruct the kernel's rootfs mount to not look
> at the log.  I don't know if one can pass any generic mount options at
> boot. ("ro"/"rw" and rootfs type, but I don't know of any others.)  This
> would be handy for more than just xfs, btw.
> 

You can mount norecovery,ro - but no guarantees that it will stay up
long. See Documentation/filesystems/xfs.txt for a list of xfs mount
options.

Steve
