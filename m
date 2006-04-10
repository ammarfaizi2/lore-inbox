Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWDJRdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWDJRdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWDJRdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:33:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:11026 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751101AbWDJRdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:33:18 -0400
Date: Mon, 10 Apr 2006 19:33:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Aubrey <aubreylee@gmail.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Message-ID: <20060410173306.GB8612@mars.ravnborg.org>
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com> <20060410112817.GE12896@harddisk-recovery.com> <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 09:27:18PM +0800, Aubrey wrote:
> On 4/10/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> > On Mon, Apr 10, 2006 at 06:16:56PM +0800, Aubrey wrote:
> > Why would you write a driver in assembly in the first place? That makes
> > it highly unportable, I bet you can't compile your driver for x86 and
> > ARM from the same source. There are only four drivers in the whole
> > kernel tree that have an assembly part, but those are so tied to their
> > platform (Acorn, Amiga) that they aren't portable anyway.
> 
> Yes, the driver isn't portable. I'm working on the blackfin linux
> system. The driver is written mostly by c except one codec. You know,
> blackfin has DSP instruction set, so I write the codec in assembly to
> improve my driver's performance.
> >
> > I haven't seen your Makefile so I can't see what's wrong, but see
> > drivers/scsi/arm/Makefile for an example.
> >
> Makefile is simple.
> ===============================
> ----snip----
> obj-$(CONFIG_FB_BFIN_7171)	  += bfin_ad7171fb.o rgb2ycbcr.o
> ----snip----
> ===============================
> There are two files, bfin_ad7171fb.c and rgb2ycbcr.S under the folder
> " ./drivers/video".
> It should be OK because the driver can pass the compilation when
> select it as built-in.
What you say with the above is that you want to create two modules.
One module named: bfin_ad7171fb
and another module named: rgb2ycbcr

But kbuild does not support creating modules based on a .S file alone.
What I expect you to say is that you have one module named: bfin_7171
this is expressed like this:

obj-$(CONFIG_FB_BFIN_7171) += bfin_7171.o
bfin_7171-y := bfin_ad7171fb.o rgb2ycbcr.o

And then it works with your .S file.

	Sam
