Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTFKU6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTFKU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:58:55 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:12456 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264449AbTFKU6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:58:54 -0400
Date: Wed, 11 Jun 2003 23:12:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: oprofile broken by sysfs updates
Message-ID: <20030611211220.GA634@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I only tried reading the diffs, but:

arch/i386/oprofile/nmi_int.c must be suspended before
arch/i386/kernel/apic.c is.

How is that guaranteed with new code?

-static struct device device_nmi = {
-       .name   = "oprofile",
-       .bus_id = "oprofile",
-       .driver = &nmi_driver,
-       .parent = &device_lapic.dev,
+static struct sys_device device_oprofile = {
+       .id     = 0,
+       .cls    = &oprofile_sysclass,
 };


							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
