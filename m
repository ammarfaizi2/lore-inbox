Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVEMXWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVEMXWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVEMXWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:22:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52879 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262455AbVEMXVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:21:53 -0400
Message-ID: <42853687.1050402@pobox.com>
Date: Fri, 13 May 2005 19:21:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc/patch] libata -- port configurable delays
References: <20050513185850.GA5777@kvack.org> <1116019231.26693.499.camel@localhost.localdomain>
In-Reply-To: <1116019231.26693.499.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-05-13 at 19:58, Benjamin LaHaise wrote:
> 
>>is available at http://www.kvack.org/~bcrl/simple-aio-min_nr.c).  
>>Before this patch __delay() is the number one entry in oprofile 
>>results for this workload.  Does this look like a reasonable approach 
>>for chipsets that aren't completely braindead?  Cheers,
> 
> 
> If your chipset implements the 400nS lockout in hardware it certainly
> seems to make sense. Nice to know someone has put it in hardware

No, it's just mostly irrelevant under SATA.

Under SATA you are -not- talking to a device when you touch 
Status/AltStatus, you are talking to the host controller.  Specifically, 
you're talking to a controller buffer that stores a copy of the ATA 
shadow registers.

The ATA registers are transmitted to the device in a single packet, 
called a FIS, when the Command or Device Control register is written.

When the device updates its status, or completes a command, it sends a 
FIS from device to controller, instructing the controller to update its 
cached copy of the Status register.

You're bitbanging a buffer, in SATA.

	Jeff


