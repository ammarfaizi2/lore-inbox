Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbSJZKcs>; Sat, 26 Oct 2002 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJZKYW>; Sat, 26 Oct 2002 06:24:22 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:23564 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262042AbSJZKX3>; Sat, 26 Oct 2002 06:23:29 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Wed, 23 Oct 2002 11:05:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hu Gang <hugang@soulinfo.com>
Cc: EricAltendorf@orst.edu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug: swsusp in 2.5.42: "Scheduling while atomic"
Message-ID: <20021023090503.GA3416@elf.ucw.cz>
References: <200210171636.13669.EricAltendorf@orst.edu> <20021018092521.3180fd42.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018092521.3180fd42.hugang@soulinfo.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> |[1.] One line summary of the problem: 
> |
> |Scheduling while atomic debug message during swsusp
> |
> |[2.] Full description of the problem/report:
> |
> |While swsusp'ing to disk, vast quantities of error messages are echoed to the
> |console, along the lines of the following pulled from /var/log/messages:
> 
> This Problem is net lay resume recall problem. Try this patch, From
> |my test it can works in net card device, but it can not work in
> |sound card device.

With this and CONFIG_PREEMPT on, do you see any "scheduling while
atomic" messages? I do not think this can fix them completely...

								Pavel

> -------------------------
> --- linus-2.5/kernel/suspend.c	Fri Oct 18 09:22:36 2002
> +++ linus-2.5-suspend/kernel/suspend.c	Thu Oct 17 20:42:08 2002
> @@ -627,7 +627,7 @@
>  /* Make disk drivers accept operations, again */
>  static void drivers_unsuspend(void)
>  {
> -	device_resume(RESUME_RESTORE_STATE);
> +	/* device_resume(RESUME_RESTORE_STATE); */
>  	device_resume(RESUME_ENABLE);
>  }
>  
> @@ -655,7 +655,7 @@
>  static void drivers_resume(int flags)
>  {
>  	if (flags & RESUME_PHASE1) {
> -		device_resume(RESUME_RESTORE_STATE);
> +		/* device_resume(RESUME_RESTORE_STATE); */
>  		device_resume(RESUME_ENABLE);
>  	}
>    	if (flags & RESUME_PHASE2) {
> 
> 



-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
