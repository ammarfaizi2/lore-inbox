Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267342AbUGNJjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267342AbUGNJjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUGNJjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:39:15 -0400
Received: from [211.152.157.138] ([211.152.157.138]:59063 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S267342AbUGNJjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:39:09 -0400
Date: Wed, 14 Jul 2004 17:29:57 +0800
From: Hugang <hugang@soulinfo.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
Subject: Re: [PATCH] fix rmmod sbp2 hang in 2.6.7
Message-Id: <20040714172957.52de0f9b@localhost>
In-Reply-To: <20040714102417.A12942@flint.arm.linux.org.uk>
References: <20040714114854.29d4e015@localhost>
	<20040714161357.426b5c08@localhost>
	<20040714171107.49aa64f7@localhost>
	<20040714102417.A12942@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 10:24:17 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

| This down+up prevents drivers from being unloaded until there are no
| references to their struct device_driver.  By removing this, you open
| the very real possibility for an oops to occur.
Yes, I agree with you. When sbp2 is using the module count is not zero, 
so I can rmmod it, So I think, for sbp2 that's safe, That's true on my laptop.

| 
| If you're waiting inside that function for the last reference to be
| dropped, the real question is why you still have references to it.
There are tree places that reference ->unload_sem in linux kernel tree, but I
don't known, why the same code in 2.6.4 can works fine. :)

bus.c:68:       up(&drv->unload_sem);
driver.c:110:   down(&drv->unload_sem);
driver.c:111:   up(&drv->unload_sem);

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
