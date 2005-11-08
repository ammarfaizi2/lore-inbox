Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVKHMIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVKHMIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVKHMIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:08:09 -0500
Received: from tim.rpsys.net ([194.106.48.114]:28833 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964986AbVKHMIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:08:07 -0500
Subject: Re: best way to handle LEDs
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: John Lenz <lenz@cs.wisc.edu>, Ben Dooks <ben@fluff.org.uk>,
       vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051108092848.GH15730@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz>
	 <20051102024755.GA14148@home.fluff.org> <20051102095139.GB30220@elf.ucw.cz>
	 <43093.192.168.0.12.1130985101.squirrel@192.168.0.2>
	 <20051107233000.GC2034@elf.ucw.cz>
	 <52781.192.168.0.12.1131409634.squirrel@192.168.0.2>
	 <20051108092848.GH15730@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 12:07:40 +0000
Message-Id: <1131451660.8350.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 10:28 +0100, Pavel Machek wrote:

> * they are 9 users of "old" interface already, one more does not seem
> like a big deal.
> 
> * arm maintainer does not want anything more complex than "old"
> interface. And I can see his point. It is not clear if "new" interface
> will get into mainline.
> 
> * there are very little users of collie, currently. Changing LED API
> on myself does not seem like a big deal. [I'm trying hard to get _two
> more_ users :-)]
> 
> * if openembedded people do not like current interface, they should a)
> convince rmk API needs to change and b) convert all the drivers.
> 
> > Secondly, leds aren't that importent unless they are supported by the
> > userspace programs (to do things like blink when email shows up).  And
> > before the userspace starts using leds, I think they might want to clear
> > up the interface API issue first.
> 
> I'd say charger LED is somehow important, and I liked CPU usage LED a lot.

You can implement the charger LED without needing to implement any led
interface, as the sharpsl_pm charger code does. For now the charge led
is hard coded (but easily changed later to become a trigger).

My rough plan is to implement the led trigger code and present this
along with a modified version of John's sysfs class code to LKML. If
accepted, great (and there was a demand for a standard interface from
various quarters). If not, I'll offer it as a patch series outside of
the kernel as openembedded, opie, gpe and handhelds.org are likely to
use it regardless of what LKML thinks. We can then see how its usage
becomes. The only change I will ask for is that the CONFIG_LEDS
namespace as used by ARM is reconsidered.

Both John and myself have resisted putting any LED code into mainline as
we don't feel the existing interfaces match Zaurus developer's and
user's needs. To submit such patches would suggest we planned to support
the existing interfaces which we do not.

I agree with John's point about changing API's as if LED code gets
added, developers and users may start using it which we don't want to
happen until we have an API we're happy with.

Richard

