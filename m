Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUCOEPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 23:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUCOEPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 23:15:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:36829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262236AbUCOEPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 23:15:02 -0500
Date: Sun, 14 Mar 2004 20:14:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Message-Id: <20040314201457.23fdb96e.akpm@osdl.org>
In-Reply-To: <20040315035506.GB30948@MAIL.13thfloor.at>
References: <20040315035506.GB30948@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
>  ; this patch adds some functionality to the --bind
>  ; type of vfs mounts.

This won't apply any more.  We very recently changed a large number of
filesystems to not call update_atime() from within their readdir functions.
That operation was hoisted up to vfs_readdir().

Also, rather than adding MNT_IS_RDONLY() and having to remember to check
both the inode and the mount all over the kernel it would be better to
change IS_RDONLY() to take two arguments - the inode and the vfsmnt.  That
way we won't miss places, and unconverted code simpy won't compile, thus
drawing attention to itself.  I don't know if this is feasible, but please
consider it.
