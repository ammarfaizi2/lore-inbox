Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWEKNyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWEKNyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWEKNyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:54:07 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:30178 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751773AbWEKNyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:54:05 -0400
Date: Thu, 11 May 2006 09:53:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
In-Reply-To: <44633B78.8080907@compro.net>
Message-ID: <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com>
 <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net>
 <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com> <446335EA.3000506@compro.net>
 <Pine.LNX.4.58.0605110913220.6863@gandalf.stny.rr.com> <44633B78.8080907@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, Mark Hounschell wrote:

You can also try just

# echo t > /proc/sysrq-trigger

> dmesg only shows the BUGs. I have nothing connect to my serial port. I
> certainly can if I need to.

Sometimes a serial capture is easier to log, but you don't really need to
do it.  That's up to you.

>
> When finally the network connection closes all my threads must be in
> fairly good shape because if I simply restart the network software
> inside the emulation I'm good to go again.

Hmm, I'm starting to think that this is not really a problem with the -rt
implementation, and my earlier patch to turn off the BUG dump, is OK.

What RT prio is the network interrupt at?

What seems to be happening is that the vortex_timer is going off while the
interrupt is running.  Hence the disable_irq fails and schedules.

Perhaps the interrupt thread has been preempted by some high priority task
and causes it to lose a connection.

Yeah that task output would be helpful to see if you can get it to work.
Also can you show us the output of /proc/interrupts so we know which
threads are associated to the network card interrupt, and see where they
are.

-- Steve
