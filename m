Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVFGARZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVFGARZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVFGAOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:14:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54474 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261763AbVFFXyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:54:04 -0400
Message-ID: <42A4E213.8050102@pobox.com>
Date: Mon, 06 Jun 2005 19:53:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de> <42A4D771.7080400@pobox.com> <20050606231325.GA11610@suse.de>
In-Reply-To: <20050606231325.GA11610@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 06, 2005 at 07:08:33PM -0400, Jeff Garzik wrote:
> 
>>Greg KH wrote:
>>
>>>Why would it matter?  The driver shouldn't care if the interrupts come
>>>in via the standard interrupt way, or through MSI, right?  And if it
>>
>>It matters.
>>
>>Not only the differences DaveM mentioned, but also simply that you may 
>>assume your interrupt is not shared with anyone else.
> 
> 
> Ok, and again, how would the call, pci_in_msi_mode(struct pci_dev *dev)
> not allow for the driver to determine this?

Let me see if I understand this correctly :)

A technology (MSI) allows one to more efficiently call interrupt 
handlers, with fewer bus reads...  and you want to add a test to each 
interrupt handler -- a test which adds several bus reads to the hot path 
of every MSI driver?

We want to -decrease- the overhead involved with an interrupt, but 
pci_in_msi_mode() increases it.

	Jeff


