Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSAMDmD>; Sat, 12 Jan 2002 22:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286615AbSAMDlx>; Sat, 12 Jan 2002 22:41:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:15122 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285829AbSAMDlo>; Sat, 12 Jan 2002 22:41:44 -0500
Message-ID: <3C4100A4.2EDA7410@zip.com.au>
Date: Sat, 12 Jan 2002 19:36:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael C. Toren" <mct@toren.net>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: acquire_console_sem exported, but not release_console_sem?
In-Reply-To: <20020112215402.A3254@quint.netisland.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael C. Toren" wrote:
> 
> Hi,
> 
> In kernel/printk.c, it looks like acquire_console_sem() is exported, but
> not release_console_sem()?  Is this intentional, or just an oversight?

Oversight.  It's possible that some modular video drivers will need
to acquire this lock, so it should be exported.  At this time, it's
only fbcon.c and that code doesn't support modular linkage, so
nobody has noticed.

--- linux-2.4.18-pre3/kernel/printk.c	Thu Jan 10 13:39:50 2002
+++ linux-akpm/kernel/printk.c	Sat Jan 12 19:32:50 2002
@@ -529,6 +529,7 @@ void release_console_sem(void)
 	if (must_wake_klogd && !oops_in_progress)
 		wake_up_interruptible(&log_wait);
 }
+EXPORT_SYMBOL(release_console_sem);
 
 /** console_conditional_schedule - yield the CPU if required
  *
