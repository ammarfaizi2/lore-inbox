Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVCNE4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVCNE4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVCNE4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:56:03 -0500
Received: from li-22.members.linode.com ([64.5.53.22]:35803 "EHLO
	www.cryptography.com") by vger.kernel.org with ESMTP
	id S261517AbVCNEzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:55:47 -0500
Message-ID: <423518E7.3030300@root.org>
Date: Sun, 13 Mar 2005 20:53:59 -0800
From: Nate Lawson <nate@root.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] IDE failure on ACPI resume
References: <1110741241.8136.46.camel@tyrosine>
In-Reply-To: <1110741241.8136.46.camel@tyrosine>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On resume, an HP nc6220 fails during resuming of the IDE devices. In
> this section of code from ide-iops.c:
> 
>                 stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
>                 if ((stat & BUSY_STAT) == 0)
>                         return 0;
>                 /*
>                  * Assume a value of 0xff means nothing is connected to
>                  * the interface and it doesn't implement the pull-down
>                  * resistor on D7.
>                  */
>                 if (stat == 0xff)
>                         return -ENODEV;
> 
> 0xff is read and ENODEV returned. This results in

Sounds like PCI not being completely restored.  We had to work around 
some weird ATA issues in FreeBSD with the status register being invalid 
for quite a while after resume.  A retry loop was the solution.

-- 
Nate
