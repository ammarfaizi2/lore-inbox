Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271759AbRHRBt5>; Fri, 17 Aug 2001 21:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271763AbRHRBtr>; Fri, 17 Aug 2001 21:49:47 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:4258 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S271759AbRHRBt3>;
	Fri, 17 Aug 2001 21:49:29 -0400
Message-ID: <3B7DCB5F.1B78A6BB@randomlogic.com>
Date: Fri, 17 Aug 2001 18:56:47 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: AGP support locks X - was Re: sony vaio, crude workaround
In-Reply-To: <20010817124100.12469.qmail@web20304.mail.yahoo.com> <m3itfmrwny.fsf@coelacanth.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Papadonis wrote:
> 
> This solved the problem.  Apparently AGP has to be built as a module
> in kernels v2.4.8 or X will lock up?  Anyone else experience this?
> 
> > I'm not sure that this is the problem you are having,
> > but I had a problem with X when I was playing with the
> > ACPI stuff and recompiling the kernel on my vaio. Try
> > setting CONFIG_AGP=m (i.e. make AGP support a module,
> > as opposed to being compiled in-kernel.) if it isn't.
> > Once I did that, X started up just fine. Good luck.
> >
> > Dave
> 

I had the same problem before I fixed the NVidia driver and AMD760MP support was added to agpgart (I have a GeForce 3 card and a Tyan Thunder K7). The NVidia
driver did not work properly with the MP chipset, nor did agpgart unless the module was loaded with agp_try_unsupported=1. When compiled as a module, and not
using the afore mentioned option, agpgart simply fails to load. The NVidia driver, not detecting AGP, drops to PCI mode and everything works fine.

When agpgart was modified to support the AMD760MP chipset, I compiled it into the kernel. At that point the NVidia driver would not load because it couldn't
talk to the AGP controller (it didn't know about it), and X would fail just like you see it. I fixed it by modifying the NVidia driver to recognise the AMD760MP
chipset, and now I have 99% AGP support (Fast Write does not currently work, but I will be working with NVidia next week to get everything 100%).

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
