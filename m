Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWDJTab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDJTab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWDJTab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:30:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6924 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932123AbWDJTab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:30:31 -0400
Date: Mon, 10 Apr 2006 21:30:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Adrian Bunk <bunk@stusta.de>, Aubrey <aubreylee@gmail.com>,
       Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Message-ID: <20060410193024.GA11292@mars.ravnborg.org>
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com> <20060410112817.GE12896@harddisk-recovery.com> <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com> <20060410174252.GD2408@stusta.de> <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com> <20060410182421.GA22440@mars.ravnborg.org> <Pine.LNX.4.61.0604101506430.26625@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604101506430.26625@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 03:12:55PM -0400, linux-os (Dick Johnson) wrote:
> 
> On Mon, 10 Apr 2006, Sam Ravnborg wrote:
> 
> > On Mon, Apr 10, 2006 at 02:04:59PM -0400, linux-os (Dick Johnson) wrote:
> >
> >> Can't he just put his own private compile definition in his
> >> own Makefile?
> >>
> >> %.o:	%.S
> >>  	as -o $@ $<
> >
> > That would never generate a module anyway. And kbuild support building
> > .o from .S with all the kbuild argument chechking etc.
> > Doing it so would be wrong.
> >
> > 	Sam
> >
> 
> 
> Really?? Here is a Makefile that has been known to work for sometime.
> As you can clearly see, it has lots of ".S" files. The last compile
> was on Linux-2.6.15.4. If current kernel building procedures prevents
> the assembly of assembly-language files and requires that the kernel
> modules be written entirely in 'C', then it is broken beyond all
> belief and must be fixed.
kbuild does not support a single-file module being written entirely in
assembler.
kbuild obviously support multi file modules where one file is in
assembler.

In your example you generate a multi file module where some files are in
assembler - supported.
And the point was that one should NOT define private rules like:
%.o:	%.S
	as -o $@ $<

If there is a valid need for such stuff - then kbuild needs to be fixed.
But I have yet to see a need like this.

I know several external modules plays all sort of tricks to avoid using
kbuild infrastructure - I recall you have posted such receipts before.
Recently posted loop-aes is another example (if USE_KBUILD is not set).

	Sam
