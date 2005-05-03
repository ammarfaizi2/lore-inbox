Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVECTye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVECTye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVECTye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:54:34 -0400
Received: from mail.tmr.com ([64.65.253.246]:55822 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261651AbVECTy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:54:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Date: Tue, 03 May 2005 13:30:34 -0400
Organization: TMR Associates, Inc
Message-ID: <d58k4o$1ha$1@gatekeeper.tmr.com>
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1115149272 1578 192.168.12.100 (3 May 2005 19:41:12 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
In-Reply-To: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> This (lightly tested) patch against 2.6.12-rc* adds some
> infrastructure and basic functionality for unprivileged mount/umount
> system calls.
> 
> Details:
> 
>   - new mnt_owner field in struct vfsmount
>   - if mnt_owner is NULL, it's a privileged mount
>   - global limit on unprivileged mounts in  /proc/sys/fs/mount-max
>   - per user limit of mounts in rlimit
>   - allow umount for the owner (except force flag)
>   - allow unprivileged bind mount to files/directories writable by owner
>   - add nosuid,nodev flags to unprivileged mounts
> 
> Next step would be to add some policy for new mounts.  I'm thinking of
> either something static: e.g. FS_SAFE flag for "safe" filesystems, or
> a more configurable approach through sysfs or something.
> 
> Comments?

Are these public or private mounts? In other words, is the mount visible 
only to the mounting process and children, or is it visible to (and can 
effect) other processes. Clearly true private mounts open uses with 
chroot jails and virtualization.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
