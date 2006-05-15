Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWEOWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWEOWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWEOWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:18:55 -0400
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:25755
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP id S964998AbWEOWSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:18:54 -0400
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: Linux porting issue/question...
Date: Mon, 15 May 2006 15:18:53 -0700
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151518.53533.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of porting the linux kernel to a totally new h/w, and have
gotten most of the stuff to work.

However, I've run into a porting issue, and don't know where else to turn.
There is no gdb, no ICE, not much of anything available at the moment
on this h/w...

Attempting to run a standard 'ls' on a file or device node works fine, even
'ls -al' dumps good values.

However, running 'ls {somedir}' on a directory, any directory, always
returns the error code for "EFAULT" (Bad address), at the user level.

I've been able to trace the code execution into the 'vfs_stat()' kernel call,
but it gets a bit tricky trying to trace the __user_path_walk() function, and
there are some indirect function calls as well, dealing with pulling the inode
information from the fs, etc...BTW, the parameters passed into vfs_stat() do appear
correct.

The one thing that I did fix earlier was the 'struct stat64' structure that the
kernel was using from its 'asm/stat.h' file was grotesquely mismatched with
the 'struct stat64' structure in the glibc-2.3.6's bits/stat.h file, and once I fixed that
mismatch, the major/minor numbers of an 'ls -al /dev/{somedev}' started showing
up correctly.  I had hoped that this would have fixed the EFAULT on 'ls {somedir}
as well, but it did not make any difference.  I've also verified that the 'struct stat'
in the kernel's asm/stat.h is also synonymous with its counterpart in glibc.

Could anyone point me in a direction that might help debug this somewhat difficult
issue?

Thanks,
John

