Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWH1GNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWH1GNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWH1GNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:13:06 -0400
Received: from colin.muc.de ([193.149.48.1]:6418 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751390AbWH1GNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:13:04 -0400
Date: 28 Aug 2006 08:13:02 +0200
Date: Mon, 28 Aug 2006 08:13:02 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc Perkel <marc@perkel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACurrid@nvidia.com, len.brown@intel.com
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060828061302.GA45823@muc.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <44F27C6C.30709@perkel.com> <Pine.LNX.4.64.0608272246350.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608272246350.27779@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 10:52:06PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 27 Aug 2006, Marc Perkel wrote:
> >
> > You might want to look at this bug.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=6975
> > 
> > The current kernel doesn't run on Asus Motherboards that use the new AM2 CPUs.


That sounds like a overly broad statement. How do you know
it affects all Asus boards and not just your specific BIO version?

> > Should this be addressed before 2.6.18 is finished?
> 
> Hmm. Can you verify that the system boots fine if you get rid of 
> acpi_skip_timer_override as per the hint from Prakash Punnoor?

We already should disable it on NF5 automatically. Timer override was all
broken on NF3/NF4, but apparently works on NF5 again.

But the check relies on HPET being present. Maybe Asus "forgot"
to set up the HPET table again and the test fails.

[In general Asus BIOS writers seems to have issues. They completely
broke all the MCFG tables too]

I can't say from the URL above if it's that because it's missing a complete
boot log. Marc, please add that.

Andy, I guess the timer override check just needs to be tightened to check
the specific PCI IDs of NF3/NF4 only and not rely on HPET being right. 
Do you have a list of them?

I suppose we also need a no_acpi_skip_override setup option for future
cases.


> 
> Andi? You were talking about how the 64-bit machines don't have some of 
> the cruft that the old PC's have.. It looks like they are accumulating 
> _more_ cruft than regular x86 ever had...

Just by logic it's impossible because all 64bit systems are regular
PCs too @)

Anyways, there is cruft, but it is new cruft replacing the old cruft,
so overall there is less cruft.

-Andi

