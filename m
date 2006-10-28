Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWJ1VWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWJ1VWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWJ1VWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:22:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964849AbWJ1VWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:22:40 -0400
Date: Sat, 28 Oct 2006 14:22:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS problem (r/o filesystem) with 2.6.19-rc3
Message-Id: <20061028142228.da7350c2.akpm@osdl.org>
In-Reply-To: <20061028184226.GA1225@deepthought.linux.bogus>
References: <20061028184226.GA1225@deepthought.linux.bogus>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 19:42:27 +0100
Ken Moffat <zarniwhoop@ntlworld.com> wrote:

> Hi,
> 
>  yesterday I moved this desktop box to -rc3 from 2.6.18.  I have a
> large amount of data on nfs mounts (r/w) and everything looks good.
> But, for my backups I have cron jobs to mount a different nfs
> filesystem and rsync to it.  That fails with 2.6.19-rc3, giving me
> messages like
> 
> about to mount /nfs
> Sat Oct 28 18:45:03 BST 2006 rsyncing
> rsync: failed to set times on "/nfs/bluesbreaker/boot/.": Read-only
> file system (30)
> rsync: mkstemp "/nfs/bluesbreaker/boot/.map.c2Cj91" failed:
> Read-only file system (30)
> rsync: mkstemp
> "/nfs/bluesbreaker/boot/.vmlinuz-2.6.19-rc3-sda8.pXKgH9" failed:
> Read-only file system (30)
> rsync: failed to set times on "/nfs/bluesbreaker/boot/.": Read-only
> file system (30)
> rsync error: some files could not be transferred (code 23) at
> main.c(791)
> rsync failed
> umounting /nfs
> 
>  If I mount it manually, it seems to be ok -
> root@bluesbreaker /home/ken #mount
> /dev/sda8 on / type auto (rw)
> [...]
> deepthought:/data/staging on /nfs type nfs (rw,hard,intr,tcp,addr=192.168.0.10)
> root@bluesbreaker /home/ken #
> 
>  But if I then try to touch a file I find the filesystem is r/o -
> root@bluesbreaker /home/ken #touch /nfs/bluesbreaker/boot/vmlinuz-2.6.18-sda8 
> touch: cannot touch `/nfs/bluesbreaker/boot/vmlinuz-2.6.18-sda8':
> Read-only file system
> 
>  This filesystem is a 'staging' area where whichever of my desktop
> machines are up can write.  From a different box using a 2.6.17.13
> kernel the filesystem is r/w.  The system log on the machine running
> rc3 only shows that rsync ended in error, there are no associated
> kernel messages. 
> 
>  Suggestions, please ?
> 

Is it this: http://lkml.org/lkml/2006/10/18/264 ?
