Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVAJQZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVAJQZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVAJQZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:25:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:43190 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262312AbVAJQZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:25:27 -0500
Message-ID: <41E2AC74.9090904@us.ibm.com>
Date: Mon, 10 Jan 2005 10:25:24 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de>
In-Reply-To: <m14qhpxo2j.fsf@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> brking@us.ibm.com writes:
> 
> 
>>Some PCI adapters (eg. ipr scsi adapters) have an exposure today in that 
>>they issue BIST to the adapter to reset the card. If, during the time
>>it takes to complete BIST, userspace attempts to access PCI config space, 
>>the host bus bridge will master abort the access since the ipr adapter 
>>does not respond on the PCI bus for a brief period of time when running BIST. 
>>On PPC64 hardware, this master abort results in the host PCI bridge
>>isolating that PCI device from the rest of the system, making the device
>>unusable until Linux is rebooted. This patch is an attempt to close that
>>exposure by introducing some blocking code in the PCI code. When blocked,
>>writes will be humored and reads will return the cached value. Ben
>>Herrenschmidt has also mentioned that he plans to use this in PPC power
>>management.
> 
> 
> I think it would be better to do this check higher level in the driver.
> IMHO pci_*_config should stay lean and fast low level functions without
> such baggage. 

The problem I am trying to solve is the userspace PCI access methods 
accessing my config space when the adapter is not able to handle such an 
access. Today these accesses bypass the device driver altogether and 
there is no way to stop them. An alternative to this patch would be to 
only do these checks for the PCI config accesses initiated from the 
various userspace mechanisms, but I'm not sure the patch would then be 
usable for what benh wanted it for. Ben?



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
