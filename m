Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbTCNXwC>; Fri, 14 Mar 2003 18:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbTCNXwC>; Fri, 14 Mar 2003 18:52:02 -0500
Received: from h-64-105-35-119.SNVACAID.covad.net ([64.105.35.119]:46475 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261283AbTCNXwB>; Fri, 14 Mar 2003 18:52:01 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Mar 2003 16:02:38 -0800
Message-Id: <200303150002.QAA01487@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: devfs + PCI serial card = no extra serial ports
Cc: driver@jpl.nasa.gov, dwmw2@infradead.org, EdV@macrolink.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Russell King wrote:
>On Fri, Mar 14, 2003 at 12:28:47PM -0800, Adam J. Richter wrote:
>> There was tangential mention in that thread
>> of a "/proc/serialdev" interface, but nobody really identified any
>> real benefit to it over the existing "uart: unknown" system.

>There is one benefit, which would be to get rid of some of the yucky
>mess we currently have surrounding the implementation of stuff which
>changes the port base address/irq.

>Currently, we have to check that we're the only user, shutdown, tweak
>stuff, hope it all goes to plan, and start stuff back up again.  If
>something fails, we have to pray we can go back to the original setup
>without stuff breaking.  If that fails, we mark the port "unknown".

>All of this would be a lot simpler if we didn't have the port actually
>open at the time we change these parameters.  We could just lock the
>port against opens, check no one was using it, tweak the settings,
>and release the port.  If the changes fail, just report the failure.

	When I filter out prejudicial terminology like "yucky mess",
"pray", "just", etc., I don't see a convincing explanation of how one
approach is going to result in a lower line count, fewer branches,
smaller kernel footprint, faster execution, new capabilities or any
other relevant measure that I can think of in comparison to the
existing approach.

	As far as only one user having the port open when doing an
ioctl to define the port, it is not clear to me that a /proc-like
interface would do it in less code.  Given that you still have the
possibility of undefining serial ports on the system, the issue of
making sure that there is only one user with the port open in the case
of deletion should still be approximately the same under either
approach.  Perhaps I'm talking this to death.  Maybe if you post a
diff that is a net reduction of lines of code, that would clarify
things more easily than discussing it further before that point.

	Anyhow, I'm not involved in serial driver development.  I
just think that if we try to avoid prejudicial language, we're more
likely to make more better decisions by whatever measures we agree on
(or expose differences in what is "better" in different contexts).  I
know it's a pain to do and I'm not trying to create an infinitely high
standard of proof or formality.  I'm just suggesting a little more
checking of our own objectivity.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
