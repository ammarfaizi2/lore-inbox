Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVFJK1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVFJK1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVFJK1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:27:36 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32493 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262541AbVFJK1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:27:10 -0400
Message-ID: <42A96BC0.9000505@jp.fujitsu.com>
Date: Fri, 10 Jun 2005 19:30:24 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com> <20050609171332.GC24611@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050609171332.GC24611@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
>>Today's patch is 3rd one - iochk_clear/read() interface.
>>- This also adds pair-interface, but not to sandwich only readX().
>>  Depends on platform, starting with ioreadX(), inX(), writeX()
>>  if possible... and so on could be target of error checking.
> 
> It makes sense to sandwich other kinds of device accesses.  I don't
> think the previous clear/read_pci_errors() interface was intended *only*
> to sandwich readX().

At least there was _me_ who actually intended that... :-p
Thank you for being so understanding.

>>- Additionally adds special token - abstract "iocookie" structure
>>  to control/identifies/manage I/Os, by passing it to OS.
>>  Actual type of "iocookie" could be arch-specific. Device drivers
>>  could use the iocookie structure without knowing its detail.
> 
> I'm not sure we need this.  Surely it can be deduced from the pci_dev or
> struct device?

Once I prepared a cookie per a device, added it into pci_dev.
But one of our NIC driver folks pointed out that it was hard to handle
because there could be many contexts/threads riding on one device at same
time. So I reconsidered it and now come to "a cookie per a context" style.

>>            *buf++ = ioread32(dev, ofs);
> 
> You do know that ioread32() doesn't take a pci_dev, right?  I hope you
> weren't counting on that for the rest of your implementation.

Oops. It's just my typo. Please ignore it.

Thanks,
H.Seto

