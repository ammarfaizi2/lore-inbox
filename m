Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUBPAS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUBPASz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:18:55 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:56995 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265273AbUBPASy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:18:54 -0500
Subject: kthread, signals and PF_FREEZE (suspend)
From: Christophe Saout <christophe@saout.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain
Message-Id: <1076890731.5525.31.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 01:18:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering, has kthread been tested with the suspend code?

When trying to freeze the processes the suspend code sets PF_FREEZE on a
process and calls signal_wake_up(p, 0);

That means that signal_pending() will return true for that process which
will make kthread stop the thread.

The workqueues have PF_IOTHREAD set and I'm only seeing those on my
machine that's why it doesn't fail.

But the migration threads for example call signal_pending() directly
after schedule() before checking PF_FREEZE and calling refrigerator()
(which BTW flushes all signals).


