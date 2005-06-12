Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVFLJNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVFLJNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVFLJNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:13:07 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:25575 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261920AbVFLJNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:13:02 -0400
Message-ID: <42AC0084.50502@freemail.hu>
Date: Sun, 12 Jun 2005 11:29:40 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Content-Type: multipart/mixed;
 boundary="------------070905090301060109060902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905090301060109060902
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

> does -48-13 work any better?
> 
> 	Ingo

x86-64 needs the attached patch to compile.
Some drivers also fail to compile because of
SPIN_LOCK_UNLOCKED changes, e.g. softdog and
four files under net/atm. Just take the x86-64 UP
config from FC3's latest errata kernel.
I haven't booted it yet.

A question, though: why do you comment out the
DMPS timer in drivers/char/vt.c?
Does it cause any problems? I applied the -RT tree
after the multiconsole patch and I had to modify
those four chunks manually.

Best regards,
Zoltán Böszörményi


--------------070905090301060109060902
Content-Type: text/x-patch;
 name="01-x86_64-INIT_FILES-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-x86_64-INIT_FILES-fix.patch"

--- arch/x86_64/kernel/init_task.c.old	2005-06-12 10:51:21.716609376 +0200
+++ arch/x86_64/kernel/init_task.c	2005-06-12 10:51:33.889758776 +0200
@@ -11,7 +11,7 @@
 #include <asm/desc.h>
 
 static struct fs_struct init_fs = INIT_FS;
-static struct files_struct init_files = INIT_FILES;
+static struct files_struct init_files = INIT_FILES(init_files);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);

--------------070905090301060109060902--
