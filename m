Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbTJKMBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTJKMBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:01:13 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64236 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263291AbTJKMBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:01:10 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-Id: <1065873664.30987.431.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sat, 11 Oct 2003 13:01:05 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Signals and kernel threads.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, kernel threads could make use of signals for receiving
control from userspace. Now, the NPTL code looks at the recipient
thread's userspace handlers for signals, even in the case of a kernel
thread, and if there's not a handler installed will either discard the
signal or convert it to SIGKILL.

Could we disable this behaviour in the case where the recipient is a
kernel thread please? Or at least make allow_signal() set sa_handler to
some non-zero dummy value so that the signal is delivered as intended.

-- 
dwmw2


