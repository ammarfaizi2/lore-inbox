Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUHLXWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUHLXWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbUHLXWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:22:55 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:13960 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268873AbUHLXWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:22:34 -0400
Date: Fri, 13 Aug 2004 01:21:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: Dax Kelson <dax@gurulabs.com>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040812232147.GH15138@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <1092269309.3948.57.camel@mentorng.gurulabs.com> <1092281393.7765.141.camel@dhcppc4> <20040812074002.GC29466@elf.ucw.cz> <1092320883.5021.173.camel@dhcppc4> <20040812202401.GB14556@elf.ucw.cz> <1092351080.5021.198.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092351080.5021.198.camel@dhcppc4>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > hmm, yes, but it still would be nice to properly shutdown instead of
> > fail.
> 
> The reality is that most of the critical temperature events
> are false positives, and for those that are not, the hardware
> will keep itself from burning even when the OS control fails.
> 
> If we confuse some self-supporting kernel types, that is too bad.
> If they're supporting themselves, they should read the change logs
> for the kernels that they download.  I don't think
> this is of a magnitude that it needs to wait for 2.7 to be fixed.

There's nothing to fix. It is not broken. It just does /sbin/poweroff;
that's correct.

/sbin/poweroff is there on almost all systems; that is not case with
acpid. Currently *noone* has acpid that handles critical properly,
right?

So I believe that change is bad idea. /sbin/overtemp lets user
configure it etc.

Ouch and btw I've done some torturing on one prototype (AMD). It had
thermal at 98Celsius (specs for this cpu said 95C max), and I ended my
test at 105Celsius. I do not know about TM1/TM2 etc, but in this case
hardware clearly failed to do the right thing.

I do not know why acpid should be involved in this. execing binary
seems safer to me -- acpid might have died (OOM? segfault?), and exec
does not strike me like too ugly.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
