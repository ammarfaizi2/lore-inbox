Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269328AbUJKXCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269328AbUJKXCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJKXAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:00:00 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:3756 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S269329AbUJKW7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:59:24 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>
Subject: swsusp resume doesn't sysdev_resume
Date: Mon, 11 Oct 2004 16:59:16 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410111659.16373.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swsusp often fails on -mm kernels because sysdev_resume doesn't
get called in the resume path.  So things like ACPI IRQ links
used by modular drivers don't get restored.

We can work around this by using "pci=routeirq", so all the IRQ
setup gets done at boot-time, but that's an ugly hack, and I
expect that we'll trip over other sysdevs that need to be resumed
anyway.

I don't understand swsusp well enough to fix this.  It's not enough
to just call device_power_up() before device_resume(), because it
relies on sysdev_suspend() having been called before the suspend
image was created.

Any hints?
