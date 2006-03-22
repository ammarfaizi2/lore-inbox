Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWCVSJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWCVSJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWCVSJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:09:01 -0500
Received: from ns1.suse.de ([195.135.220.2]:53692 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932268AbWCVSJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:09:01 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [Xen-devel] Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling =?utf-8?q?on=09Xen=2E?=
Date: Wed, 22 Mar 2006 18:36:23 +0100
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
References: <20060322063040.960068000@sorel.sous-sol.org> <200603221530.51644.ak@suse.de> <44218E9C.3060102@vmware.com>
In-Reply-To: <44218E9C.3060102@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221836.24295.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 18:51, Zachary Amsden wrote:

> 
> Yes, trapping works fine.  Even LLDT is infrequent. 

Not when you use old style LinuxThreads which use the LDT for TLS.

> No.  First, you have to create a special #GP handler for the general 
> protection fault.  

[... etc ...]

Sure but Xen already has the infrastructure for all of this and last
time I checked it was approaching and exceeding the size of the main
core kernel so a bit more of instruction emulation probably wouldn't 
do too much harm. 

In general I think any x86 hypervisor that attempts to work 
on current platforms needs instruction emulation because it is 
the only way to virtualize IO devices.

If this was supposed to be a interface for lots of hypervisors then maybe,
but so far it seems to only cover Xen and possibly some other bloatware 
ones.

That said I don't feel very strongly about emulating these instructions
or not as long as they can do that without too much code duplication.
The current patch are still a bit too excessive on the duplication front.

-Andi
