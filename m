Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTHUUoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTHUUoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:44:13 -0400
Received: from post.tau.ac.il ([132.66.16.11]:20203 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262905AbTHUUoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:44:08 -0400
Subject: PROBLEM [2.4]: modprobe usb modules from acpid script bug
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061426556.2441.37.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 22:33:22 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.1; VDF: 6.21.0.26; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is bug when using modprobe on the usb modules, and specifically
the usbcore, from acpid script. I don't know about other non interactive
scripts. Its ok from command line scripts. It does also happen when
acpid is not run in daemon mode.
The module loads properly, but when tring to remove using either rmmod
or modprobe -r, they both lock up in
drivers/usb/hub.c:void usb_hub_cleanup(void)
at the line
wait_for_completion(&khubd_exited);

This problem appeared in kernels
2.4.20, 2.4.21 with acpi patch (for acpid to work), both debian and
regular version, with and without swsusp.
and also unpatched
2.4.22-rc2 and 2.4.22-ac2

This bug appeared several times on the acpi and swsusp mailing lists
under the subject of hibernation or suspend not working with acpid.
For some people it worked not to load usbcore directly using modprobe
but only as a dependency. Didn't solve the problem on my machine.

I am running a sony vaio pcg-fxa53, amd athelon 1500+ (1.3 G) with via
chipset.

-- 
Micha Feigin
michf@math.tau.ac.il

