Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUBKGqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUBKGqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:46:54 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:45715 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263625AbUBKGqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:46:07 -0500
Message-ID: <4029CFAD.9090400@comcast.net>
Date: Tue, 10 Feb 2004 22:46:05 -0800
From: Stephen Hemminger <schemminger@comcast.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Frank <mhf@linuxmail.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [Swsusp-devel] Kernel 2.6 pm_send_all() issues.
References: <200402102343.06896.mhf@linuxmail.org>
In-Reply-To: <200402102343.06896.mhf@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:

> This question is probably better suited for LKML.
> 
> ----------  Forwarded Message  ----------
> 
> Subject: [Swsusp-devel] Kernel 2.6 pm_send_all() issues.
> Date: Tuesday 10 February 2004 04:06
> From: Wolfgang Glas <wolfgang.glas@ev-i.at>
> To: swsusp-devel@lists.sourceforge.net
> 
> Coming back to an earlier post, which states, that NVidia suspend/resume under 
> 2.6.x could be resurrected, if  drivers_suspend() and drivers_resume() in 
> swsusp.c are tuned in a way, that pm_send_all() is called, I want to direct 
> the following question to more eligible persons in this list:
> 
>   I inspected NVidia's driver and I found out, that it's implemented as a 
> character device and hence does not implement the suspend/resume kernel 
> driver interface, which has been introduced in linux-2.6. But nevertheless 
> this driver has the ability to register its own power management handler 
> through pm_register(), an interface already present in linux-2.4 and still 
> used in some 20 drivers present in the linux-2.6.1 code base, most notable 
> some audio driver and some irda drivers.
> 
>   Diving further into the code, I recognized, that the kernel function 
> ppm_send_all(), which calls all handlers registered through pm_register() is 
> never called inside of swsusp2.c
> 
>   So, what I want to ask is, whether the pm_register/pm_send/pm_send_all 
> interface is simply deprecated and the NVidia driver (and other drivers, 
> which use pm_register) should be reeingineered in order to use the 
> resume/suspend interface of linux-2.6. Or should we try to modify swsusp2.c 
> in a way, that it additionally calls  pm_send_all for these drivers?
> 
>    TIA,
> 
>       Wolfgang

I sent them a patch that converts the PCI device to the device model and
uses suspend/resume hooks.  But they didn't seem to put it in the 
current version
