Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWDDBt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWDDBt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 21:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWDDBt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 21:49:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:34263 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751420AbWDDBt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 21:49:56 -0400
Date: Tue, 4 Apr 2006 03:49:54 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <Pine.LNX.4.64.0603261624110.15079@alien.or.mcafeemobile.com>
Subject: POLLRDHUP inconsistency between poll() and epoll
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <20134.1144115394@www102.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide,

While playing about with the new POLLRDHUP flag, I've noticed
an inconsistency, which may or may not be intentional...

When a POLLRDHUP condition occurs, epoll_wait() tells us about 
the condition, regardless of whether or not we specified 
(E)POLLRDHUPP in the 'events' flag given to epoll_ctl() 
EPOLL_CTL_ADD.  In this respect, POLLRDHUP is treated just like
POLLHUP and POLLERR.  This seems perfectly reasonable.

By contrast, poll() will only tell us that POLLRDHUP occurred
if we specified POLLRDHUP in the file descriptor 'events' mask 
given to the poll() call.  In other words, poll() treats 
POLLRDHUP differently from POLLHUP and POLLERR.  This seems
a little strange.

Is this difference really intended?  If it is, what is the 
reason for the difference?

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
