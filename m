Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbUCTSQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 13:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUCTSQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 13:16:32 -0500
Received: from web10401.mail.yahoo.com ([216.136.130.93]:20750 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263505AbUCTSQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 13:16:31 -0500
Message-ID: <20040320181630.27185.qmail@web10401.mail.yahoo.com>
Date: Sat, 20 Mar 2004 10:16:30 -0800 (PST)
From: "Michael W. Shaffer" <mwshaffer@yahoo.com>
Subject: Kernel 2.6.4 Hang in utime() on swap file
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Debian Sarge system running a 2.6 kernel (tested with 2.6.2, 2.6.3,
2.6.4 with the same behavior as described here), and am seeing un-killable
hanging processes with our particular backup product.

When the backup disk agent process is running, one the the last files it
tries to back up is a swap file at the path /swapfile00. The read of the
file appears to work fine, but then it wants to call utime() to reset the
atime/mtime on the file, and at this point the process becomes infinitely
hung, doing nothing, no more output from strace, never terminating.

This only occurs if the swapfile is actively in use when the backup runs. If
I run swapoff to deactivate the swapfile, then the utime() call apparently
completes and the process immediately finishes and exits normally. If the
swapfile is not in use at all, everything works fine.

As a workaround, I am just going to leave this swapfile inactive, since it's
not really used much anyway. I do not observe this behavior on the same
machine running a 2.4.21-xfs kernel.


__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
