Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWFOB5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWFOB5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 21:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFOB5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 21:57:19 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:6395 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964900AbWFOB5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 21:57:19 -0400
Message-ID: <4490BE76.6040008@myri.com>
Date: Wed, 14 Jun 2006 21:57:10 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because
 of e820
References: <44907A8E.1080308@myri.com> <44907B13.2030402@linux.intel.com>
In-Reply-To: <44907B13.2030402@linux.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Brice Goglin wrote:er.
>>
>> What would you think of a patch implementing the following strategy:
>> 1) if MMCONFIG works, always use it (no change)
>> 2) if MMCONFIG is disabled and we are accessing the regular config
>> space, use direct conf (no change, should ensure that any machine will
>> still boot fine)
>> 3) if MMCONFIG is disabled but we are accessing the _extended_ config
>> space, try mmconfig anyway since there's no other way to do it.
>
> an OS isn't allowed to mix old and new access methods realistically so
> I don't think
> this is a viable good solution...

Well, we are talking about using a different method to access the
extended config space only. This space is independent from the legacy
config space.
I don't see how mixing the old and new methods like this could lead to
any problem, we are not going to mix them to access the same registers.
But I agree with Andi about the possible dangerousness.

We need to improve this "mmconfig disabled" anyhow. Having the extended
config space unavailable on lots of machines is also far from a viable
solution :) If you still do not like this first proposal, what do you
think of my other one ? (having chipset-specific checks in
pci_mmcfg_init to find out for sure whether mmconfig will work)

Thanks,
Brice

