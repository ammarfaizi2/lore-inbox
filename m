Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWEZXml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWEZXml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWEZXml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:42:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:10208 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964866AbWEZXmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:42:40 -0400
Message-ID: <4477926D.7070308@pobox.com>
Date: Fri, 26 May 2006 19:42:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-ide-owner@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
 libata issue
References: <44775614.5000401@rtr.ca> <200605261544.46992.liml@rtr.ca>
In-Reply-To: <200605261544.46992.liml@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
>> My ata_piix based Notebook (Dell i9300) suspends/resumes perfectly (RAM 
>> or disk)
>> with 2.6.16.xx kernels, but fails resume on 2.6.17-rc5-git1 (the first 
>> 2.6.17-*
>> I've attempted on this machine).
>>
>> On resume from RAM, after a 30-second-ish timeout, the screen comes on
>> but the hard disk is NOT accessible.  "dmesg" in an already-open window
>> shows this (typed in from handwritten notes):
>>
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
> ...
> 
> Ahh.. the fix for this was posted earlier today by Forrest Zhao.
> But his patch is for libata-dev, and doesn't apply as-is on 2.6.17-rc*
> 
> Here is a modified version of Forrest's original patch, for 2.6.17-rc5-git1.
> It seems to have fixed the resume issue on my machine here,
> so that things are now working as they were in the unpatched 2.6.16 kernels.
> 
> Can we get (something like) this into 2.6.17, pretty please?

Definitely not.  I've repeatedly explained (and just done so again) why 
this is very wrong.  And you should know why, too, Mark ;-)

The controller resume (ata_pci_device_resume) does nothing 
controller-specific.  More importantly, the controller does not resume 
the ATA bus, and bring the ATA bus to bus-idle state.

	Jeff



