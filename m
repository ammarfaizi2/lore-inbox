Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbSACIrC>; Thu, 3 Jan 2002 03:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbSACIqx>; Thu, 3 Jan 2002 03:46:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:559 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284153AbSACIqg>; Thu, 3 Jan 2002 03:46:36 -0500
To: esr@thyrsus.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102151539.A14925@thyrsus.com>
	<E16LsU0-0005RB-00@the-village.bc.nu>
	<20020102154633.A15671@thyrsus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Jan 2002 01:44:21 -0700
In-Reply-To: <20020102154633.A15671@thyrsus.com>
Message-ID: <m1y9jfu8m2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > You can make an educated guess. However it is at best an educated guess.
> > The DMI tables will tell you what PCI and ISA slots are present (but
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > tend to be unreliable on older boxes).  You can also look for an ISA bridge
> > in lspci as a second source of information.
> 
> That sounds like it might be what I'm after.  My goal is to be able to probe 
> the machine and set ISA_CARDS based on the probe.  What's a DMI table and
> how can I query it for the presence of ISA slots?
> 
> What I want to do with this is make ISA-card questions invisible on modern
> PCI-only motherboards.


Auto configuration only works for some variety of Plug-and-Play hardware.
By that I mean that between a combination of the firmware and the hardware
you can detect what is there.  Plug-and-Play does not work reliably on
ISA.  Since PCI has been Plug-and-Play from the start it works well.

I would suggest you assume that for any hardware that isn't present
you assume it isn't there.

For those things where auto detection is not reliable have a menu that
let's you manually select the which pieces you actually want to worry
about sounds reasonable.

Say:
   Unprobeable hardware support
     ISA cards
     i2c devices
     lpc devices
     etc
     etc.

With the kernel moving to support more and more hardware and things
like lm-sensors showing up.  Even the absence of slots does not mean
that there aren't pieces that software can not get adequate
information to setup correctly.

As for DMI and it's ilk.  The only sane thing I can see to do is have
something that will report the motherboard id. (DMI does seem to do
that fairly reiliably, as do MP tables).  And then you build a
database based on motherboard id upon the capabilities of the various
motherboards. 

Looking up the datasheets from the various manufacturers should not be
to hard of a job..  Plus it is a technique that can work on things
other than stock PC's.

Eric
 
