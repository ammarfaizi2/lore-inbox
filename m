Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUAIVEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUAIVEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:04:53 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:24465 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S264396AbUAIVEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:04:52 -0500
Date: Fri, 9 Jan 2004 13:04:50 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 SMP lockups
Message-ID: <20040109210450.GA31404@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo all,

We've had about 6 cases of this now, across 4 separate boxes.  Since
upgrading to 2.4.24, our SMP web server boxes (both Intel and AMD
hardware) are randomly blowing up.  This may have happened on 2.4.23 as
well, but they weren't really running long enough to tell.  2.4.22 was
fine.  GCC 3.3.3.

These boxes are all dual CPU, and the failure case shows up suddenly with
no warning.  Sysreq-P works, but only reports from one CPU no matter how
many times I try.  In normal operation, every machine distributes all
IRQs across both CPUs, and Sysreq-P reports from both CPUs.

Mapping the EIP reported by Sysreq-P to symbols shows that the responding
CPU is spinning on a spinlock (so far I have seen .text.lock.fcntl,
.text.lock.sched, .text.lock.locks, and .text.lock.inode), which I assume
is being held by the other (dead) CPU.

Even on boxes with nmi_watchdog=1, nothing is reported from the NMI
watchdog.

Simon-
