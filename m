Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWGZQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWGZQyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWGZQyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:54:47 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28544 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030215AbWGZQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:54:46 -0400
Date: Wed, 26 Jul 2006 10:54:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-reply-to: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
To: ravibt@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44C79E56.2040603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ravibt@gmail.com wrote:
> Hello,
> 
>  On a dual core Pentium 4 EM64T machine (Intel Desktop Board D915GAV),
> we used four 1GB RAM (DDR 400) modules. The BIOS (EV91510A.86A.0444)
> detected all the four 1 GB modules, but once the OS is booted, only
> ~3.1GB is available for usage (from dmesg: "Memory: 3210516k/3267772k
> available"; see below). The kernel used is version 2.6.9-22.ELsmp
> coming with 'CentOS release 4.2 Final'.
> [The four RAM modules have been tested OK with the 'memtest'].
> 
>  Using "mem=4096m" while booting the kernel also did not help. Searched
> through the old messages and it looks like in most of the cases
> enabling some memory-hole related option in BIOS is suggested, but in
> this case probably the BIOS is fine. Not sure if some kernel
> configuration option is missing or if someother version of the kernel
> needs to be used.
> 
> This being a 64 bit machine, we expected memory-remap to be happening.
> Is there a way in which ~900 MB of RAM can be made usable?
> Any pointers will be of great help.
> 
> Please let me know if more information is needed than the following
> transcripts (/proc/iomem and dmesg):

Essentially I don't think there is much you can do about this on this 
board. The memory space starting at around 3.2GB is being used by the 
memory-mapped IO regions for the PCI and PCI Express devices and 
motherboard resources and therefore "covers up" the RAM in that part of 
the address space. The solution to this is for the system to remap the 
affected memory above the 4GB mark, which is possible with Athlon 
64/Opteron CPUs and on some of the Intel server chipsets. However, I 
don't think any Intel desktop chipsets support this for some 
unfathomable reason.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

