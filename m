Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTAUXYZ>; Tue, 21 Jan 2003 18:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbTAUXYZ>; Tue, 21 Jan 2003 18:24:25 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:15495 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S267248AbTAUXYV>; Tue, 21 Jan 2003 18:24:21 -0500
Message-ID: <3E2DD8CB.5B984772@attbi.com>
Date: Tue, 21 Jan 2003 18:33:31 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: posix timers patch comments.
References: <Pine.LNX.4.33L2.0301210952330.30777-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Hi Jim,
> 
> I'm reviewing both George's and your POSIX/high-res-timers patches.
> I might not send you comments every time that I come across something,
> and I might not cc lkml on every comment (unless you want me to).
> 
> Anyway, here's a beginning.
> 
> In functions get_eip(), check_expiry(), and run_posix_timers(),
> the <regs> parameter is a void *.  Linus generally doesn't like
> void * parameters, so they should be avoided as much as possible,
> and I don't see any reason that <regs> in all of these can't be
> declared as <struct pt_regs *> instead of <void *>.  Is there a
> good reason?
> 
> BTW, when do expect to have any updated patches?
> 
> Is your email address changing to @comcast.net?

Hi Randy,

It makes sense to include lkml in the discussion.  It's an
interesting balancing act.  If you openly criticize code that you 
hope will be included in the kernel, you risk having your arguments
used as a reason for its rejection.  If there is no visible discussion,
the patch will be perceived as un-reviewed.

The code that uses get_eip() is just debug.  It may go away soon.
I was feeling lazy and didn't want to chase down the header files needed
to for "struct pt_regs".  I just made the change and it was easy.
It turns out that pt_regs was already defined. I also found the
instruction_pointer() macro so I can get rid of the get_eip() function I
added.  The timer code has to deal with timer overruns so it always
calculates the amount of time that a time interrupt is delayed.  I'm logging
the EIP values which correspond to these long interrupt lockouts.

I'm not sure when I will do the next patch.  I only have a few small
changes in the queue.  I'm tempted to put it off a few days.

I'm hoping that Comcast won't make me change email addresses.

Jim Houston
