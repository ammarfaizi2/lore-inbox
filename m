Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264691AbUEEPUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbUEEPUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbUEEPUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:20:00 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:21264 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264691AbUEEPT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:19:57 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
	<408D65A7.7060207@nortelnetworks.com>
	<s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com>
	<s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com>
	<s5ghduvdg1u.fsf@patl=users.sf.net> <20040504223550.GA32155@kroah.com>
	<s5gy8o7bnhv.fsf@patl=users.sf.net> <20040505025602.GA19873@kroah.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gpt9jexwg.fsf@patl=users.sf.net>
Date: 05 May 2004 11:19:56 -0400
In-Reply-To: <20040505025602.GA19873@kroah.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> That is such an obvious troll and flame bait, I really do not know
> why I am responding.  Please, try to be civil here.

I was out of line, and I apologize.

I do not mean to be uncivil.  I do think this is a design flaw in
Linux, but I do not intend any personal attack.

> But before you try to do that (which basically is moving things back
> to the way things used to be years ago in 2.2), why don't you try to
> state the problem you are having.  Perhaps it can be solved in a
> different manner than what you are trying to do.

What I want is to load a driver and not proceed until it has finished
loading, which I am told "does not fit into the way the kernel handles
drivers anymore".  This strikes me as a clear misdesign.

> So, what are you trying to fix/solve/monitor/do here?

I have a custom Linux boot disk for my project
(http://unattended.sourceforge.net/).  I want it to work unaltered on
as many different systems as possible.  The boot disk can be
interactive or non-interactive, depending on how the system is
configured.  Early on, it issues a prompt "Override boot disk
defaults?", which defaults to "no" after a ten-second timeout.

So, first, I want to load the driver for the keyboard, if any.  I want
to wait until the keyboard is ready before I emit any prompts.  Under
no circumstances do I want to wait forever.

This is just one example.  I have now had essentially the same problem
three different times:

  1) Loading hid.o to talk to the keyboard, as described.

  2) Running cardmgr to probe for PCMCIA devices.  Unless I delay a
     few seconds, sometimes cardmgr finds zero PCMCIA sockets,
     presumably because the yenta_socket.o driver takes a while to get
     ready.  I say "sometimes" because this behavior, and the delay
     required, varies from system to system and from boot to boot.

  3) When I load the network driver, I want to wait until it is ready
     to use.  Otherwise, when I try to obtain a DHCP lease, sometimes
     it fails.

Right now, I deal with (2) by sleeping for a bit before running
cardmgr.  I have increased my sleep time in response to bug reports
from my users.  (Obviously, I want the delay to be as short as
possible.)

I deal with (3) by re-trying DHCP for fifteen seconds or so.  I can
tell when it failed to get a lease, but I cannot easily tell why it
failed.  So I just retry for a while before moving on to the next
interface.

In all of these cases, I am hacking around an apparent design flaw in
the kernel's device loading architecture.  Obviously, random delays
are inherently unreliable; hence my comment about "unreliable by
design".

 - Pat
