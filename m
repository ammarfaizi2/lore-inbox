Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVEMXd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVEMXd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVEMXay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:30:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262647AbVEMX3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:29:49 -0400
Date: Fri, 13 May 2005 19:29:38 -0400
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@telia.com>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050513232938.GD13846@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@suse.cz>,
	Andi Kleen <ak@suse.de>, Alexander Nyberg <alexn@telia.com>,
	Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz> <20050513113023.GD15755@wotan.suse.de> <20050513195215.GC3135@elf.ucw.cz> <1116019676.6380.37.camel@mindpipe> <20050513225127.GB2016@elf.ucw.cz> <1116024993.6380.47.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116024993.6380.47.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 06:56:33PM -0400, Lee Revell wrote:
 > On Sat, 2005-05-14 at 00:51 +0200, Pavel Machek wrote:
 > > Hi!
 > > 
 > > > > > > Because it kills machine when interrupt latency gets too high?
 > > > > > > Like reading battery status using i2c...
 > > > > > 
 > > > > > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
 > > > > 
 > > > > Disagreed.
 > > > > 
 > > > > Linux is not real time OS. Perhaps some real-time constraints "may not
 > > > > spend > 100msec with interrupts disabled" would be healthy
 > > >              ^^^^
 > > > You mean "microseconds", right?  100ms will be perceived by the user as,
 > > > well, their machine freezing for 100ms...
 > > 
 > > I did mean miliseconds. IIRC current watchdog is at one second and it
 > > still triggers even in cases when operation just takes too long.
 > 
 > I thought there was an understanding that 1 ms would be the target for
 > desktop responsiveness.  So yes, disabling interrupts for more than 1ms
 > is considered a bug.
 > 
 > Why do you need to disable interrupts for 100ms to read the battery
 > status exactly?

On some unfortunate hardware, we can go away even longer whilst
the BIOS does various SMI voodoo.  It got so bad in some situations
that the maintainers of the gnome battery app lowered the frequency
at which the poll the acpi interface.

		Dave


