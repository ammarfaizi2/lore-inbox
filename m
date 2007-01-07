Return-Path: <linux-kernel-owner+w=401wt.eu-S965245AbXAGXOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbXAGXOQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 18:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbXAGXOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 18:14:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53604 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965245AbXAGXOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 18:14:16 -0500
Date: Mon, 8 Jan 2007 10:14:02 +1100
From: David Chinner <dgc@sgi.com>
To: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>
Cc: David Chinner <dgc@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
Message-ID: <20070107231402.GU44411608@melbourne.sgi.com>
References: <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs> <20061218223637.GP44411608@melbourne.sgi.com> <001a01c722fd$df5ca710$0400a8c0@dcccs> <20061219025229.GT33919298@melbourne.sgi.com> <20061219044700.GW33919298@melbourne.sgi.com> <041601c729b6$f81e4af0$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <041601c729b6$f81e4af0$0400a8c0@dcccs>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 01:58:06PM +0100, Haar János wrote:
> Hello,
> 
> ----- Original Message ----- 
> From: "David Chinner" <dgc@sgi.com>
> To: "David Chinner" <dgc@sgi.com>
> Cc: "Haar János" <djani22@netcenter.hu>; <linux-xfs@oss.sgi.com>;
> <linux-kernel@vger.kernel.org>
> Sent: Tuesday, December 19, 2006 5:47 AM
> Subject: Re: xfslogd-spinlock bug?
> 
> 
> > On Tue, Dec 19, 2006 at 01:52:29PM +1100, David Chinner wrote:
> >
> > The filesystem was being shutdown so xfs_inode_item_destroy() just
> > frees the inode log item without removing it from the AIL. I'll fix that,
> > and see if i have any luck....
> >
> > So I'd still try that patch i sent in the previous email...
> 
> I still using the patch, but didnt shows any messages at this point.
> 
> I'v got 3 crash/reboot, but 2 causes nbd disconneted, and this one:
> 
> Dec 27 13:41:29 dy-base BUG: warning at
> kernel/mutex.c:220/__mutex_unlock_common_slowpath()
> Dec 27 13:41:29 dy-base Unable to handle kernel paging request at
> 0000000066604480 RIP:
> Dec 27 13:41:29 dy-base  [<ffffffff80222c64>] resched_task+0x12/0x64
> Dec 27 13:41:29 dy-base PGD 115246067 PUD 0
> Dec 27 13:41:29 dy-base Oops: 0000 [1] SMP
> Dec 27 13:41:29 dy-base CPU 1
> Dec 27 13:41:29 dy-base Modules linked in: nbd rd netconsole e1000 video
> Dec 27 13:41:29 dy-base Pid: 4069, comm: httpd Not tainted 2.6.19 #3
> Dec 27 13:41:29 dy-base RIP: 0010:[<ffffffff80222c64>]  [<ffffffff80222c64>]
> resched_task+0x12/0x64
> Dec 27 13:41:29 dy-base RSP: 0018:ffff810105c01b78  EFLAGS: 00010083
> Dec 27 13:41:29 dy-base RAX: ffffffff807d5800 RBX: 00001749fd97c214 RCX:

Different corruption in RBX here. Looks like semi-random garbage there.
I wonder - what's the mac and ip address(es) of your machine and nbd
servers?

(i.e. I suspect this is a nbd problem, not an XFS problem)

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
