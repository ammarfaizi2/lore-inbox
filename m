Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTEDIkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 04:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTEDIkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 04:40:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40777 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263567AbTEDIkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 04:40:22 -0400
Date: Sun, 4 May 2003 04:52:49 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Calin A. Culianu" <calin@ajvar.org>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305040404300.12757-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0305040448250.24497-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 May 2003, Ingo Molnar wrote:

> > IIRC, x86 ints have the high-order byte _last_ (ie the fourth byte).
> > What's to stop someone from, say, smashing a buffer (and consequently
> > return-address) on the stack using something like {0x01, 0x01, 0x01,
> > 0x00} which is really address '65793' in base-10.  The above is a valid
> > ASCII string (3 1's followed by a NUL) which could conceivably end up on
> > the stack as the result of an errant strcpy() or gets() or whatever...
> 
> you are right, it is possible to use the enclosing \0 to generate an
> address into the first 16MB, but how do you get any arguments passed to
> that function?

ie. if the binary anywhere has code that does:

	system("/bin/sh")

then this address can be jumped to and an exploit becomes possible. Also,
in the case of non-ASCII overflows the attacker has a much higher degree
of freedom to create a proper stackframe.

wrt. address-space randomization, "prelink -R" already provides quite good
randomization of the shared library addresses, which should give some
statistical protection against remote attacks, i dont think we'll need
kernel support for that.

	Ingo

