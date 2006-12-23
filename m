Return-Path: <linux-kernel-owner+w=401wt.eu-S1753312AbWLWLkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbWLWLkR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbWLWLkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:40:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2685 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753312AbWLWLkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:40:15 -0500
Date: Sat, 23 Dec 2006 12:40:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20061223114015.GQ6993@stusta.de>
References: <20061220140500.GB30752@frankl.hpl.hp.com> <20061220210514.42ed08cc.akpm@osdl.org> <20061221091242.GA32601@frankl.hpl.hp.com> <20061222010641.GK6993@stusta.de> <20061222100700.GB1895@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222100700.GB1895@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 02:07:00AM -0800, Stephane Eranian wrote:
> Andrian,
> 
> On Fri, Dec 22, 2006 at 02:06:41AM +0100, Adrian Bunk wrote:
> > > changelog:
> > > 	- add a notifier mechanism to the low level idle loop. You can
> > > 	  register a callback function which gets invoked on entry and exit
> > > 	  from the low level idle loop. The low level idle loop is defined as
> > > 	  the polling loop, low-power call, or the mwait instruction. Interrupts
> > > 	  processed by the idle thread are not considered part of the low level
> > > 	  loop. The notifier can be used to measure precisely how much is spent
> > > 	  in useless execution (or low power mode). The perfmon subsystem uses it
> > > 	  to turn on/off monitoring.
> > 
> > 
> > Why is this patch not submitted as part of the perfmon patch that also 
> > adds a user of this code?
> 
> If you look at the perfmon-new-base patch, you'll see a base.diff patch which
> includes this one. I am slowly getting rid of this requirement by pushing
> those "infrastructure patches" to mainline so that the perfmon patch gets
> smaller over time. Submitting smaller patches makes it easier for maintainers
> to integrate.

No, the preferred way is to start with getting both the infrastructure 
and the users into -mm.

Adding infrastructure without users doesn't fit into the kernel 
development model.

The unused x86-64 idle notifiers are now bloating the kernel since 
nearly one year.

> > And why does it bloat the kernel with EXPORT_SYMBOL's although even your 
> > perfmon-new-base-061204 doesn't seem to add any modular user?
> 
> I have tried to stay as close as possible from the x86-64 implementation
> of this mechanism. The registration entry points are exported to modules,
> just like they are for x86-64. Also note that the x86-64 idle notifier does
> not have a user at this point, yet it is in the kernel. Perfmon will become
> the first user of this mechanism.

Where does the perfmon code use the EXPORT_SYMBOL's?

And having added bloat on one architecture is not an excuse for adding 
bloat on other architectures.

> -Stephane

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

