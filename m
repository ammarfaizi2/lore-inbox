Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270628AbTHJTji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 15:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270632AbTHJTji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 15:39:38 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:40168 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S270628AbTHJTjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 15:39:36 -0400
Date: Mon, 11 Aug 2003 07:38:38 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: usb driver problem when suspending from acpid
In-reply-to: <1060470222.16293.12.camel@litshi.luna.local>
To: Micha Feigin <michf@math.tau.ac.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1060544317.8803.1.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1060470222.16293.12.camel@litshi.luna.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Since you're talking swsusp for 2.4 kernels, this message should go to
the swsusp-devel list. (Added in this reply). Some of the guys there use
usb more than I do, so you might get a useful reply when they see this.

Regards,

Nigel

On Sun, 2003-08-10 at 21:26, Micha Feigin wrote:
> I am running a 2.4.21 kernel with acpi + swsusp patches (had the same
> behavior with swsusp 1.0.* and 1.1-rc)
> 
> When calling the hibernation script that appears on the swsusp site to
> unload all modules and services and then suspend to disk (S4) from the
> command line (anywhere: xterm, console whatever) everything works fine.
> When calling the script from acpid in response to the power button being
> pressed, the script locks on the second suspend attempt when trying to
> unload the usbcore module (rmmod never returns and can't be killed using
> kill -9, presumably since its stuck on a system call)
> 
> I have tracked the lock point to thefile  drivers/usb/hub.c. The
> offending function is usb_hub_cleanup which locks up on the call to 
> wait_for_completion(&khubd_exited);
> 
> I don't know if this could be related, but when calling the script with
> --verbose option it also fails since it can't find a tty to print the
> errors to. It tries to open /dev/tty<something> and fails, although I am
> not sure what the difference is since the script switches away from X
> when it starts.
> I have made a few attempts at the kernel source but couldn't solve the
> problem.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

