Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVF1RS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVF1RS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVF1ROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:14:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9432 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262166AbVF1RNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:13:44 -0400
Message-ID: <42C18543.4090604@pobox.com>
Date: Tue, 28 Jun 2005 13:13:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>, Neil Horman <nhorman@redhat.com>,
       linux-kernel@vger.kernel.org, jeff.garzik@pobox.com, akpm@osdl.org
Subject: Re: [Patch] Janitorial cleanup of GET_INDEX macro in arch/i386/pci/fixup.c
References: <20050627140914.GD20880@hmsendeavour.rdu.redhat.com> <Pine.LNX.4.58.0506271516530.19755@ppc970.osdl.org> <20050627223239.GA24080@kroah.com>
In-Reply-To: <20050627223239.GA24080@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 27, 2005 at 03:19:11PM -0700, Linus Torvalds wrote:
> 
>>
>>On Mon, 27 Jun 2005, Neil Horman wrote:
>>
>>>Patch to clean up the implementation of the GET_INDEX macro in the i386 pci
>>>fixup code so that it uses the PCI_DEVFN macro, rather than re-implements it.
>>
>>This looks wrong:
>>
>>
>>>-#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + ((b) & 7))
>>>+#define GET_INDEX(a, b) PCI_DEVFN((a - PCI_DEVICE_ID_INTEL_MCH_PA),b)
>>
>>that first argument looks like it has parentheses at the wrong place, it 
>>should be
>>
>>	(a) - PCI_DEVICE_ID_INTEL_MCH_PA
>>
>>rather than
>>
>>	(a - PCI_DEVICE_ID_INTEL_MCH_PA)
>>
>>methinks.
>>
>>Other than that... Greg?
> 
> 
> I'd like to say yes, but I'll get an ack by the pci express people from
> Intel first (PCI_DEVFN masks off bits that might be needed here, don't
> really know...)  Also, this is only used for an array index, not a
> pci devfn memory access (look at how it is used in the code...)
> 
> I'll put it in my tree for now, and let it get testing, I would not
> recommend it for yours just yet.

Please let me know, as I suggested this patch to Neil.

It sure seems like the code wants a real PCI devfn, even though it is 
obviously doing a table index.

Comments?

	Jeff



