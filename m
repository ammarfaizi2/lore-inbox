Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUJFUVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUJFUVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUJFUUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:20:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52947 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269448AbUJFUMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:12:15 -0400
Message-ID: <41645150.6020608@sgi.com>
Date: Wed, 06 Oct 2004 15:10:56 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <iod00d@hp.com>
CC: Colin Ngam <cngam@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41641007.5020702@sgi.com> <20041006185739.GA25773@cup.hp.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com>
In-Reply-To: <20041006195424.GF25773@cup.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> Colin,
> thanks for ACKing the feedback.
> I think there is still some confusion...
> 
> On Wed, Oct 06, 2004 at 02:09:54PM -0500, Colin Ngam wrote:
> ...
> 
>>>Mathew explained replacing the raw_pci_ops pointer is the Right Thing
>>>and I suspect it's easier to properly implement.
>>
>>I believe we did just that.  We did not touch pci_root_ops.
> 
> 
> Correct. The patch ignores/overides pci_root_ops with sn_pci_root_ops
> (which is what I originally suggested).
> 
> Mathew's point was only raw_pci_ops needs to point at a different
> set of struct pci_raw_ops (see include/linux/pci.h).
> 
> 
>>>  I realize that's not easy to add/maintain in the arch/ia64 port though
>>>  since pcibios_fixup_bus() is common code for multiple platforms.
>>
>>Yes, would anybody allow us to make a platform specific callout
>>from within generic pcibios_fixup_bus()???
> 
> 
> If it can be avoided, preferably not. But that's up to Jesse/Tony I think.
> 
> ...
> 
>>>  It means we are telling PCI subsystem to walk root busses that don't
>>>  exist in all configurations. I hope there are no nasty side effects
>>>  from that.
>>
>>Not at all.  If you look at the loop, sn_pci_fixup_bus(0 gets called for 0 -
>>PCI_BUSES_TO_SCAN but if the bus does not exist,
> 
> 
> Can you quote the bit of the patch which implements "if the bus does not
> exist" check?
> I can't find it.
> 
> 
>>One favour.  Would you agree to letting this patch be included by Tony
>>and we will come up with another patch to fix the 2 obvious items listed
>>above?  It will be great to avoid spinning this big patch.
> 
> 
> I think that's up to Jesse/Tony.
> I don't "own" any of the code in question.
> Just trying to undo the confusion I caused.
> 
> grant

I don't plan on respinning the large patches (unless of course they get out of date). It would be 
great to get the kill, add and qla patch in so we can move forward and address some these other 
smaller issues - rather than holding up the larger mods for them.

-- Pat
