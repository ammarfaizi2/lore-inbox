Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUITCfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUITCfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUITCfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 22:35:11 -0400
Received: from holomorphy.com ([207.189.100.168]:26043 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265800AbUITCfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 22:35:02 -0400
Date: Sun, 19 Sep 2004 19:34:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040920023452.GR9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:40:20AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/
> - Added lots of Ingo's low-latency patches
> - Lockmeter doesn't compile.  Don't enable CONFIG_LOCKMETER.
> - Several architecture updates

top(1) shows no tasks on sparc64. Large negative inode numbers appear
to be showing up for /proc/stat and other /proc/ special files on
64-bit irrespective of endianness, and all processes appear to have the
same inode number once again irrespective of endianness. It's unclear
why top(1) enumerates tasks on x86-64 and does not do so on sparc64,
unless 2.6.9-rc2-mm1 shows some behavior procps-3.2.3 is sensitive to
that 3.2.1 is not, or some numbers are overflowing on 32-bit apps but
not 64-bit ones (top(1) is 64-bit on x86-64 but 32-bit on sparc64)
that userspace barfs on and not the kernel (no error returns from
syscalls are visible in strace). ls and cat appear to work where top(1)
does not.

acahalan cc:'d as he last touched fs/proc/.

$ stat /proc/stat
  File: `/proc/stat'
  Size: 0               Blocks: 0          IO Block: 1024   regular empty file
Device: 3h/3d   Inode: -268435443  Links: 1
Access: (0444/-r--r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2004-09-19 18:46:38.246034917 -0700
Modify: 2004-09-19 18:46:38.246034917 -0700
Change: 2004-09-19 18:46:38.246034917 -0700
$ stat /proc/[0-9]*|grep Inode|sort -u -k 4,4
Device: 3h/3d   Inode: 2           Links: 3

(the same on x86-64 and sparc64).


-- wli
