Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTJLVmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTJLVmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 17:42:46 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:31196 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261162AbTJLVmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 17:42:43 -0400
Date: Sun, 12 Oct 2003 23:42:26 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Michael Hunold <hunold@convergence.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/14] firmware update for av7110 dvb driver
Message-ID: <20031012214226.GC12939@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <10656197272107@convergence.de> <1065624307.5470.242.camel@pegasus> <3F842EEE.5070001@convergence.de> <3F84332A.6080707@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F84332A.6080707@convergence.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 05:54:18PM +0200, Michael Hunold wrote:
> Hello Marcel,
> >>>... send to Linus only. (You don't want a 150kB bzip2 compressed 
> >>>firmware blob, don't you? In case you do, drop me a line.)
> >
> >
> >>the request_firmware() framework is part of Linux 2.4 and 2.6 and so for
> >>most drivers the firmware file can be loaded from userspace through proc
> >>or sysfs. Please take a look at it.
> 
> >Yes, we know. When I looked at it the last time, there were some 
> >problems that kept us from actually finishing the work.
> >
> >(If you did not use a hotplug agent, then the system was frozen, because 
> >the firmware foo did not use it's own workqueue)
> 
> As a follow-up to my post: I just checked what already got in and what's 
> still missing. I attached the stuff from request_firmwar() that didn't 
> make it into the kernel yet.
> 
> Please note that I did not check if the problem has been solved 
> otherwise. Perhaps Manuel Estrada Sainz <ranty@debian.org> can tell us 
> what the current state is?

 The patch should work but Andrew Morton didn't like the fact that in
 practice the kernel end's up having some threads around full time for
 the sole purpose of loading firmware once in a while.

 I should make a new patch to spawn a thread for each firmware load and
 have them die when the job is done. And stop using workqueues at all.

 	- Performance should not be an issue since firmware should
	  seldom be needed.
	- Code complexity shouldn't change much either.

 Comments are welcomed.

 If the issue seams urgent, the current "private workqueue" patch could
 be applied and replaced later with a cleaner solution.
 
 Just for the record I should get the job done within a couple of weeks.
 A proposal patch would of course help :)

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
