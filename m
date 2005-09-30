Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbVI3W3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbVI3W3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbVI3W3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:29:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6547 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030479AbVI3W3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:29:24 -0400
Date: Fri, 30 Sep 2005 17:29:18 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ppc64: Assorted minor EEH cleanups
Message-ID: <20050930222918.GN29826@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 07:48:00PM -0500, linas was heard to remark:
> 
> They compile but (ahem) are not tested, 

They are now tested. They work (I had a corupted initrd yesterday).
Please apply and foward as soon as possible.

During testing I found two unrelated bugs; wasn't able to squeeze out
patches for today; maybe monday.

Paul, these are:
1) You added an eeh_capable flag that is never initialized, and so 
   this blocks operation. I don't think this flag is needed, as it 
   duplicates a bitflag in eeh_mode. (Unless your plan is to use 
   bitfields; do you want to use C language bitfields?)

2) PCI hotplug is broken because the flag phb->is_dynamic is never 
   set to one.  As a result, hotplug add calls __alloc_bootmem 
   instead of kmalloc(), and crashes. I was testing a potential 
   patch just now, but the clock ran out.

--linas

p.s. I hope to spit out the rest of the patces, including the kthread
handling, early next week. I've got things mostly ported, and am
testing.  Let me know how to best coordinate on this.


