Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSEXSXp>; Fri, 24 May 2002 14:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317234AbSEXSXo>; Fri, 24 May 2002 14:23:44 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:19127 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314707AbSEXSXn>;
	Fri, 24 May 2002 14:23:43 -0400
Date: Fri, 24 May 2002 20:23:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: asm/timex.h
Message-ID: <20020524202333.B21716@ucw.cz>
In-Reply-To: <20020524193345.A21559@ucw.cz> <20020524184903.B24780@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 06:49:03PM +0100, Christoph Hellwig wrote:
> On Fri, May 24, 2002 at 07:33:45PM +0200, Vojtech Pavlik wrote:
> > Hi!
> > 
> > I have several questions about asm/timex.h
> > 
> > 1) Who uses it? The kernel certainly doesn't. Perhaps NTP?
> 
> The kernel does.  Thanks to the sched.h mess it's even implictly
> included in almost any file..
> 
> > 3) What if an architecture doesn't have a compile-time known
> >    CLOCK_TICK_RATE? I suppose I cannot just #define it to a variable,
> >    because the kernel doesn't use it, and that probably means userland
> >    does ...
> 
> The kernel DOES use it.  grep(1) is your friend.

# grep -rw FINETUNE * | grep -v timex.h
# grep -rw CLOCK_TICK_FACTOR * | grep -v timex.h
# grep -rw CLOCK_TICK_RATE * | grep -v timex.h
drivers/char/ftape/lowlevel/ftape-calibr.c:     return (10000 * count) / ((CLOCK_TICK_RATE + 50) / 100);

The only interesting place where is CLOCK_TICK_RATE used is in linux/timex.h
to define LATCH. Which subsequently is only used in arch specific code
and ftape again.

Ftape's use of it is buggy, because it lacks the needed locking.

So, it seems like CLOCK_TICK_RATE isn't needed by non-arch-specific
code.

And FINETUNE isn't used at all.

But ... the fact that kernel uses it ... probably doesn't mean that
userland doesn't.

-- 
Vojtech Pavlik
SuSE Labs
