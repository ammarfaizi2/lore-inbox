Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTHYD1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbTHYD1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:27:37 -0400
Received: from [208.49.116.17] ([208.49.116.17]:51362 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S261428AbTHYD1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:27:36 -0400
Date: Sun, 24 Aug 2003 23:27:12 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@digeo.com>
Subject: [patch 2.6] 3c509.c Fix printed dev id.
Message-ID: <20030825032712.GA2062@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	Callers of el3_common_init() immeadiately then call
register_netdev() and check it for error, and on error
call release_region() on the io addr, and follow an error
path.
	As it stands, the detection prink in el3_common_init()
prints out something like:
eth%d: 3c5x9 at 0x280, BNC port, address  00 20 af 2f d4 81, IRQ 5.
   ^^
	Because the %d is filled out by register_netdev(), called
after the printk.
	This patch just moves all the register_netdev(), and the
release_region() (on error) inside of el3_common_init(), and
gives that function a return value. Now the prink will identify
the device name assigned. Behaviour on error should be
functionally unchanged.

Paul
set@pobox.com
