Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTGMXeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270450AbTGMXeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:34:36 -0400
Received: from zok.sgi.com ([204.94.215.101]:51601 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S270448AbTGMXeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:34:23 -0400
Date: Mon, 14 Jul 2003 09:48:37 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75 and xfs quotas
Message-ID: <20030713234837.GA891@frodo>
References: <200307131025.56438.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307131025.56438.ivg2@cornell.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 10:25:56AM -0400, Ivan Gyurdiev wrote:
> Perhaps I'm missing something silly, but with both generic quota v2 and xfs 
> quota enabled (and xfs) all compiled into the kernel:
> ===========================================================
> [root@cobra linux]# mount -o remount /dev/hda8
> 
> strace:
> mount("/dev/hda8", "/", "xfs", MS_REMOUNT|0xc0ed0000, 0x805be00) = 0
> ===========================================================
> [root@cobra linux]# mount -o remount,quota /dev/hda8
> mount: / not mounted already, or bad option        

There will be a more meaningful message in your system log.

> strace:                                                                                                                          
> mount("/dev/hda8", "/", "xfs", MS_REMOUNT|0xc0ed0000, 0x805be38) = -1 EINVAL 
> (Invalid argument)
> ===========================================================

This (remount,quota) is not implemented by the XFS kernel code,
and hasn't ever been, although there was a time when it wouldn't
have reported an error when attempting this.  Currently, quota
can only be enabled during the initial mount.  For your root fs
this means using "rootflags=quota" during startup.

cheers.

-- 
Nathan
