Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132374AbQKKUgC>; Sat, 11 Nov 2000 15:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132449AbQKKUfw>; Sat, 11 Nov 2000 15:35:52 -0500
Received: from Cantor.suse.de ([194.112.123.193]:11528 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132448AbQKKUfd>;
	Sat, 11 Nov 2000 15:35:33 -0500
Date: Sat, 11 Nov 2000 21:35:31 +0100
From: Andi Kleen <ak@suse.de>
To: Robert Lynch <rmlynch@best.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Peter Samuelson <peter@cadcamlab.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111213531.A31570@gruyere.muc.suse.de>
In-Reply-To: <3A0C86B3.62DA04A2@best.com> <20001110234750.B28057@wire.cadcamlab.org> <20001111153036.A28928@gruyere.muc.suse.de> <3A0D89F7.1CDC3B68@best.com> <20001111193012.A30963@gruyere.muc.suse.de> <3A0D9690.E55465F4@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0D9690.E55465F4@best.com>; from rmlynch@best.com on Sat, Nov 11, 2000 at 10:57:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 10:57:20AM -0800, Robert Lynch wrote:
> Andi Kleen wrote:
> > 
> > On Sat, Nov 11, 2000 at 10:03:35AM -0800, Robert Lynch wrote:
> > > sys_nfsservctl                      80     1060     980  +1225.0
> > > dump_extended_fpu                    8       84      76  +950.00
> > > get_fpregs                          36      372     336  +933.33
> > > schedule_tail                       16      144     128  +800.00
> > > set_fpregs                          36      272     236  +655.56
> > > tty_release                         16      108      92  +575.00
> > > ext2_write_inode                    20      108      88  +440.00
> > > ...
> > >
> > > I have surpressed my momentary urge to post the whole thing, so
> > > as not to arouse the legendary ire of this list. :)
> > 
> > Ordering by byte delta is more useful than by Change to get the real
> > pigs, because Change gives high values even for relatively small changes
> > (like 8 -> 84)
> > 
> > Also note that some of the output is bogus due to inaccurate nm output
> > (bloat-o-meter relies on nm)
> > 
> > -Andi
> 
> Yer right, here's a biggie I missed:

That is the slow path of the spinlocks needed for fine grained SMP 
locking. Not really surprising that that it bloated a bit, given all
the locking work that went into 2.4.

>From looking at my UP configuration (where vmlinux's text segment has bloated
by about 500K between 2.2 and 2.4) there are no obvious big pigs, just lots of 
small stuff that adds together.



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
