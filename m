Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVFHGPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVFHGPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVFHGPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:15:37 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48336 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262111AbVFHGPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:15:30 -0400
Message-ID: <42A68CBF.6040001@pobox.com>
Date: Wed, 08 Jun 2005 02:14:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Grover <andy.grover@gmail.com>
CC: Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>	 <42A61CDE.6090906@pobox.com> <c0a09e5c05060722558a86ac8@mail.gmail.com>
In-Reply-To: <c0a09e5c05060722558a86ac8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Grover wrote:
> On 6/7/05, Jeff Garzik <jgarzik@pobox.com> wrote:
>>Also, it looks like all the PCI MSI drivers need touching for this
>>scheme -- which defeats the original intention.  At this rate, the best
>>API is the one we've already got.
> 
> 
> For now...but I'm bringing this up again in five years!! *sets egg timer*


Re-read the start of the thread :)

My suggestion...

short term:  do nothing

long term:  move drivers to a new pci_enable()/pci_disable() API which 
makes it easy for us to roll a lot of these singleton function calls, 
repeated over and over again in PCI drivers, into generic code.

Then just let evolution happen.  That way, progress occurs, but no 
existing drivers are broken by a sudden pci_enable_device() behavior change.

Since we're in a "rolling stable series" that might be a better path to 
take.  If evolution goes as expected, maybe there will no longer be any 
public users of pci_enable_msi()...

	Jeff


