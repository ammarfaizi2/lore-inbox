Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUKSW2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUKSW2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUKSW0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:26:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56248 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261657AbUKSWZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:25:56 -0500
Message-ID: <419E72EF.4010100@us.ibm.com>
Date: Fri, 19 Nov 2004 16:25:51 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com> <20041119213232.GB13259@kroah.com>
In-Reply-To: <20041119213232.GB13259@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Nov 19, 2004 at 02:23:22PM -0600, brking@us.ibm.com wrote:
> 
>>-static inline int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
>>-{
>>-	return pci_bus_read_config_byte (dev->bus, dev->devfn, where, val);
>>-}
> 
> 
> Well, as much as I despise this patch, you should at least get it
> correct :)
> 
> You need to block the pci_bus_* functions too, otherwise the parts of
> the kernel that use them will stomp all over your device, right?

I thought about that when writing up this patch, but decided against it.
I figured it was overkill and was going to make the patch more complicated
than it needed to be to solve the main problem I have seen, which is
userspace code, usually hotplug/coldplug scripts, reading config space
when an adapter is running BIST.

If you think there are usages of the pci_bus_* functions in the
kernel after the adapter device driver gets loaded, from callers other
than adapter device drivers and userspace APIs, I would have to agree
with you. I was hoping to keep this patch as simple as possible.

Having to protect the pci_bus_* functions requires a lookup in these
functions to find the pci_dev to get the saved_config_space, which
I was hoping to avoid.

Ben - do you have any concerns with this limitation for the use you have
for this set of APIs?



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

