Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265580AbSJXR6b>; Thu, 24 Oct 2002 13:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSJXR6b>; Thu, 24 Oct 2002 13:58:31 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:59398 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265580AbSJXR63>; Thu, 24 Oct 2002 13:58:29 -0400
Date: Thu, 24 Oct 2002 19:04:35 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
Message-ID: <20021024180435.GB8915@compsoc.man.ac.uk>
References: <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB83156.5000402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB83156.5000402@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *184mLT-0006Ku-00*kKa4NxjTb1s* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 12:43:50PM -0500, Corey Minyard wrote:

> #define NOTIFY_DONE        0x0000        /* Don't care */
> #define NOTIFY_OK        0x0001        /* Suits me */
> #define NOTIFY_STOP_MASK    0x8000        /* Don't call further */
> 
> I'mt taking these to mean that NOTIFY_DONE means you didn't handle it, 
> NOTIFY_OK means you did handle it, and you "or" on NOTIFY_STOP_MASK if 
> you want it to stop.  I'm thinking that stopping is probably a bad idea, 
> if the NMI is really edge triggered.

> There's a comment in do_nmi() that says that the NMI is edge triggered. 

So there is. Darn. You could special case default_do_nmi, only printing
out "Unknown NMI" iff the reason inb() check fails, /and/ no previous
handlers set handled. Theoretically we have to take the cost of the
inb() every time otherwise we can lose one of the NMISC-based things in
default_do_nmi ... I can always see if this makes a noticable practical
difference for oprofile under high interrupt load

(I also need to be able to remove the NMI watchdog handler, but that's
an oprofile-specific problem).

Perhaps things will end being best to leave the current fast-path thing,
but we should make sure that we've explored the possibilities of
removing it first ;)

thanks
john

-- 
"This is playing, not work, therefore it's not a waste of time."
	- Zath
