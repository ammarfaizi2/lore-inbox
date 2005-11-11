Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKKCMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKKCMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 21:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVKKCMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 21:12:34 -0500
Received: from ns.suse.de ([195.135.220.2]:27587 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750757AbVKKCMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 21:12:34 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Date: Fri, 11 Nov 2005 03:12:15 +0100
User-Agent: KMail/1.8
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <200511101419.03838.ak@suse.de> <437365EF.76F0.0078.0@novell.com>
In-Reply-To: <437365EF.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110312.15616.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 15:23, Jan Beulich wrote:

>
> >Please remove the ifdefs too.  64bit HPET support would be fine, but
> >only as a runtime mechanism, not compile time.
>
> This I added only for the purpose of not affecting existing code in
> existing configurations. If the code is generally acceptable, then I'll be
> more than happy to convert it.

We can't use 64bit HPET everywhere because quite some chipsets only
support 32bit HPET. So it has to be a runtime switch depending on the 
capabilities of the hardware.

>
> >Can you remove debugger_jiffies please?
> >The code has to handle long delays anyways (e.g. if someone uses a target
> >probe), so we cannot rely on such hacks anyways.
>
> As above, I introduced this only to not affect existing code. If the added
> latency is no problem, then of course only the overflow safe code path
> should be kept, and then debugger_jiffies is completely unnecessary.

Hmm - didn't notice anything particularly slow. Or what were you thinking 
about regarding the latency? And it should only run at each timer interrupt,
so it isn't a fast path. So I guess it's best to run it always.

-Andi
