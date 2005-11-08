Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVKHPQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVKHPQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVKHPQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:16:42 -0500
Received: from terminus.zytor.com ([192.83.249.54]:42175 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030187AbVKHPQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:16:42 -0500
Message-ID: <4370C141.6010508@zytor.com>
Date: Tue, 08 Nov 2005 07:16:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/21] i386 Broken bios common
References: <200511080422.jA84MQxK009859@zach-dev.vmware.com> <Pine.LNX.4.64.0511080703530.3247@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511080703530.3247@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 7 Nov 2005, Zachary Amsden wrote:
> 
>>Both the APM BIOS and PnP BIOS code use a segment hack to simulate real
>>mode selector 0x40 (which points to the BIOS data area at 0x00400 in
>>real mode).  Several broken BIOSen use selector 0x40 as if they were
>>running in real mode, which we make work by faking up selector 0x40 in
>>the GDT to point to physical memory starting at 0x400.  We limit the
>>access to the remainder of this physical page using a byte granular
>>limit.  Rather than have this tricky code in multiple places, it makes
>>sense to define it in one place, and the GDT makes a very convenient
>>place for it.  Use GDT entry 4 as the BAD_BIOS_CACHE segment.
> 
> I'd much rather use entry 8 instead, which should just automatically mean 
> that selector 0x40 _always_ points to virtual address 0x400. No switching 
> etc..
> 
> Isn't this what Wine already has to work around, or something?
> 
> Ingo, can we move the TLS selectors upwards, or does user space perhaps 
> know about the current TLS layout? Wine in particular may well know ;(
> 

I thought the point was that Wine needs to point GDT entry 8 into userspace.

	-hpa
