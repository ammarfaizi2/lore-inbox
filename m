Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVHVVCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVHVVCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVHVVCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:02:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:51337 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751164AbVHVVCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:02:03 -0400
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X
	trouble.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	 <42F89F79.1060103@aitel.hist.no>
	 <200508171326.21948@bilbo.math.uni-mannheim.de>
	 <200508221001.39050@bilbo.math.uni-mannheim.de>
	 <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 07:01:05 +1000
Message-Id: <1124744465.5188.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 10:44 -0700, Linus Torvalds wrote:
> 
> On Mon, 22 Aug 2005, Rolf Eike Beer wrote:
> 
> > >It's a PII-350 with more or less SuSE 9.3. The machine has no net access, so
> > > I can only try to narrow it down to one rc at the weekend.
> > 
> > 2.6.12 works fine, everything since 2.6.13-rc1 breaks it.
> 
> Gaah. I don't see anything really obvious in that range. However, I notice
> that pci_mmap_resource() (in drivers/pci/pci-sysfs.c) now has
> 
> +       if (i >= PCI_ROM_RESOURCE)
> +               return -ENODEV;
> 
> which seems a big bogus. Why wouldn't we allow the ROM resource to be 
> mapped? I could imagine that the X server would very much like to mmap it, 
> although I don't know if modern X actually does that. The fact that it 
> works when root runs the X server and causes problems for normal users 
> does seem like there's something that root can do that users can't do, and 
> doing a mmap() on /dev/mem might be just that.
> 
> Eike, maybe you could change the ">=" to just ">" instead?
> 
> PS. The patch that introduced this was billed as "no change for anything 
> but ppc". Tssk.

X uses /dev/mem, it doesn't use sysfs nor proc on x86, though it does
use proc for config space access (and that only) on ppc. Do you have the
sha1 ID of the above change at hand btw ?

(And yes, X should/will be fixed)



