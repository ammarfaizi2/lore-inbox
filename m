Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270183AbRHGKvX>; Tue, 7 Aug 2001 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270181AbRHGKvK>; Tue, 7 Aug 2001 06:51:10 -0400
Received: from customers.imt.ru ([212.16.0.33]:10245 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S270182AbRHGKux>;
	Tue, 7 Aug 2001 06:50:53 -0400
Message-ID: <20010807034620.B10193@saw.sw.com.sg>
Date: Tue, 7 Aug 2001 03:46:20 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Colin Walters <walters@cis.ohio-state.edu>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <87elqs2wbx.church.of.emacs@space-ghost.verbum.org> <20010806022727.A25793@saw.sw.com.sg> <873d75janh.church.of.emacs@space-ghost.verbum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <873d75janh.church.of.emacs@space-ghost.verbum.org>; from "Colin Walters" on Mon, Aug 06, 2001 at 02:39:14PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 02:39:14PM -0400, Colin Walters wrote:
> 
> > In short, that patch isn't a real solution.  If someone provides me
> > with the information which commands times-out and how much time they
> > really need, we could have a real solution.
> 
> How can I help?  Instrument the code by hand with printk statements?
> Or is there a better way?

I would do it by just printk.
The first round is to check how many `udelay(1)' loops are necessary to get
an ack for longest commands (and what that commands are).

Then it's interesting to know how long the wait_for_cmd_done loop has been
executed when it times out.
Not in loop counter, of course, but in clock time.
It can be measured by CPU cycle counter.

This way we check how much time a command may need and whether the timeout in
the loop works as expected.

Another possibility is that the new chip revisions have some unknown timing
constraints, like requirements for delays between certain commands or register
accesses.  Those `udelay(1)', executed after every command, may provide such
delays as a side effect.
It's not clear what the easiest way to check it is.

Best regards
		Andrey
