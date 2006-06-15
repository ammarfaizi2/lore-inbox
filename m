Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWFOIqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWFOIqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 04:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWFOIqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 04:46:14 -0400
Received: from gw.openss7.com ([142.179.199.224]:32456 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751337AbWFOIqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 04:46:13 -0400
Date: Thu, 15 Jun 2006 02:46:06 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060615024606.B5168@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20060613143230.A867599@wobbly.melbourne.sgi.com> <448EC51B.6040404@argo.co.il> <20060614084155.C888012@wobbly.melbourne.sgi.com> <17551.58643.704359.815153@gargle.gargle.HOWL> <20060615075018.B884384@wobbly.melbourne.sgi.com> <20060615054931.GC7318@thunk.org> <20060615170136.D898607@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060615170136.D898607@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Thu, Jun 15, 2006 at 05:01:36PM +1000
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan,

On Thu, 15 Jun 2006, Nathan Scott wrote:
> 
> There is no IRIX/Linux compatibility layer, you're misunderstanding
> the code (which is understandable, its erm a bit crufty in places).

You gotta be kidding.  It does everything in terms of an SVR 4 VFS
vnode and then converts that to Linux VFS on dentries/inodes.  It was
obviously built by stuffing the Linux VFS under SVR 4 VFS code and
even documents the code as such.  Things like:

| /*
|  * XFS arguments structure, constructed from the arguments we
|  * are passed via the mount system call.
|  *
|  * NOTE: The mount system call is handled differently between
|  * Linux and IRIX.  In IRIX we worked work with a binary data
|  * structure coming in across the syscall interface from user
|  * space (the mount userspace knows about each filesystem type
|  * and the set of valid options for it, and converts the users
|  * argument string into a binary structure _before_ making the
|  * system call), and the ABI issues that this implies.
|  *
|  * In Linux, we are passed a comma separated set of options;
|  * ie. a NULL terminated string of characters.  Userspace mount
|  * code does not have any knowledge of mount options expected by
|  * each filesystem type and so each filesystem parses its mount
|  * options in kernel space.
|  *
|  * For the Linux port, we kept this structure pretty much intact
|  * and use it internally (because the existing code groks it).
|  */
| struct xfs_mount_args {
| 	int	flags;		/* flags -> see XFSMNT_... macros below */
| 	int	flags2;		/* flags -> see XFSMNT2_... macros below */
| 	int	logbufs;	/* Number of log buffers, -1 to default */
| 	int	logbufsize;	/* Size of log buffers, -1 to default */
| 	char	fsname[MAXNAMELEN+1];	/* data device name */
| 	char	rtname[MAXNAMELEN+1];	/* realtime device filename */
| 	char	logname[MAXNAMELEN+1];	/* journal device filename */
| 	char	mtpt[MAXNAMELEN+1];	/* filesystem mount point */
| 	int	sunit;		/* stripe unit (BBs) */
| 	int	swidth;		/* stripe width (BBs), multiple of sunit */
| 	uchar_t iosizelog;	/* log2 of the preferred I/O size */
| 	int	ihashsize;	/* inode hash table size (buckets) */
| };

No... No compatibility layer there.

