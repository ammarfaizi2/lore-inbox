Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSLIKVZ>; Mon, 9 Dec 2002 05:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSLIKVZ>; Mon, 9 Dec 2002 05:21:25 -0500
Received: from poup.poupinou.org ([195.101.94.96]:28956 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265051AbSLIKVY>; Mon, 9 Dec 2002 05:21:24 -0500
Date: Mon, 9 Dec 2002 11:28:58 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021209102858.GA14882@poup.poupinou.org>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz> <20021206185702.GE17595@poup.poupinou.org> <20021208194944.GB19604@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021208194944.GB19604@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel:

On Sun, Dec 08, 2002 at 08:49:45PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > > Doesn't that imply your fix is broken to begin with?
> > > > > 
> > > > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > > > overdesign to me, OTOH if you do the work it is okay with me.
> > > > 
> > > > You broke the design. S3 support was developed long before swsusp was in 
> > > > the kernel, and completely indpendent of it. It should have remained that 
> > > > way. 
> > > > 
> > > > S3 support is a subset of what is need for S4 support. 
> > > 
> > > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > > but not for S4. Big part of driver support is only needed for S3.
> > > 
> > > > swsusp is an implementation of S4 support. In theory, there could be 
> > > > multiple implementations that all use the same core (saving/restoring 
> > > > state). 
> > > 
> > > There were patches for S4bios floating around, but it never really
> > > worked, IIRC.
> > 
> > No.  It work.  I do not resubmmited patches because I think that
> > swsusp is better.
> 
> I think that s4bios is nice to have. Its similar to S3 and easier to
> set up than swsusp... It would be nice to have it.

for me:
pros:
-----
1- it is really really more easier to implement than S4;
2- we can even have it with 2.4 kernels (it seems that it work without
the need of freezing processes, but I suspect that this statement
is 'wrong' by nature).

cons:
-----
1- it is much slower (especially at save time) than your swsusp;
2- end users must setup their systems (need to create a suspend partition,
or to keep a vfat partition as the really first one (/dev/hda1));
3- we use a bios function.  Actually, everything can happen...

That why I prefer swsusp at this time, or any other implementation of S4 (I
think about an implementation of S4 via LKCD).

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
