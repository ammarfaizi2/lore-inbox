Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUJXUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUJXUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUJXUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:25:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:51633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261674AbUJXUYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:24:50 -0400
Date: Sun, 24 Oct 2004 13:24:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Meyer <thomas.mey3r@arcor.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6.10-rc1] Segmentation fault in program "X"
In-Reply-To: <417BF02F.20704@arcor.de>
Message-ID: <Pine.LNX.4.58.0410241323140.13209@ppc970.osdl.org>
References: <417B6A17.8010904@arcor.de> <200410241313.31151.vda@port.imtp.ilyichevsk.odessa.ua>
 <417BF02F.20704@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Oct 2004, Thomas Meyer wrote:
> 
> Denis Vlasenko wrote:
> > On Sunday 24 October 2004 11:38, Thomas Meyer wrote:
> > 
> >>Hello.
> >>
> >>X doesn't work under 2.6.10-rc1. i'm using the framebuffer X server. 
> >>Kernel 2.6.9 works. How could that be?
> > 
> > 
> > Details?
> > --
> > vda
> > 
> > 
> 
> Hi.
> 
> Signal SIGSEGV happens while doing sys function
> "ioctl(5, FBIOBLANK <unfinished ...>"
> 
> seems to be some changes between 2.6.9 and 2.6.10-rc1 in file "fbmem.c"

Do you have radeon hardware? Is there any oops in your logs?

It definitely sounds like it's due to this one:

	ChangeSet@1.1988.69.186, 2004-10-19 08:09:17-07:00, benh@kernel.crashing.org
	  [PATCH] rework radeonfb blanking
	  
	  This patch cleans up some old cruft in the manipulation of the LVDS
	  interface registers and fixes the blanking code to work with various DVI
	  flat panels.
	  
	  Since this is all very sensitive stuff, I'm posting the patch here for
	  testing before submitting it upstream, though Andrew is welcome to put it
	  in -mm.
	  
	  It also fix some problems with getting the right PLL setup on recent Mac
	  laptops, replacing the old hard coded list of values with cleaner code that
	  "probes" the PLL setup done by the firmware.
	  
	  Signed-off-by: Andrew Morton <akpm@osdl.org>
	  Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Ben, any suggestions for Thomas? 

		Linus
