Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbTHFTmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHFTmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:42:19 -0400
Received: from post.tau.ac.il ([132.66.16.11]:36829 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S271032AbTHFTko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:40:44 -0400
Subject: usbcore module can't unload after swsusp
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060197664.1368.14.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 22:42:06 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.20.0.1; VDF: 6.20.0.55; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a patched kernel 2.4.21 with acpi and swsusp ver 1.0.3
with usb compiled in as a module.

When kernel loads for the first time everything works fine, all usb
modules can be loaded and unloaded properly. After suspending and
restarting, the computer comes up fine and everything works. The
problem is that at this point, when I try to unload the usbcore module
it gets to the point of calling usb_hub_cleanup in drivers/usb/hub.c.
At this points it tried to kill khubd with killproc, which works fine
(the process is stoped), with a return value of 0. The problem is that
at this point the function locks on the call
wait_for_completion(&khubd_exited); which never returns, and rmmod gets
locked. I tried changing the DECLARE_COMPLETION call so that it will be
redone each time the module starts but it didn't solve the problem. Any
ideas on how to further persue this or whether there is a known
solution?

Thanx

-- 
Micha Feigin
michf@math.tau.ac.il

