Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUD3Vqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUD3Vqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUD3Vqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:46:53 -0400
Received: from cpc3-cmbg4-4-0-cust78.cmbg.cable.ntl.com ([81.103.19.78]:18960
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S261563AbUD3Vqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:46:45 -0400
Message-ID: <4092CA37.2020106@thekelleys.org.uk>
Date: Fri, 30 Apr 2004 22:50:47 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Crash in atmel_cs due to fake device
References: <Pine.LNX.4.58.0404301413440.4502@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.58.0404301413440.4502@marabou.research.att.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> Hi, Simon and everybody!
> 
> Since PCMCIA devices are not devices for the kernel, atmel_cs uses a fake
> device for calling request_firmware().  The fake device has .bus_id
> initialized, but it's not enough for Linux 2.6.6-rc3.  The kernel would
> oops while trying to create a link from /sys/class/firmware/pcmcia/device
> to the location of the device in sysfs.
> 
> To work around this problem, .kobj.k_name should be defined in the fake
> device.  I know, it's ugly as hell, but I don't see a better solution
> until PCMCIA device drivers are converted to the device model.
> 
> The patch has been compile tested only, but I have tested a similar patch
> with another driver, which is not in the kernel yet (spectrum_cs).  I'm
> quite sure that atmel_cs is affected by this problem.
> 

Thanks for that: I've followed the conversation about this and is seems 
that a patch like this is the best short-term fix. I'm happy to do this 
and leave the device people to progress their final vision on their own 
time. I'll check that the patch fixes things tomorrow sometime and give 
a final  OK then.

Cheers,

Simon.


C
