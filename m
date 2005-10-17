Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVJQX0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVJQX0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJQX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:26:45 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9361 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932374AbVJQX0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:26:45 -0400
Message-ID: <43543331.6030603@pobox.com>
Date: Mon, 17 Oct 2005 19:26:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com> <20051016005341.GB5946@plexity.net> <dj1bb5$riu$1@terminus.zytor.com>
In-Reply-To: <dj1bb5$riu$1@terminus.zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <20051016005341.GB5946@plexity.net>
> By author:    Deepak Saxena <dsaxena@plexity.net>
> In newsgroup: linux.dev.kernel
> 
>>It's a magic regsiter we just read/write and could be done in userspace.
>>I also took a look at MPC85xx and it has the same sort of interface but
>>also has an error interrupt capability. On second thought a class
>>interface is overkill b/c there will only be one RNG per system, so
>>I can just do something like watchdogs where we have a bunch of simple
>>drivers exposing the same interface. We could do it in user space but
>>then we have separate RNG implementations for  x86 and !x86 and I'd
>>rather not see that. Can we move the x86 code out to userspace and
>>just let the daemon eat the numbers directly from HW? We can mmap() 
>>PCI devices, but I don't know enough about x86 to say whether msr 
>>instructions can execute out of userspace (or if we want them to...).

> MSR instructions cannot execute out of userspace, but the MSR driver
> might be possible to use.  It's usually quite slow, however.

MSRs are used for setup, not for actual data.

Intel:  magic MMIO address (readb)
AMD:	magic PIO address (inl)
VIA:	CPU instruction ('xstore')

	Jeff


