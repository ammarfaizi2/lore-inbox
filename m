Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTKXXAB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTKXXAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:00:00 -0500
Received: from imap.gmx.net ([213.165.64.20]:42175 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261555AbTKXW6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:58:53 -0500
X-Authenticated: #20450766
Date: Mon, 24 Nov 2003 23:57:56 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Bradley Chapman <kakadu_croc@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <Pine.LNX.4.58.0311241356420.1473@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311242352160.2874-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Linus Torvalds wrote:

> On Mon, 24 Nov 2003, Guennadi Liakhovetski wrote:
> >
> > Well, FWIW, I'm getting 100% reproducible Oopses on __boot__ by enabling
> > preemption AND (almost) all kernel-hacking CONFIG_DEBUG_* options - see my
> > post of 21.11.2003 with subject "[OOPS] 2.6.0-test7 + preempt + hacking".
> > If required, could try to narrow it down to 1 CONFIG option.
>
> I'd love to have more info - I actually looked at your original report,
> and it's one of those "impossible" things as far as I can tell. The low
> bit of the work "pending" flag should acts as a lock on workqueues, and
> serialize access to one workqueue totally - so having it show up with a
> pending timer is "strange" to say the least. The only two ways to clear
> the "pending" timer is by running the work-queue - either for the timer to
> have gone off (for the delayed case) _or_ the timer not to have evern been
> set in the first place (for the immediate case).
>
> So more information would be wonderful.

I've got that Oops while testing my fix of the tmscsim driver for 2.6. It
was test7. The driver worked, except in that only configuration, where
I've got the reported Oops. I just tried a working configuration (with
preempt enabled) and enabled DEBUG_PAGEALLOC - it still worked... So,
unless it REALLY was an impossible bug, that somehow impossibly
disappeared again (the only thing I can say - I couldn't have written that
Oops by hand just out of my head...:-)) - it should really be a
combination of all those parameters. I am currently recompiling test10
with that configuration, will try test7 again, if this one doesn't
reproduce the bug, will report results tomorrow. If I get the Oops again -
will attach the complete .config.

Thanks
Guennadi
---
Guennadi Liakhovetski


