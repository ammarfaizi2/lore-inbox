Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUDSRSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUDSRSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:18:20 -0400
Received: from gprs214-2.eurotel.cz ([160.218.214.2]:62851 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261682AbUDSRSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:18:18 -0400
Date: Mon, 19 Apr 2004 19:18:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jakob Lell <jlell@JakobLell.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux 2.6.3 doesn't suspend when mysqld is running.
Message-ID: <20040419171806.GA29218@elf.ucw.cz>
References: <200402271049.14014.jlell@JakobLell.de> <200403141727.03632.jlell@JakobLell.de> <20040321214700.GB14493@elf.ucw.cz> <200403231528.32795.jlell@JakobLell.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403231528.32795.jlell@JakobLell.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> this patch also didn't fix the problem. You can use the program below to test 
> whether a patch fixes the problem yourself. If you can't suspend while this 
> program is running, then the patch doesn't fix the problem.

Okay, this one should work. Hmm, but I'm not quite sure its the right
fix.

								Pavel

> #include <signal.h>
> #include <errno.h>
> #include <stdlib.h>
> 
> int main(int argc,char ** argv){
>   sigset_t set;
>   int sig;
>   sigemptyset(&set);
>   while(sigwait(&set,&sig)==EINTR);
>   return 0;
> }


--- clean/kernel/signal.c	2004-04-07 22:57:17.000000000 +0200
+++ linux/kernel/signal.c	2004-04-19 19:08:47.000000000 +0200
@@ -2134,6 +2134,8 @@
 		if (timeout)
 			ret = -EINTR;
 	}
+	if (current->flags & PF_FREEZE)
+		refrigerator(1);
 
 	return ret;
 }


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
