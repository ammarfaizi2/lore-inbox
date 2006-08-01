Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWHAHQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWHAHQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWHAHQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:16:30 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:25130 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S932543AbWHAHQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:16:30 -0400
Subject: udev taking a long time during startup
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: linux-kernel@vger.kernel.org
Cc: piet at work <piet@work.piet.net>, Piet Delaney <piet@bluelane.com>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Tue, 01 Aug 2006 00:16:25 -0700
Message-Id: <1154416586.4332.64.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2006 07:16:29.0762 (UTC) FILETIME=[68CCCA20:01C6B53A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Gang:

We were wondering why there is a 60 second delay on our systems
from the time that the kernel releases memory and the file system 
is checked.

I dropped into kgdb during this period and found that an init
script, S10udev in our case, was sleeping in sys_nanosleep()
or sys_wait4(). Looks like thread/process S10udev forks udevstart
which forks udev which appears to be sleeping or waiting every time
I check in on it; Seems terribly wasteful.

udev seems to be a utility for hotplug and configured
with /etc/udev/udev.conf. Since we have no hot plug devices
I wonder if it really has to be called on every startup. On
solaris the device nodes are only re-established if you boot
with a -r option.

I never see any children of udev, so I wonder why it's
calling wait4() and nanosleep() so often.

Any thoughts or suggestions?

-piet

-- 
Piet Delaney
BlueLane Teck
W: (408) 200-5256; piet@bluelane.com
H: (408) 243-8872; piet@piet.net


