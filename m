Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTAOKbZ>; Wed, 15 Jan 2003 05:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTAOKbY>; Wed, 15 Jan 2003 05:31:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22544 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266135AbTAOKbY>; Wed, 15 Jan 2003 05:31:24 -0500
Date: Wed, 15 Jan 2003 10:40:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] add module reference to struct tty_driver
Message-ID: <20030115104016.E31372@flint.arm.linux.org.uk>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <20030115100001.D31372@flint.arm.linux.org.uk> <200301151030.h0FAU3ox000873@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301151030.h0FAU3ox000873@darkstar.example.net>; from john@grabjohn.com on Wed, Jan 15, 2003 at 10:30:03AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 10:30:03AM +0000, John Bradford wrote:
> > > Woah!  Hm, this is going to cause lots of problems in drivers that have
> > > been assuming that the BKL is grabbed during module unload, and during
> > > open().  Hm, time to just fallback on the argument, "module unloading is
> > > unsafe" :(
> > 
> > Note that its the same in 2.4 as well.  iirc, the BKL was removed from
> > module loading/unloading sometime in the 2.3 timeline.
> 
> Surely no recent code should be making that assumption anyway - the
> BKL is being removed all over the place.

The TTY layer isn't "recent code", its "very old code", and (IMO)
removing the BKL from the TTY layer is a far from trivial matter.

I believe at this point in the 2.5 cycle, we should not be looking
to remove the BKL.  We should be looking to fix the problems we know
about.  That basically means:

- module refcounting
- interrupt races
- any other races (eg, tty_register_driver / tty_unregister_driver)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

