Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWBWRU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWBWRU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWBWRU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:20:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:56524 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751753AbWBWRU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:20:56 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 18:20:49 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231820.50384.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 18:08, Linus Torvalds wrote:
> 
> On Thu, 23 Feb 2006, Arjan van de Ven wrote:
> > > 
> > > I think you would first need to move the code first for that. Currently it starts
> > > at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
> > > 
> > > I wouldn't have a problem with moving the 64bit kernel to 2MB though.
> > 
> > that was easy since it's a Config entry already ;)
> 
> Btw, the "low TLB entry" for the direct-mapped case can't be used as a 
> hugetlb page anyway, due to the MMU splitting it up due to the special 
> MTRR regions, if I recall correctly.

I was to suggest the same thing originally, but on several boxes I checked
there weren't any special MTRRs < 1MB, only in the PCI memory hole
<4GB. I suspect there isn't just any interesting hardware in 640K anymore.

BTW I have been also pondering some time to really trust e820 and not
forcibly reserve 640K-1MB on 64bit.  That code was inherited from i386,
but probably never made too much sense

[I remember actually taking it out very early, but then putting
it back when I was hunting some insidious unrelated bug. But it wasn't that]

Perhaps that would be a good idea to ignore that newer i386 systems too 
(newer defined as having DMI BIOS dates >2000 or so) 

-Andi

