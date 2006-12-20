Return-Path: <linux-kernel-owner+w=401wt.eu-S964876AbWLTE1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWLTE1F (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWLTE1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:27:05 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:51647 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964876AbWLTE1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:27:04 -0500
Date: Wed, 20 Dec 2006 04:26:48 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Message-ID: <20061220042648.GA19814@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191334.49760.david-b@pacbell.net> <20061220002546.GA17378@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191959.43019.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 07:59:42PM -0800, David Brownell wrote:
> On Tuesday 19 December 2006 4:25 pm, Matthew Garrett wrote:
> > 1) feature-removal-schedule.txt says that it'll be removed in July 2007. 
> > This isn't July 2007.
> 
> Which is why the functionality is still there.

Merely broken in the majority of cases...

> > 2) The functionality was disabled in 2.6.19. The addition to 
> > feature-removal-schedule.txt was in, uh, 2.6.19.
> 
> Please respond to the technical explanation I provided, and stop
> referring to the functionality ** which is still there and works **
> as being disabled.

The breakage is that devices that are happy to suspend with enabled 
interrupts can no longer be suspended from userspace. Refusing to 
suspend a single device on the basis that some other driver on the bus 
may, potentially, at some point require some suspend code to be run with 
disabled interrupts is not a sensible choice. Especially since I can't 
actually find a single driver in the kernel tree that currently uses 
this functionality.

> I can't help it if that schedule.txt patch took until 2.6.19 to get
> upstream; ISTR it was available before 2.6.18 shipped.  Maybe patches
> to that file should be accelerated, even into the stable series.

That would still not have provided anywhere near enough warning. 

> One of the missing steps in Linus' formulation there is that not all
> interfaces are equivalent in terms of support guarantee.  Bugs are
> interfaces, for example, and sometimes folk wrongly depend on them
> when they persist for a long time (like, cough, this one).

The existence of the power/state interface wasn't a bug - it was a 
deliberate decision to add it. It's the only reason the 
dpm_runtime_suspend() interface exists. It's perfectly reasonable to 
refer to it as a flawed interface, or perhaps even a buggy one. But in 
itself, it's clearly not a bug. And it's perfectly reasonable for 
userland to depend on interfaces that are deliberately exposed by the 
kernel.

> In contrast, the /sys/devices/.../power/state API has never had many
> users beyond developers trying to test their drivers (without taking
> the whole system into a low power state, which probably didn't work
> in any case), and has *always* been problematic.  And the change you
> object to doesn't "break" anything fundamental, either.  Everything
> still works.

It's used on every Ubuntu and Suse system, and the change means that 
certain functionality no longer works - it's now impossible to prevent 
my wireless hardware from drawing power when I'm not using it, for 
example. If the WE power operations were deliberately disabled, then 
that would also be a bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
