Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135219AbQLIBhO>; Fri, 8 Dec 2000 20:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135327AbQLIBhE>; Fri, 8 Dec 2000 20:37:04 -0500
Received: from Cantor.suse.de ([194.112.123.193]:63245 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135219AbQLIBg4>;
	Fri, 8 Dec 2000 20:36:56 -0500
Date: Sat, 9 Dec 2000 02:06:27 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        baettig@scs.ch, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock question (2.2)
Message-ID: <20001209020627.A30716@gruyere.muc.suse.de>
In-Reply-To: <20001209011457.A30226@gruyere.muc.suse.de> <Pine.BSF.4.21.0012081618440.72881-100000@beppo.feral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSF.4.21.0012081618440.72881-100000@beppo.feral.com>; from mjacob@feral.com on Fri, Dec 08, 2000 at 04:19:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 04:19:45PM -0800, Matthew Jacob wrote:
> 
> > > 
> > > On Fri, 8 Dec 2000, Alan Cox wrote:
> > > 
> > > > > Yes, and I believe that this is what's broken about the SCSI midlayer. The the
> > > > > io_request_lock cannot be completely released in a SCSI HBA because the flags
> > > > 
> > > > You can drop it with spin_unlock_irq and that is fine. I do that with no
> > > > problems in the I2O scsi driver for example
> > > 
> > > I am (like, I think I *finally* got locking sorta right in my QLogic driver),
> > > but doesn't this still leave ints blocked for this CPU at least?
> > 
> > spin_unlock_irq() does a __sti()
> > spin_unlock() doesn't. 
> 
> Umm. Okay, but you haven't changed your processor priority though, right?

There is no concept of spl levels in Linux ;)  It only knows about 
interrupts on or off.

> (I just don't *get* i386 stuff... I'll go off and ponder SParc code - &that& I
> understand).

It is very simple[1] : interrupts can be on or off.
__cli() disables them, __sti() enables them again.

When you want nesting use the _flags versions.


-Andi
[1] in linux, there are some architecture extensions for interrupt priorities, but linux
doesn't use them.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
