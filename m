Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbTEMGKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTEMGKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:10:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263177AbTEMGKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:10:47 -0400
Date: Tue, 13 May 2003 07:23:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [RFC][TTY] callout removal
Message-ID: <20030513062332.GW10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, it had been quite a few years since callout tty devices had
been deprecated.  IMO it's time to bury them - the following

        if ((tty->driver.type == TTY_DRIVER_TYPE_SERIAL) &&
            (tty->driver.subtype == SERIAL_TYPE_CALLOUT)) {
                printk("Warning, %s opened, is a deprecated tty "
                       "callout device\n", tty_name(tty, buf));

in tty_open() had been theres since 2.1.90-pre2.  IOW, we had two stable
branches since then.

Quite a few things in tty code and related data structures exist only
because of these beasts and I'd rather get rid of them.

If nobody has serious objections I'll submit patches removing that stuff,
so if you _do_ have a reason to keep callouts around, yell now.
