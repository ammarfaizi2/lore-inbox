Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUKSXpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUKSXpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUKSXZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:25:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64408 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261652AbUKSXW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:22:58 -0500
Message-ID: <419E804E.2050004@us.ibm.com>
Date: Fri, 19 Nov 2004 17:22:54 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>	 <20041119213232.GB13259@kroah.com>  <419E72EF.4010100@us.ibm.com> <1100904402.3811.52.camel@gaston>
In-Reply-To: <1100904402.3811.52.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Fri, 2004-11-19 at 16:25 -0600, Brian King wrote:
> 
> 
>>I thought about that when writing up this patch, but decided against it.
>>I figured it was overkill and was going to make the patch more complicated
>>than it needed to be to solve the main problem I have seen, which is
>>userspace code, usually hotplug/coldplug scripts, reading config space
>>when an adapter is running BIST.
> 
> 
> How so ? Why would it be more complicated to do the workaround in
> drivers/pci/access.c macros instead and not touch all the wrappers ? It
> would actually make a much smaller patch...

I guess what I was having difficulty with was how to go from bus/devfn
to pci_dev in the bus macros (to access the saved_config_space) and do this
safely at interrupt level. The spinlock protecting the devices list on the
pci_bus struct is never acquired with irqsave and all the existing
functions to search for a given pci device are not callable from
interrupt context.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

