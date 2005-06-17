Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVFQEqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVFQEqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 00:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVFQEqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 00:46:23 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:53201 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261916AbVFQEqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 00:46:21 -0400
X-ORBL: [63.202.173.158]
Date: Thu, 16 Jun 2005 21:46:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
Message-ID: <853151.7c35340389ec1195e088dfe43d7c62ea.ANY@taniwha.stupidest.org>
References: <42B1DBF1.4020904@nortel.com> <20050616135708.4876c379.akpm@osdl.org> <42B20317.6000204@nortel.com> <20050616162933.25dee57b.akpm@osdl.org> <42B22CD3.9080600@nortel.com> <20050616185754.3646511e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616185754.3646511e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 06:57:54PM -0700, Andrew Morton wrote:

> hm, what a lot of filesystems.
>
> bix:/usr/src/linux-2.6.12-rc6> grep -rl simple_dir_operations .
> ./drivers/usb/gadget/inode.c
> ./drivers/usb/core/inode.c
> ./drivers/isdn/capi/capifs.c
> ./drivers/oprofile/oprofilefs.c
> ./drivers/misc/ibmasm/ibmasmfs.c
> ./fs/libfs.c
> ./fs/debugfs/inode.c
> ./fs/autofs/inode.c
> ./fs/devpts/inode.c
> ./fs/hugetlbfs/inode.c
> ./fs/ramfs/inode.c
> ./include/linux/fs.h
> ./net/sunrpc/rpc_pipe.c
> ./kernel/cpuset.c
> ./security/selinux/selinuxfs.c
> ./ipc/mqueue.c
> ./mm/shmem.c
>
> I can't think of any reason why any of these would want fsync(dir_fd) to
> return -EINVAL.

Logically I think we can only expect 'real' filesystems with block
devices or similiar behind them to do something with fsync and
everyone else to be more or less undefined.

Undefined creates problems I guess so I guess simple_dir_operations
could return 0 (it sorta does make sense, if you have no backing store
you are always in-sync?).

