Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTBEMNO>; Wed, 5 Feb 2003 07:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267939AbTBEMNO>; Wed, 5 Feb 2003 07:13:14 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:50882 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267934AbTBEMMf>; Wed, 5 Feb 2003 07:12:35 -0500
Date: Wed, 5 Feb 2003 13:22:05 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Oleg Drokin <green@namesys.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: use 64 bit jiffies broke HZ=100 case (and fix)
In-Reply-To: <20030205144206.A25320@namesys.com>
Message-ID: <Pine.LNX.4.33.0302051315450.6650-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Oleg Drokin wrote:

> In order to get UML to compile again (and pretty much any other HZ=100 arch)
> I need to apply this patch below:
>
[ further '>'s removed to allow direkt feeding to 'patch']

===== fs/proc/proc_misc.c 1.63 vs edited =====
--- 1.63/fs/proc/proc_misc.c	Tue Nov 12 12:37:55 2002
+++ edited/fs/proc/proc_misc.c	Wed Feb  5 14:28:50 2003
@@ -121,8 +121,7 @@
 	}
 #else
 	{
-		unsigned long idle = init_task.times.tms_utime
-		                     + init_task.times.tms_stime;
+		unsigned long idle = init_task.utime + init_task.stime;

 		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime,
>
>
Yep. Unfortunately I tested HZ=100 only with the original patch and missed
these when rediffing. Thanks for spotting this.

Linus, please apply.

Tim


