Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWGPQha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWGPQha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWGPQha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:37:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:29852 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751116AbWGPQha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:37:30 -0400
Date: Sun, 16 Jul 2006 18:37:28 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716163728.GA16228@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
is NULL. This happens since at least a week. Call trace is:

aty128_set_lcd_enable
aty128fb_set_par
fbcon_init
visual_init
take_over_console
fbcon_takeover
notifier_call_chain
blocking_notifier_call_chain
register_framebuffer
aty128fb_probe
pci_device_probe
bus_for_each_dev
driver_attach
bus_add_driver
driver_register
__pci_register_driver
aty128fb_init
init
kernel_thread

This happens on a PowerBook pismo.
