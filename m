Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVKCClQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVKCClQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKCClQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:41:16 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:59579 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1030279AbVKCClP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:41:15 -0500
Message-ID: <42702.192.168.0.12.1130985661.squirrel@192.168.0.2>
In-Reply-To: <20051102134452.GA4778@flint.arm.linux.org.uk>
References: <20051102132145.GA14946@elf.ucw.cz>
    <20051102134452.GA4778@flint.arm.linux.org.uk>
Date: Wed, 2 Nov 2005 20:41:01 -0600 (CST)
Subject: Re: [patch, rfc] LEDs support for collie
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>,
       rpurdie@rpsys.net, "kernel list" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, November 2, 2005 7:44 am, Russell King said:
> On Wed, Nov 02, 2005 at 02:21:45PM +0100, Pavel Machek wrote:
>> This adds support for controlling LEDs on sharp zaurus sl-5500. It may
>> look a little bit complex, but it probably needs to be complex --
>> blinking is pretty much mandatory when you only have two leds, and we
>> want to support charging led (controlled by kernel).
>
> Isn't "blinking" a kind of policy, as is brightness (== duty cycle of
> a high speed toggling)?  What if someone wants synchronised toggling?
>
> I still think anything over a very simple interface being exported to
> userspace is completely overkill and completely bloated.  Hell, I got
> laughed at for creating an abstracted LEDs interface in the first
> place because many thought the current version was far too bloated.

I can strip out the timer stuff.... without the frequency stuff the patch
is  an interface that allows userspace and other kernel code to adjust the
color and brightness of leds.

Then Richard can implement his triggers code, which uses the exported
in-kernel api for controlling leds.  That triggers code can do whatever,
including blink the led on a frequency.  (And the discussion of the
triggers stuff can continue unrelated to this basic led framework).

Now that I think about it more, the frequency stuff should really be
ripped out of the led code and put somewhere else (like either userspace
or some other triggers code).

>
> I _know_ people have issues with the current interface, whinging that
> "it only exports the colour" but that's something which is actually
> very trivially solvable and therefore _not_ a major problem to solve.
>

I believe it is already solved this using my patch ignoring the frequency....

John


