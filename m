Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVCVEBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVCVEBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVCVEBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:01:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30945 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262377AbVCVD7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:59:10 -0500
Subject: kernel bug: futex_wait hang
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Chris Morgan <cmorgan@alum.wpi.edu>,
       Paul Davis <paul@linuxaudiosystems.com>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 22:59:10 -0500
Message-Id: <1111463950.3058.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis and Chris Morgan have been chasing down a problem with
xmms_jack and it really looks like this bug, thought to have been fixed
in 2.6.10, is the culprit.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.0/2044.html

(for more info google "futex_wait 2.6 hang")

It's simple to reproduce.  Run JACK and launch xmms with the JACK output
plugin.  Close XMMS.  The xmms process hangs.  Strace looks like this:

rlrevell@krustophenia:~$ strace -p 7935
Process 7935 attached - interrupt to quit
futex(0xb5341bf8, FUTEX_WAIT, 7939, NULL

Just like in the above bug report, if xmms is run with
LD_ASSUME_KERNEL=2.4.19, it works perfectly.

I have reproduced the bug with 2.6.12-rc1.

Lee

