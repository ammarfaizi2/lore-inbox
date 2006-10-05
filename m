Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWJEXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWJEXgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWJEXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:36:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38537 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751465AbWJEXgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:36:31 -0400
Message-ID: <452596F9.3010107@garzik.org>
Date: Thu, 05 Oct 2006 19:36:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
References: <200610051910.25418.ak@suse.de> <452564B9.4010209@garzik.org> <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org> <200610060052.46538.ak@suse.de> <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> If we had the
> 
> 	void __iomem *cfg = mmiocfg_remap(dev);
> 
> interface, we could (fairly easily) blacklist known-bad motherboards if we 
> needed to, and also, it would allow drivers to check whether mmiocfg is 
> available. It's possible that some drivers might want it if it exists, but 
> it wouldn't necessarily be somethign that they _require_, so they could 
> gracefully handle the case of getting a NULL config space handle back.
> 
> For example, for some devices, maybe they'd lose some error handling 
> capability, but they'd still be able to work otherwise.

Ugh.  Large PCI config space is going to be the norm real soon.  That 
will just nasty up drivers.


> We _can_ do the same thing with checking the error return value from 
> "pci_read_config_xxxx()", and use the "use different access method if the 
> index is >= 256", but I have to say, that just makes my gag reflex 
> trigger. Having the same function just silently do two different things 
> depending on the offset just sounds like a recipe for disaster.

Agreed.


> I dunno. I'm not likely to care _that_ deeply about this all, but I do 
> think that machines that hang on device discovery is just about the worst 
> possible thing, so I'd much rather have ten machines that can't use their 
> very rare devices without some explicit kernel command line than have even 
> _one_ machine that just hangs because MMIOCFG is buggered.
> 
> (And we should probably have the "pci=mmiocfg" kernel command line entry 
> that forces MMIOCFG regardless of any e820 issues, even for normal 
> accesses).

Agreed.

	Jeff


