Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSIJT20>; Tue, 10 Sep 2002 15:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSIJT20>; Tue, 10 Sep 2002 15:28:26 -0400
Received: from waste.org ([209.173.204.2]:43228 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318045AbSIJT2Z>;
	Tue, 10 Sep 2002 15:28:25 -0400
Date: Tue, 10 Sep 2002 14:32:28 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
       david-b@pacbell.net, mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020910193228.GL31597@waste.org>
References: <20020910.111627.00809211.davem@redhat.com> <Pine.LNX.4.44.0209101132320.3280-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209101132320.3280-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 11:40:27AM -0700, Linus Torvalds wrote:
> 
> On Tue, 10 Sep 2002, David S. Miller wrote:
> >    
> >    IMO we should have ASSERT() and OHSHIT(),
> > 
> > I fully support the addition of an OHSHIT() macro.
> 
> Oh, please no. We'd end up with endless asserts in the networking layer, 
> just because David would find it amusing. 
> 
> I can just see it now - code bloat hell.
> 
> And no, I still don't like ASSERT().
> 
> I think the approach should clearly spell what the trouble level is:
> 
> 	DEBUG(x != y, "x=%d, y=%d\n", x, y);
> 
> 	WARN(x != y, "crap happens: x=%d y=%d\n", x, y);
> 
> 	FATAL(x != y, "Aiee: x=%d y=%d\n", x, y);
> 
> where the DEBUG one gets compiled out normally (or has some nice per-file
> way of being enabled/disabled - a perfect world would expose the on/off in
> devicefs as a per-file entity when kernel debugging is on), WARN continues
> but writes a message (and normally does _not_ get compiled out), and FATAL
> is like our current BUG_ON().

Which still leaves the question, does it really make sense for
FATAL/BUG to forcibly kill the machine? If the bug is truly fatal,
presumably the machine kills itself in short order anyway, otherwise
we might have a shot at recording the situation. A more useful
distinction might be in terms of risk of damaging filesystems (or perhaps
hardware) if we continue, something like BROKEN/DANGEROUSLY_BROKEN.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
