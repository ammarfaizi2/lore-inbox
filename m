Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVKWNZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVKWNZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKWNZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:25:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28878 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750790AbVKWNZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:25:54 -0500
Date: Wed, 23 Nov 2005 14:25:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bj?rn Mork <bmork@dod.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051123132541.GD23159@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511220026.55589.dtor_core@ameritech.net> <20051122184739.GB1748@elf.ucw.cz> <200511222315.31033.rjw@sisk.pl> <20051122225120.GI1748@elf.ucw.cz> <87hda3d6b8.fsf@obelix.mork.no> <20051123120142.GA18403@elf.ucw.cz> <87veyjbj5q.fsf@obelix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87veyjbj5q.fsf@obelix.mork.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok, can you suggest better wording?
> 
> maybe something like 
> 
> --- linux-2.6.15-rc1/kernel/power/process.c.orig	2005-11-18 10:15:12.000000000 +0100
> +++ linux-2.6.15-rc1/kernel/power/process.c	2005-11-23 13:38:41.000000000 +0100
> @@ -83,7 +83,7 @@
>  		yield();			/* Yield is okay here */
>  		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
>  			printk( "\n" );
> -			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
> +			printk(KERN_ERR " stopping tasks timed out after %d seconds (%d tasks remaining)\n", TIMEOUT/HZ, todo );
>  			break;
>  		}
>  	} while(todo);
> 
> 
> ?
> 
> Or basically any text that makes it clear that we didn't really try
> that hard to stop the task.  We just gave up early.

Ok, this should be enough.... its more accurate than original still
not too long ;-). It will go upstream ... some day.
								Pavel

Update message according to Bjorn.

---
commit 3248196034f5f0a93554b441bd41af2620afa635
tree 5bf3f8dd1ced574ca20b3c942a6b16c391c6352a
parent a57b538c084cd601a627674ebb5f09c13be42143
author <pavel@amd.(none)> Wed, 23 Nov 2005 14:23:24 +0100
committer <pavel@amd.(none)> Wed, 23 Nov 2005 14:23:24 +0100

 kernel/power/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -83,7 +83,7 @@ int freeze_processes(void)
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
 			break;
 		}
 	} while(todo);

-- 
Thanks, Sharp!
