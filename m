Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJOWMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJOWMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUJOWMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:12:51 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:21937 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S261724AbUJOWMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:12:46 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Fri, 15 Oct 2004 15:12:25 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org,
       linuxconsole-dev@lists.sourceforge.net
Message-ID: <416FE8D9.18954.2984F7A@localhost>
In-reply-to: <20041015214451.GA4739@hh.idb.hist.no>
References: <416FB624.31033.1D23BE5@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:

> On Fri, Oct 15, 2004 at 11:36:04AM -0700, Kendall Bennett wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > 
> [...]
> > > Having video BOOT would be great, and please make it independent of
> > > the framebuffer drivers.  
> > 
> > Right now it is independent but I added a single line of code to the 
> > Radeon driver to init the card prior to initing the rest of the driver. 
> 
> That's fine.  What I meant, was please make it independent of the
> VESA framebuffer driver, because one might want to use an
> acellerated driver when one is available. 

Oh, it already is. The VESA driver is not actually done yet so the only 
drivers using VideoBoot right now are the accelerated ones ;-)

> > It can be done earlier than that inside fbmem.c, but I wasn't sure how to 
> > set up the code so it would only POST each card as it is needed as I 
> > don't want to bring up secondary controllers unless the user actually 
> > wants this.
> 
> Selecting which cards to "boot" can probably be done with a kernel
> parameter?  The default could be to bring up all cards except the
> one the bios brought up already.  Wanting to _not_ bring up some
> cards seems to be the unusual case to me. 

Not really. In many cases there may be a secondary controller on the 
system that is not wanted, such as when the user has an i915G or other 
chipset with integrated video but has plugged a different video card into 
the system. The integrated video can still be active so trying to bring 
it up may be problematic unless it is really wanted.

> > How does the framebuffer console system handle secondary controllers 
> > right now? It seems from my look at the code that it only brings up the 
> > primary and not the secondary?
> 
> The stock 2.6.x fbcon only use one framebuffer console.  I use the
> ruby patch which supports multiple consoles.  The ruby patch for
> 2.6.7 support multiple fbcons so you can have several keyboards
> attached to separate framebuffers thus supporting several users.
> (VT1-VT16 is the first kbd on the first fbcon, VT17-VT32 is the
> second kbd on the second fbcon, and so on.) 
> 
> The ruby patch for 2.6.8.1 is somewhat broken, and doesn't work
> with fbcon. It still support multiple keyboards and multiple
> framebuffers, so I can support several users with separate xservers
> but currently not gettys on separate fbcons. 

Cool. So this stuff is not yet in the official kernel trees. Is that 
going to happen or is the project to move the video out of the kernel 
going to happen first?

> Note that soft-booting the "extra" video card in order to support a
> framebuffer driver is nice even if it doesn't attach to the
> console, because there is other software that can utilize a
> framebuffer.  X is the most well-known of them. 

Yes, but if you don't need a framebuffer console on the card then X or 
whatever can bring up the secondary controller from user space once the 
kernel has booted.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


