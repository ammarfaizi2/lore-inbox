Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWHTSFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWHTSFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWHTSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:05:13 -0400
Received: from bender.bawue.de ([193.7.176.20]:41112 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1751113AbWHTSFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:05:12 -0400
Date: Sun, 20 Aug 2006 20:05:05 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PROBLEM: FUSE unmount breaks serial terminal line
Message-ID: <20060820180505.GA18283@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

something in FUSE breaks serial devices.  I found this issue 
using gphotofs, don't know if any other FUSE impementation has similar
effects.  The problem is: from the moment the FUSE filesystem is unmounted,
a process that read()s on a serial device /dev/ttyS? gets an EOF
returncode.  

Here is the tail of the output from "strace -tt cat /dev/ttyS0" when the
FUSE fs was unmounted:

19:41:46.513143 open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
19:41:46.513373 fstat64(3, {st_mode=S_IFCHR|0660, st_rdev=makedev(4, 64), ...}) = 0
19:41:46.513552 read(3, "", 4096)       = 0
19:42:49.854367 close(3)                = 0
19:42:49.860663 close(1)                = 0
19:42:49.860793 exit_group(0)           = ?

Found this on x86 with kernels 2.6.16 and 2.6.17.

Any ideas?

-jo

-- 
-rw-r--r-- 1 jo users 62 2006-08-20 14:06 /home/jo/.signature
