Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbULCPYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbULCPYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbULCPYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:24:30 -0500
Received: from blanca.radiantdata.com ([64.207.39.196]:39138 "EHLO
	blanca.peakdata.loc") by vger.kernel.org with ESMTP id S262259AbULCPYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:24:20 -0500
Message-ID: <41B086DF.6010107@radiantdata.com>
Date: Fri, 03 Dec 2004 08:31:43 -0700
From: "Peter W. Morreale" <morreale@radiantdata.com>
Reply-To: morreale@radiantdata.com
Organization: Radiant Data Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kiran Kumar Gaitonde <kiran.gaitonde@globaledgesoft.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Thread in Device Driver
References: <41B03BB2.90802@globaledgesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2004 15:27:07.0921 (UTC) FILETIME=[8CFAE010:01C4D94C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might try adding a "yield()" in the loop, perhaps modulo some number of
interrupts handled (assuming, of course, your interrupts are queued).

yield() will place the current task at the 'end' of the run list and 
schedule().  If another task is
eligible to execute, it will get the slice.  

-PWM



Kiran Kumar Gaitonde wrote:

> Hi all.
>
> I am working on a device driver with the device interrupts are 
> actaully serviced in a kernel thread and not in the interrupt handler 
> registered with the kernel. The interrupt handler justs wakes up the 
> kthread when a interrupt occurs. This is done as we need to use 
> semaphores while performing IO to sync the read and writes.
> Now I have come across a situation where the kthread is consuming 70% 
> of CPU time as it is in a loop to service the interrupts happening 
> very very fast, and it is rearly saying schedule(). The performance of 
> the application which uses this device to communicate, is not good as 
> it is not getting CPU at the right time.
>
> Can anybody tell me what may be the problem. Also any suggestions to 
> overcome this issue?
>
> Thanks in Advance,
>
> Regards,
> Kiran Gaitonde.
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Peter W. Morreale                            email: morreale@radiantdata.com
Director of Engineering                      Niwot, Colorado, USA
Radiant Data Corporation                     voice: (303) 652-0870 x108 
-----------------------------------------------------------------------------
This transmission may contain information that is privileged, confidential
and/or exempt from disclosure under applicable law. If you are not the
intended recipient, you are hereby notified that any disclosure, copying,
distribution, or use of the information contained herein (including any
reliance thereon) is STRICTLY PROHIBITED. If you received this transmission
in error, please immediately contact the sender and destroy the material in
its entirety, whether in electronic or hard copy format. Thank you.



