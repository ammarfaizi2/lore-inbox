Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWARXLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWARXLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWARXLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:11:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161041AbWARXLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:11:49 -0500
Date: Wed, 18 Jan 2006 15:10:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <jblunck@suse.de>
Cc: dev@sw.ru, olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in
 generic_shutdown_super
Message-Id: <20060118151054.7c781c45.akpm@osdl.org>
In-Reply-To: <20060118224953.GA31364@hasse.suse.de>
References: <20060116223431.GA24841@suse.de>
	<43CC2AF8.4050802@sw.ru>
	<20060118224953.GA31364@hasse.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <jblunck@suse.de> wrote:
>
> On Tue, Jan 17, Kirill Korotaev wrote:
> 
> > Olaf, can you please check if my patch for busy inodes from -mm tree 
> > helps you?
> > Patch name is fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
> 
> This patch is just wrong. It is hiding bugs in file systems. The problem is
> that somewhere the reference counting on the vfsmount objects is wrong. The
> file system is unmounted before the last dentry is dereferenced. Either you
> didn't hold a reference to the proper vfsmount objects at all or you
> dereference it too early. See Al Viros patch series (search for "namei fixes")
> on how to fix this issues.
> 

The only reason I've been carrying that patch is as a reminder that there's
a bug that we need to fix.  It'd be good news if that bug had been fixed by
other means.

Kirill, do you know whether the bug is still present in 2.6.16-rc1?
