Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274522AbRI1ANK>; Thu, 27 Sep 2001 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274909AbRI1ANA>; Thu, 27 Sep 2001 20:13:00 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:23563 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274522AbRI1AMm>; Thu, 27 Sep 2001 20:12:42 -0400
Message-ID: <3BB3BFF3.F553DA2F@osdlab.org>
Date: Thu, 27 Sep 2001 17:10:27 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Cruise <acruise@infowave.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81B0@earth.infowave.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Cruise wrote:
> 
> From: Randy.Dunlap [mailto:rddunlap@osdlab.org]
> 
> > Sounds like our 2.4.10's are different then.  :)
> 
> It's possible... I got mine from kernel.org, applied the preemptible-kernel
> and ext3fs patches, and  compiled with RH's "kgcc"
> 
> > Without this patch, mine didn't create /proc/apm, register as a
> > misc device, or create the kapmd-idle kernel thread.
> > Must be a distro thingy.
> 
> Did you have apm=on set before, or nothing at all?  Here's what I've seen so
> far:

I have "apm=on apm=debug".

> In all cases, I've got apm compiled into the kernel, not a module.

Same here.

> - With 2.4.10, Before your patch, with no apm= option in the kernel command
> line, APM in general works, but suspend doesn't.  When I append apm=on or
> apm=off to my kernel command line, APM is disabled.
> - With 2.4.10, After applying your patch, apm=on no longer disables APM, but
> suspend still doesn't work.
> 
> > Return of EAGAIN from the SUSPEND ioctl means that
> > send_event() failed, which means that some device driver
> > didn't want suspend to happen...which means that some
> > device driver got changed. :(
> 
> Just for fun, I tried removing all of my loaded 2.4.10 modules one by one,
> and attempting 'apm --suspend' in between, and still had the same problem
> when I got down to the bare minimum (ext3 and jbd)
> 
> > What was the last working kernel AFAUK (for this APM stuff)?
> 
> I just checked, and the RH-compiled 2.4.9-0.5 doesn't suspend either.  It
> appears to suffer from the same "apm=on" command-line bug too.  I'm gonna go
> try the 2.4.7 from RH's "Roswell" beta now.

OK, thanks for testing that.

I suspect that it's something like a single driver change (not apm,
but PM-support in a driver).  How many I/O-device drivers do you
use?  Would it be difficult to try to isolate which one may be
faulty?

~Randy
