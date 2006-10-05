Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWJERx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWJERx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWJERx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:53:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:38368 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750904AbWJERx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:53:28 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 19:53:23 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610051931.23884.ak@suse.de> <4525445C.6060901@garzik.org>
In-Reply-To: <4525445C.6060901@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051953.23510.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 19:43, Jeff Garzik wrote:
> Andi Kleen wrote:
> > On Thursday 05 October 2006 19:17, Jeff Garzik wrote:
> > 
> >> Does this fix the following issue:
> >>
> >> PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> >> PCI: Not using MMCONFIG.
> >>
> >> 100% of my x86-64 boxes, AMD or Intel, print this message.  And 100% of 
> >> them work just fine with MMCONFIG.
> > 
> > No. 
> > 
> > But it isn't really a issue. Basically everything[1] will work fine anyways.
> > 
> > [1]  Only thing you're missing AFAIK is PCI Extended Error Reporting.
> 
> Not really true, I have some cards which have >256 bytes of config space.

Yes for advanced error handling (which we only support in a few drivers
right now) I'm not aware of any card that uses it for anything else. Do you 
have evidence of that?

> >> I think this rule is far too drastic for real life.
> > 
> > If you have a better proposal please share. I tried a few others, but none
> > of them could handle all the buggy Intel 9x5 boards that hang on any
> > mmconfig access (so the "try the first few busses" check already hangs)
> > 
> > Originally I thought
> > DMI blacklisting would work, but it's on too many systems for that
> > (and Linus rightfully hated it anyways). ACPI checks also didn't work.
> > I don't know of any others.
> 
> It's a bit disappointing, since I keep getting brand new boxes with 
> brand new BIOSen, but keep hitting this rule.

A lot of new boxes are actually buggy due to a common Intel reference
BIOS bug. There are also a couple of other quirks there.

I suppose it'll only become better once Windows starts using MCFG.
 
> My proposal is quite simple:  "something that works" -- the current 
> solution obviously does not.

If you have a patch that works with all known BIOS bugs (including Mac Mini,
a random Intel 975 board and a Asus AMD K8 board with PCI Express) please share it.

-Andi
