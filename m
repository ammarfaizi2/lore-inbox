Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTLOPS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTLOPS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:18:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263870AbTLOPSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:18:24 -0500
Message-ID: <3FDDD0B0.60807@pobox.com>
Date: Mon, 15 Dec 2003 10:18:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Witold Krecicki <adasi@kernel.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend not working with SATA:
References: <200312151600.53372.adasi@kernel.pl>
In-Reply-To: <200312151600.53372.adasi@kernel.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witold Krecicki wrote:
> Stopping tasks: 
> ==================================================================
>  stopping tasks failed (2 tasks remaining)
> Restarting tasks...<6> Strange, katad-1 not stopped
>  Strange, katad-2 not stopped
>  done


Both Pavel Machek and I posted test patches to address this... 
basically, because of the design of swsusp, you must copy-n-paste the 
following code into every single kernel thread:

                         if (current->flags & PF_FREEZE)
                                 refrigerator(PF_IOTHREAD);

But I consider suspend untested at best... for reboot and suspend the 
driver should issue flush-cache and other things beyond simply freezing 
the kernel thread.  Further, suspending will suck if the kernel thread 
itself is the one doing I/O on behalf of the driver.  This occurs if the 
transfer mode is PIO rather than DMA.

	Jeff



