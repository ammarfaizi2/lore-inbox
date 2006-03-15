Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752182AbWCPAAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbWCPAAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWCPAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:00:19 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:38413 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752184AbWCPAAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:00:17 -0500
Message-ID: <4418AA64.7030306@vmware.com>
Date: Wed, 15 Mar 2006 15:59:32 -0800
From: Dan Hecht <dhecht@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 24/24] i386 Vmi no idle hz
References: <200603131817.k2DIHkMa005792@zach-dev.vmware.com> <20060315233128.GD1919@elf.ucw.cz>
In-Reply-To: <20060315233128.GD1919@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2006 23:59:32.0762 (UTC) FILETIME=[813E8FA0:01C6488C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> When a VCPU enters its idle loop, it disables its periodic
>> alarm and sets up a one shot alarm for the next time event.
>> That way, it does not become ready to run just to service
>> the periodic alarm interrupt. Instead, it can remain halted
>> until there is some real work pending for it.  This allows
>> the hypervisor to use the physical resources more
>> effectively since idle VCPUs will have lower overhead.
> 
> Does this NO_IDLE_HZ work only on VMI-enabled runs or globally? We are
> trying to get NO_IDLE_HZ working to save some power on notebooks; how
> is it related to this?
> 

The NO_IDLE_HZ implementation provided here is enabled when the 
VMI-Timer device is used as the timer interrupt source.  The VMI-Timer 
device is only present on paravirtual hardware.

However, the hooks introduced into the kernel (stop_hz_timer, 
restart_hz_timer) with these patches will be approximately the same 
(perhaps a subset) for implementing NO_IDLE_HZ on systems that use other 
interrupt sources.

> Can you use NO_IDLE_HZ patches that are already floating around?
> 

Certainly we plan to merge our NO_IDLE_HZ implementation with those 
patches once they are stabilized in the kernel.  Presently, they seem to 
be too fast of a moving target to be worth merging at this point, 
though.  Additionally, the VMI-Timer NO_IDLE_HZ implementation does not 
need all the machinery provided with the NO_IDLE_HZ patches that are 
floating around because the VMI-Timer code does not track time by 
counting interrupts.  This leads to a fairly simplistic NO_IDLE_HZ 
implementation.

Dan
