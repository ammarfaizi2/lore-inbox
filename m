Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLEG3W>; Tue, 5 Dec 2000 01:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLEG3M>; Tue, 5 Dec 2000 01:29:12 -0500
Received: from main.cyclades.com ([209.128.87.2]:64261 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129524AbQLEG25>;
	Tue, 5 Dec 2000 01:28:57 -0500
Date: Mon, 4 Dec 2000 21:58:29 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
cc: Philip Blundell <philb@gnu.org>, netdev@oss.sgi.com
Subject: [RFC-2] Configuring Synchronous Interfaces in Linux
Message-ID: <Pine.LNX.4.10.10012042135090.5269-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Thanks to all of you who responded to my first RFC on this subject. The
discussion ended up going in the Ethernet direction, and I frankly don't
know whether that applies to this case, or even if it _should_ apply or
they should really be separate config. subsystems. This is another thing
that you may wanna throw your opinions on.

Anyhow, the parameters we currently need to configure on our board (the
PC300) are as follows:

- Media: V.35, RS-232, X.21, T1, E1
- Protocol: Frame Relay, (Cisco)-HDLC, PPP, X.25 (not sure whether that is
            already supported by the 'hw' option)
- Clock: 'ext' (or 0, which implies external clock) or some numeric value
         > 0 (which implies internal clock); setting it to 'int' would set
         it to some fixed numeric value > 0 (useful for T1/E1 links, just
         to indicate master clock as opposed to slave or 'ext' clock) 
- Frame Relay only: 
	- End type: DCE or DTE (maybe this applies to other interface
                    types as well)
	- DLCI: DLC number for the interface
- T1/E1 only:
	- Line code: 
	- Frame mode:
	- LBO (T1 only): line-build-out
	- Rx Sensitivity: short-haul or long-haul
	- Active channels: mask that represents the possible 24/32
                           channels (timeslots) on a T1/E1 line

I'm sure that _all_ the other sync cards need to configure the _same_
parameters (or a subset of them), and there may be cards that need even
more parameters (but we have to start somewhere ... ;). So having a
unified interface and making the drivers compliant to it is not that hard
and surely would help users to dump the currently ridiculous set of
individual config. tools for these cards (yes, we currently have our own
pc300cfg, along with the -- not absolute -- "standard" sethdlc utility).

I'm willing to go for this implementation, but I wanted to know first:
- whether ifconfig is the right place to do it;
- where I should create the new ioctl's to handle these new parameters.

Suggestions / comments are more than welcome.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
