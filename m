Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSGQUIc>; Wed, 17 Jul 2002 16:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGQUIc>; Wed, 17 Jul 2002 16:08:32 -0400
Received: from pD952AE51.dip.t-dialin.net ([217.82.174.81]:58524 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316623AbSGQUIa>; Wed, 17 Jul 2002 16:08:30 -0400
Date: Wed, 17 Jul 2002 14:11:11 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Pavel Machek <pavel@ucw.cz>
Subject: SWSUSP in 2.5
Message-ID: <Pine.LNX.4.44.0207171402560.3452-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling software suspend, I get the following warning:

suspend.c: In function `prepare_suspend_processes':
suspend.c:602: warning: implicit declaration of function `sys_sync'

The reasons seems, to me, that no header file ever talks about sys_sync, 
except for a small comment in include/linux/writeback.h. via-pmu uses it, 
too, they have their own prototype. It might be an idea to add this 
one-liner:

--- kernel/suspend.c~   Wed Jul 17 14:09:57 2002
+++ kernel/suspend.c    Wed Jul 17 14:10:17 2002
@@ -66,6 +66,7 @@
 #include <linux/swapops.h>
 
 extern void signal_wake_up(struct task_struct *t);
+extern int sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
 

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

