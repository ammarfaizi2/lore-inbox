Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272446AbTGZKDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272447AbTGZKDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:03:39 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:61402 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S272446AbTGZKDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:03:37 -0400
Date: Sat, 26 Jul 2003 12:18:18 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Michael Hunold <hunold@convergence.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] request_firmware() private workqueue (was: Re: Using firmware_class with recent 2.6 kernels)
Message-ID: <20030726101818.GA25104@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <3F1BD157.4090509@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1BD157.4090509@convergence.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:41:11PM +0200, Michael Hunold wrote:
[snip]
> To get a start, I took your sample driver and compiled it as a module.
> I commented out all firmware load methods, except the async
> notification I'm most interested in.
> 
> When I load the module, it prints the debug message and goes to sleep -- 
> ok. But now the system is completely frozen (no keyboard or mouse 
> interaction possible) until the timeout is reached and the async 
> notification function is called, which of course says that the firmware 
> could not been loaded.

 Using a private workqueue fixes the issue, sleeping for many seconds
 from the common workqueue was not nice.

 Note that the problem only happens when appropriate firmware hotplug
 support is not available and request_firmware_work_func() has to wait
 until the timeout.

 About the attached patch:
 
 	- use a private workqueue so we can sleep without interfering
	  with other subsystems.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
