Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUKAMIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUKAMIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUKAMIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:08:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41393 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261760AbUKAMIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:08:05 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Z Smith <plinius@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4185489B.5070604@comcast.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099176319.25194.10.camel@localhost.localdomain>
	 <41843E10.1040800@comcast.net>
	 <1099235990.16414.12.camel@localhost.localdomain>
	 <4185489B.5070604@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099307105.17126.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 11:05:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 20:18, Z Smith wrote:
> My laptop's framebuffer is only 800x600x24bpp VESA, or 1406kB.
> But look at what X is doing:

X has the frame buffer mapped as reported by VESA sizing not the 
minimal for the mode. (Think about RandR and you'll see why)

> root       632  6.1 17.5 22024 16440 ?       S    12:05   0:17 X :0
> 
> The more apps in use, the more memory is used, but at the moment
> I've only got xterm, rxvt, thunderbird, xclock and xload. My wm is
> blackbox which is using 5 megs.

Mostly shared with the other apps, you did remember to divide each page
by the number of users ?

> Also, just curious but why would memory-mapped I/O be counted
> in the memory usage anyway? Shouldn't there be a separate number
> for framebuffer memory and the like?

Actually there is probably not enough information in /proc to do the
maths on it. The kernel itself has a clear idea which vma's are not
backed by ram in the usual sense as they are marked VM_IO.

> > I've helped write tiny UI kits (take a look at nanogui for example) but
> > they don't have the flexibility of X.
> 
> In my experience, most of the flexibility is not necessary for
> 97% of what I do, yet it evidently costs a lot in memory usage
> and speed.

So my X server is 1Mb larger because I can run networked apps and play
bzflag. Suits me as a tradeoff - I'm not saying it always is the right
decision - nanogui works well in restricted environments like video
recorders for example.

