Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTJaJ5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTJaJ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:57:51 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:29886 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S263176AbTJaJ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:57:49 -0500
Message-ID: <3FA2324F.20801@metaparadigm.com>
Date: Fri, 31 Oct 2003 17:58:39 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 Fix oops in quirk_via_bridge
References: <3FA22E6F.8000404@metaparadigm.com> <20031031094946.A4556@flint.arm.linux.org.uk>
In-Reply-To: <20031031094946.A4556@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/03 17:49, Russell King wrote:
> On Fri, Oct 31, 2003 at 05:42:07PM +0800, Michael Clark wrote:
> 
>>Strangely making the quirk and its data __devinit solves the problem
>>(as is most of the other stuff in pci/quirks.c). Not sure if it is
>>the correct fix but it works for me. ie. why did I get the oops
>>in the first place? as the quirks data was global and not marked
>>for an __init section.
> 
> 
> The function was marked as __init.  I'd strongly recommend against
> marking the data with __devinitdata since its used elsewhere in the
> kernel by non-init code.

Sure, okay. So just consider my post a bug report then as i'm not
sure what the correct fix is (i'll stick with my patch so I can
continue to use firewire on my laptop in the meantime).

>>--- linux-2.6.0-test9/drivers/pci/quirks.c	2003-10-31 16:49:25.000000000 +0800
>>+++ linux-2.6.0-test9-mc/drivers/pci/quirks.c	2003-10-31 16:49:57.000000000 +0800
>>@@ -644,9 +644,9 @@
>>  *	VIA northbridges care about PCI_INTERRUPT_LINE
>>  */
>>  
>>-int interrupt_line_quirk;
>>+__devinitdata int interrupt_line_quirk;
>> 
>>-static void __init quirk_via_bridge(struct pci_dev *pdev)
>>+static void __devinit quirk_via_bridge(struct pci_dev *pdev)
>> {
>> 	if(pdev->devfn == 0)
>> 		interrupt_line_quirk = 1;
>>

