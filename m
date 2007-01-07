Return-Path: <linux-kernel-owner+w=401wt.eu-S932621AbXAGRun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbXAGRun (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbXAGRun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:50:43 -0500
Received: from fall-pradero.atl.sa.earthlink.net ([207.69.195.104]:34706 "EHLO
	fall-pradero.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932621AbXAGRum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:50:42 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 12:50:42 EST
Subject: Re: [kvm-devel] [announce] [patch] KVM paravirtualization for Linux
From: Hollis Blanchard <hollis@penguinppc.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Ingo Molnar <mingo@elte.hu>, kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <45A0E586.50806@qumranet.com>
References: <20070105215223.GA5361@elte.hu>  <45A0E586.50806@qumranet.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 11:42:38 -0600
Message-Id: <1168191758.27340.11.camel@diesel>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 14:20 +0200, Avi Kivity wrote:
> 
> 
> Well, you did say it was ad-hoc.  For reference, this is how I see the
> hypercall API:
[snip]
> - Guest/host communications is by guest physical addressed, as the 
> virtual->physical translation is much cheaper on the guest (__pa() vs
> a page table walk). 

Strongly agreed. One of the major problems we had with the PowerPC Xen
port was that Xen passes virtual addresses (even userspace virtual
addresses!) to the hypervisor. Performing a MMU search on PowerPC is far
more convoluted than x86's table walk and is not feasible in software.

I'm anxious to avoid the same mistake wherever possible.

Of course, even with physical addresses, data structures that straddle
page boundaries prevent the hypervisor from mapping contiguous physical
pages to discontiguous machine pages (or whatever terminology you want
to use).

IBM's Power Hypervisor passes hypercall data in registers most of the
time. In the places it communicates via memory, I believe the parameter
is actually a physical frame number, and the size is explicitly limited
to one page.

-Hollis

