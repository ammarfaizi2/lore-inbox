Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVKPRad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVKPRad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVKPRad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:30:33 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:7160 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S965081AbVKPRac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:30:32 -0500
Message-ID: <437B6C9C.3060307@mvista.com>
Date: Wed, 16 Nov 2005 09:30:04 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts (take 2)
References: <1132158489.5457.10.camel@tdi>
In-Reply-To: <1132158489.5457.10.camel@tdi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you _please_ not put inline patches after the signature mark ("-- ").  In my mailer (mozilla) 
this causes the patch to be greyed out and, more importantly, NOT included in a reply.  This, in 
turn, makes it hard to comment on details in the patch.

Thanks
George
-- 


Alex Williamson wrote:
> Hi Russell,
> 
>    I've revised the patch for this backup timer idea based on your
> comments.  Hopefully the restoring of the timer function to the default
> serial8250_timeout is more obvious now.  I also re-ordered some of the
> conditions around the bug test to add further clarity.  Please let me
> know if you see any further issues with this patch.  Patch below is
> against 2.6.14-mm2.  Here's the original patch description message:
> 
>    The patch below works around a minor bug found in the UART of the
> remote management card used in many HP ia64 and parisc servers (aka the
> Diva UARTs).  The problem is that the UART does not reassert the THRE
> interrupt if it has been previously cleared and the IIR THRI bit is
> re-enabled.  This can produce a very annoying failure mode when used as
> a serial console, allowing a boot/reboot to hang indefinitely until an
> RX interrupt kicks it into working again (ie. an unattended reboot could
> stall).  Paul Bame submitted a complete workaround for 2.4 kernels a few
> years ago - http://lkml.org/lkml/2003/5/6/203.  The problem has not been
> as prevalent on the 2.6 serial driver, thus the solution below is
> simplified to only insert a backup timeout to kick the UART when it gets
> into trouble.  This runs alongside the normal interrupt driven UART code
> and has a longer period that the standard polling driver to reduce CPU
> overhead.  The detection test should be safe for all UARTs and the
> backup timer can easily be extended to include other UARTs with similar
> disorders.
> 
>    Please apply.  Thanks,
> 
> 	Alex
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
