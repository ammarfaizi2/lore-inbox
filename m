Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135950AbRDZV4w>; Thu, 26 Apr 2001 17:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135952AbRDZV4n>; Thu, 26 Apr 2001 17:56:43 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:7910 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S135950AbRDZV4k>; Thu, 26 Apr 2001 17:56:40 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDD9F@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: "'John Fremlin'" <chief@bandits.org>,
        "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
Date: Wed, 18 Apr 2001 15:52:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David S. Miller [mailto:davem@redhat.com]
>  > IMHO an abstracted interface at this point is overengineering.
> 
> ACPI is the epitome of overengineering.

Hi David,

I definitely set myself up for that one. ;-) And, you're not wrong. But,
let's be clear on one thing, there are two interfaces under consideration:
1) How the kernel interacts with the platform to do power
management/configuration and 2) How the OS exposes its PM interface to ring
3.

#1 is defined by ACPI and it's too late to improve it - it's the standard. I
think it's a net improvement (by getting rid of several ugly existing
interfaces like APM, pnpbios, and MPS tables) but also realize that *we have
stepped up* to implement ACPI support, a not inconsiderable effort. You may
think this is cleaning up a mess we made ourselves but there are clear,
large, advantages that ACPI-enabled systems will have over non-ACPI ones.
Windows 2000 is a great mobile OS in large part due to ACPI.

#2 was what I was referring to with the overengineering comment. Basically,
we want to put PM policy in userspace because that's where Unix puts these
things, right? We have more functionality than other PM options, therefore
we need the most elaborate PM kernel<-->user interface. My point was that we
don't even have a functional PM policy daemon at this point, so it's a
little early to start generalizing the interface, in my opinion, but a
generalized PM interface is OK, as long as it exposes at least the level of
functionality ACPI does. A generalized interface is more work, and I see no
benefit *right now*. We'll see when someone designs one, I guess.

> An abstracted interface would allow simpler systems to avoid all of
> the bloated garbage ACPI brings with it.  Sorry, Alan hit it right on
> the head, ACPI is not much more than keeping speedstep proprietary.

This is not correct. ACPI 1.0 existed before SpeedStep was even conceived
of. The 1.0 spec contains no mention of processor performance states, or
device performance states. ACPI 2.0 does, but it provides a generic
interface for the OS to control processor performance, thus commoditizing
SpeedStep-type functionality in the future.

Clear?

Regards -- Andy

