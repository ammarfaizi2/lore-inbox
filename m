Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUELU2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUELU2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUELU2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:28:10 -0400
Received: from web80509.mail.yahoo.com ([66.218.79.79]:19599 "HELO
	web80509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263712AbUELU1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:27:37 -0400
Message-ID: <20040512200128.84299.qmail@web80509.mail.yahoo.com>
Date: Wed, 12 May 2004 13:01:27 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: Why pass pt_regs throughout the input system?
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 12 May 2004 11:50:26 -0700 (PDT)
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > As far as multiple keyboards issue going - SysRq is a debug tool and
> > I relly do not see you hitting SysRq on the two keyboards at the very
> > same time to mess up the call traces.
> 
> Maybe to get two backtraces on two different cpus?
> Be creative :-)

Set CPU affinity to route IRQ to a specific CPU? :)

> 
> > Anyway, my "problem" is the following: SysRq register dump and call
> > trace require keyboard.c event handler to be caled from hard interrupt
> > context which is not always feasible.
> 
> USB handles this fine, and I seem to remember it does use tasklets.
> You can save the pt_regs value at hardware interrupt and pass that
> in during the tasklet run perhaps?

I looked through the USB and unless I miss something it does not use
tasklets there. Also, even if I save the registers in IRQ context and
pass it to tasklet I do not see how I can reconstruct the call trace -
tasklet execution can be passed to ksoftirqd and executed with
completely different stack. The output would lie horribly.

Also, while I was looking at USB implementation - it also drags pt_regs
pointer everywhere for SysRq handling only and no other benefits. The
data is foreign and unneeded for both input and USB systems.

What is the objection to printing the trace at do_IRQ time and having
SysRq merely post a request instead of executing it?

Thank you,

Dmitry

