Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVHEANf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVHEANf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVHEANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:13:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262791AbVHEAN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:13:29 -0400
Date: Thu, 4 Aug 2005 17:15:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net, pavel@ucw.cz
Subject: Re: 2.6.13-rc4: yenta_socket and swsusp
Message-Id: <20050804171514.01028a67.akpm@osdl.org>
In-Reply-To: <42EE9A60.5050700@domdv.de>
References: <42EE9A60.5050700@domdv.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
>
> [now sending to lkml as sending to the pcmcia list without being
> subscribed seems to go to /dev/null]

Seems that the linux-kernel list has the same result ;(

> I do have problems with yenta_socket on my x86_64 laptop which appear
> when using swsusp (suspend to disk mode).
> 
> 1. When I do not access any pcmcia device from initrd during boot
>    I have to terminate cardmgr, otherwise suspend to disk hangs.
>    For 2.6.11 it was sufficient to call 'cardctl eject'.
> 
> 2. When I have to access a pcmcia device from initrd during boot
>    (there's required crypto keys stored on a pcmcia flash disk)
>    and I do not unload yenta_socket prior to suspend the laptop
>    spontaneously reboots or just hangs on resume when swsusp has
>    finished loading.
> 
> 3. If I do not unload the pcmcia modules prior to suspend with
>    rmmod -w unloading yenta_socket fails.
> 
> 4. If I do unload the pcmcia modules in a loop with rmmod -w
>    but no delay between unloading the modules it happens from
>    time to time that yenta_socket unloading hangs with a use
>    count of 2 when there is definitely no more user of the module.
>    A delay of 50 msec after unload of each pcmcia module seems
>    to cure this.
> 
> 5. If I insert yenta_socket within the first few seconds after resume
>    the laptop spontaneously reboots. A 5 second delay seems to cure
>    this most of the time.

OK so we have one solid regression there.  Are the other problems also new
since 2.6.11?

Could you please retest 2.6.13-rc6 when it's out and if problems remain,
raise a bugzilla.kernel.org entry so we can keep track of the problem? 
Thanks.

(I'm trying to get all unattended and older-than-a-few-days bug reports
pushed over to bugzilla so they don't get lost).

> BTW:
> Did I read this right? PCMCIA control ioctl (needed for pcmcia-cs
> [cardmgr, cardctl]) scheduled for removal in november *this* year? So a
> 3 month warning for everybody is sufficient? Probably only one kernel
> release? So much for sufficient backwards compatability. Especially as
> the tools stated to be required aren't even released as of today (hint:
> module-init-tools 3.2). Grrr.

Three months does sound optimistic.  Dominik, wouldn't a year be better?
