Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbTCOAno>; Fri, 14 Mar 2003 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTCOAno>; Fri, 14 Mar 2003 19:43:44 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:10256
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261288AbTCOAnm>; Fri, 14 Mar 2003 19:43:42 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DE4@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>
Cc: rmk@arm.linux.org.uk, driver@jpl.nasa.gov, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
Subject: RE: devfs + PCI serial card = no extra serial ports
Date: Fri, 14 Mar 2003 16:54:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 4:03 PM, Adam J. Richter wrote:
> On Fri, 14 Mar 2003, Russell King wrote:
> >On Fri, Mar 14, 2003 at 12:28:47PM -0800, Adam J. Richter wrote:
> >> There was tangential mention in that thread
> >> of a "/proc/serialdev" interface, but nobody really identified any
> >> real benefit to it over the existing "uart: unknown" system.
> 
> >There is one benefit, which would be to get rid of some of the yucky
> >mess we currently have surrounding the implementation of stuff which
> >changes the port base address/irq.
> 
> >Currently, we have to check that we're the only user, shutdown, tweak
> >stuff, hope it all goes to plan, and start stuff back up again.  If
> >something fails, we have to pray we can go back to the original setup
> >without stuff breaking.  If that fails, we mark the port "unknown".
> 
> >All of this would be a lot simpler if we didn't have the 
> port actually
> >open at the time we change these parameters.  We could just lock the
> >port against opens, check no one was using it, tweak the settings,
> >and release the port.  If the changes fail, just report the failure.
> 
> 	When I filter out prejudicial terminology like "yucky mess",
> "pray", "just", etc., I don't see a convincing explanation of how one
> approach is going to result in a lower line count, fewer branches,
> smaller kernel footprint, faster execution, new capabilities or any
> other relevant measure that I can think of in comparison to the
> existing approach.
> 
> [ snip ]

Hi Adam,

Oh, but he _did_ give you information about such things. You filtered out 
the real message. Allow me to expand the macros ...

yucky mess = referenced area has an unnecessarily complex control 
             structure. (more branches & code, slower ...) 

just = fundamental simplification of the algorithm. (less code and 
       branching needed because less to do, smaller, faster ...)

hope, pray = referenced area can generate complex errors that cannot 
       be handled efficiently due to architectural limitations.
       (more local error handling code and branching, bigger, slower ...)

expert opinion != prejudicial speech. 
Read it again. You'll get the hang of it  :-)

Cheers,
Ed
