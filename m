Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWC0DJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWC0DJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 22:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWC0DJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 22:09:40 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:5531 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751168AbWC0DJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 22:09:40 -0500
Date: Sun, 26 Mar 2006 19:06:22 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] CONFIGFS_FS must depend on SYSFS
Message-ID: <20060327030622.GV7844@ca-server1.us.oracle.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20060326122552.GM4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326122552.GM4053@stusta.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 02:25:52PM +0200, Adrian Bunk wrote:
> This patch fixes the following compile error with CONFIG_SYSFS=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> fs/built-in.o: In function `configfs_init':mount.c:(.init.text+0x3d5d): undefined reference to `kernel_subsys'
> make: *** [.tmp_vmlinux1] Error 1

	Hmm.  We only rely on SYSFS because of the policy decree of
default mounting at /sys/kernel/config (just like GregKH was asked to
put debugfs at /sys/kernel/debug).  While we create the mount point, we
don't rely on it.  You can mount configfs anywhere you like.
	So, what do you think of making that part of the code check for
CONFIG_SYSFS?  Then the module can be built without SYSFS instead of
depending on it.  I'm open to either idea.  Certainly, we don't leave
the compile error.

Joel

-- 

Life's Little Instruction Book #313

	"Never underestimate the power of love."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
