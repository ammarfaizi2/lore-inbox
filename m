Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTLOSxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTLOSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:53:48 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:32954 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263903AbTLOSxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:53:08 -0500
Date: Tue, 16 Dec 2003 07:22:28 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Suspend not working with SATA:
In-reply-to: <3FDDD0B0.60807@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1071512548.14229.88.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200312151600.53372.adasi@kernel.pl> <3FDDD0B0.60807@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Set PF_IOTHREAD on the task's flags instead. That will allow it to run
during suspending.

Regards,

Nigel

On Tue, 2003-12-16 at 04:18, Jeff Garzik wrote:
> Witold Krecicki wrote:
> > Stopping tasks: 
> > ==================================================================
> >  stopping tasks failed (2 tasks remaining)
> > Restarting tasks...<6> Strange, katad-1 not stopped
> >  Strange, katad-2 not stopped
> >  done
> 
> 
> Both Pavel Machek and I posted test patches to address this... 
> basically, because of the design of swsusp, you must copy-n-paste the 
> following code into every single kernel thread:
> 
>                          if (current->flags & PF_FREEZE)
>                                  refrigerator(PF_IOTHREAD);
> 
> But I consider suspend untested at best... for reboot and suspend the 
> driver should issue flush-cache and other things beyond simply freezing 
> the kernel thread.  Further, suspending will suck if the kernel thread 
> itself is the one doing I/O on behalf of the driver.  This occurs if the 
> transfer mode is PIO rather than DMA.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

