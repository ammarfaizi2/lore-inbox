Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275497AbTHJJZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275498AbTHJJZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:25:19 -0400
Received: from post.tau.ac.il ([132.66.16.11]:46315 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S275497AbTHJJZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:25:16 -0400
Subject: usb driver problem when suspending from acpid
From: Micha Feigin <michf@math.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060470222.16293.12.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 12:26:41 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.20.0.1; VDF: 6.20.0.55; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a 2.4.21 kernel with acpi + swsusp patches (had the same
behavior with swsusp 1.0.* and 1.1-rc)

When calling the hibernation script that appears on the swsusp site to
unload all modules and services and then suspend to disk (S4) from the
command line (anywhere: xterm, console whatever) everything works fine.
When calling the script from acpid in response to the power button being
pressed, the script locks on the second suspend attempt when trying to
unload the usbcore module (rmmod never returns and can't be killed using
kill -9, presumably since its stuck on a system call)

I have tracked the lock point to thefile  drivers/usb/hub.c. The
offending function is usb_hub_cleanup which locks up on the call to 
wait_for_completion(&khubd_exited);

I don't know if this could be related, but when calling the script with
--verbose option it also fails since it can't find a tty to print the
errors to. It tries to open /dev/tty<something> and fails, although I am
not sure what the difference is since the script switches away from X
when it starts.
I have made a few attempts at the kernel source but couldn't solve the
problem.


