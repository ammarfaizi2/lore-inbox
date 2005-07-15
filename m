Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263305AbVGOOZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbVGOOZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbVGOOZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:25:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:13791 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263305AbVGOOZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:25:33 -0400
Subject: Re: console remains blanked
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050713231200.24037.qmail@web25801.mail.ukl.yahoo.com>
References: <20050713231200.24037.qmail@web25801.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 00:25:35 +1000
Message-Id: <1121437536.5963.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 01:12 +0200, Albert Herranz wrote:
> Hi,
> 
> Looks like, since [1] was merged, a blanked console
> (due to inactivity for example) doesn't get unblanked
> anymore when new output is written to it.
> 
> This hunk of the already metioned patch, which
> modifies vt_console_print() in drivers/char/vt.c, is
> possibly the cause:

Yes. We discussed that with Linus back then. The problem is that the
printk subsystem tend to abuse calling low level drivers at interrupt
time, and in the case of blanking/unblanking, this can be a problem.
Radeonfb for example relies on beeing able to schedule() at
blank/unblank time.

If this "feature" is really important, maybe the best is to trigger the
workqueue and do the ublank from there.

Ben.


