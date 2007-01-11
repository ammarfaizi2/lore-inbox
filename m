Return-Path: <linux-kernel-owner+w=401wt.eu-S1030471AbXAKNvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbXAKNvm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbXAKNvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:51:06 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:5566 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030469AbXAKNu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:50:29 -0500
X-AuditID: d80ac287-a08bebb000007fb9-ad-45a641d7f7b2 
Date: Thu, 11 Jan 2007 13:50:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Robert Schwebel <r.schwebel@pengutronix.de>
cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
       Bjoern Buerger <bbu@pengutronix.de>
Subject: Re: Mounting tmpfs with symbolic gid doesn't work
In-Reply-To: <20070111113812.GD29495@pengutronix.de>
Message-ID: <Pine.LNX.4.64.0701111342180.14808@blonde.wat.veritas.com>
References: <20070111113812.GD29495@pengutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jan 2007 13:50:27.0096 (UTC) FILETIME=[7314F980:01C73587]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Robert Schwebel wrote:
> 
> Mounting tmpfs with gid=<symbolic-group> doesn't work on recent kernels
> any more; the same with uid=<symbolic-username> works fine:
> 
> rsc@isonoe:~$ mkdir troet
> rsc@isonoe:~$ sudo mount -t tmpfs -ogid=rsc none troet/
> mount: wrong fs type, bad option, bad superblock on none,
>        missing codepage or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> rsc@isonoe:~/svn/ptxdist-trunk$ dmesg | tail -n 1 
> tmpfs: Bad value 'rsc' for mount option 'gid'
> rsc@isonoe:~$ sudo mount -t tmpfs -ogid=1006 none troet/
> rsc@isonoe:~$ mount | grep troet
> none on /home/rsc/troet type tmpfs (rw,gid=1006)
> rsc@isonoe:~$ ls -ld troet/
> drwxrwxrwt 2 root 1006 40 Jan 11 12:32 troet/
> rsc@isonoe:~$ sudo umount troet/
> rsc@isonoe:~$ sudo mount -t tmpfs -ouid=1006 none troet/
> rsc@isonoe:~$ sudo umount troet/
> rsc@isonoe:~$ sudo mount -t tmpfs -ouid=rsc none troet/
> rsc@isonoe:~$ ls -ld troet/
> drwxrwxrwt 2 rsc root 40 Jan 11 12:33 troet/
> rsc@isonoe:~$ sudo umount troet/
> 
> Tested with 2.6.19-rc6, the behaviour seems to have worked until at
> least 2.6.16. Does anyone have an idea?

Works fine for me here on 2.6.16 or 2.6.19 or 2.6.20-rc4
(though I tried with "mail" rather than "rsc" ;)

Whatever, I think it's not a kernel problem: tmpfs itself only handles
numeric gid, I believe it's the job of the userspace end of mount to
convert symbolic uid or gid to numeric uid or gid for the kernel mount.

Looking through what you've tried above, I'm guessing that "rsc" is
your symbolic uid, but you're expecting there to be a group of that
name - perhaps there is not?  perhaps since 2.6.16 you switched from
a distro which makes a group for each user to a distro which does not?

Hugh
