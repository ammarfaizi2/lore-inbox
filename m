Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423443AbWJZNAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423443AbWJZNAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423470AbWJZNAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:00:17 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:61545 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423443AbWJZNAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:00:15 -0400
Date: Thu, 26 Oct 2006 15:00:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 0/5] various user space access fixes
Message-ID: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing the get/put_user macros with some __must_check dummy functions
quite a few places where user space accesses aren't handled properly.
I fixed most of these (that come up with a warning on standard s390 build).

But for the ones below I haven't done anything:

include/asm/uaccess.h: In function `schedule_tail':
kernel/sched.c:1811: warning: ignoring return value of `put_user', declared with attribute warn_unused_result

include/asm/uaccess.h: In function `mm_release':
kernel/fork.c:459: warning: ignoring return value of `put_user', declared with attribute warn_unused_result

include/asm/uaccess.h: In function `sys_getcpu':
kernel/sys.c:2189: warning: ignoring return value of `get_user', declared with attribute warn_unused_result
kernel/sys.c:2190: warning: ignoring return value of `get_user', declared with attribute warn_unused_result
kernel/sys.c:2193: warning: ignoring return value of `put_user', declared with attribute warn_unused_result
kernel/sys.c:2194: warning: ignoring return value of `put_user', declared with attribute warn_unused_result

Not sure if these three need to be fixed at all... Even though sys_getcpu
looks like it needs to be fixed, but how?


include/asm/uaccess.h: In function `set_termios':
drivers/char/tty_ioctl.c:207: warning: ignoring return value of `get_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:207: warning: ignoring return value of `get_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:207: warning: ignoring return value of `get_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:207: warning: ignoring return value of `get_user', declared with attribute warn_unused_result

include/asm/uaccess.h: In function `n_tty_ioctl':
drivers/char/tty_ioctl.c:236: warning: ignoring return value of `put_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:236: warning: ignoring return value of `put_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:236: warning: ignoring return value of `put_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:236: warning: ignoring return value of `put_user', declared with attribute warn_unused_result
drivers/char/tty_ioctl.c:236: warning: ignoring return value of `put_user', declared with attribute warn_unused_result

These two are because of the nice user_termio_to_kernel_termios and
kernel_termios_to_user_termio macros in asm/termios.h...
Might have a look at these two later.
