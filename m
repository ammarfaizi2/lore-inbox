Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275416AbTHNTia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275417AbTHNTia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:38:30 -0400
Received: from post.tau.ac.il ([132.66.16.11]:55205 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S275416AbTHNTi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:38:29 -0400
Subject: modprobe usbcore from acpid problem 2.4.21
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060889818.1511.1.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Aug 2003 22:39:24 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.1; VDF: 6.21.0.16; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in the usbcore module, such that if it is loaded using
modprobe from an acpid script in response to an event it later fails to
unload again.

I isolated the problem to calling /etc/init.d/modutils (debian) from a
script that is called in responce to the sleep button event. This in
turn loads every module in /etc/modules using modprobe.
The modules loaded this way are (in this order):
hid
mousedev
uhci
When I later try to unload the usb modules, the usbcore module locks at:
drivers/usb/hub.c:void usb_hub_cleanup(void)
at the call to
wait_for_completion(&khubd_exited);

This doesn't happen if I call /etc/init.d/modutils manually from the
command line.

This is under kernel 2.4.21 (debian version) with acpi+swsusp patches.
Any ideas what would be different between this two methods that can
cause this bug ? I have ruled out the fact that acpid is run as a
daemon and might thus cause a problem with the reparent_to_init call
(ran it as a regular program, no help).

-- 
Micha Feigin
michf@math.tau.ac.il

